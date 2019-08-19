-- ----------------------------------------------------------------
-- de0_nano/cyclone4/sdram/src/de0_nano.vhd
--
-- 8/19/2014 D. W. Hawkins (dwh@ovro.caltech.edu)
--
-- Terasic DE0-nano Cyclone IV FPGA kit 'sdram' design.
--
-- * LED count (using the 50MHz oscillator)
-- * A PLL to generate;
--   - 100MHz for the Qsys system
--   - 100MHz phase-shifted -90-degrees for the SDRAM clock
-- * A Qsys system containing;
--   - Altera JTAG-to-Avalon-MM master
--   - Altera SDRAM controller
--
-- The design does not make use of the accelerometer, ADC,
-- or GPIOs.
--
-- ----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-- ----------------------------------------------------------------

entity de0_nano is
	port (
		-- --------------------------------------------------------
		-- Clock
		-- --------------------------------------------------------
		--
		-- 50MHz oscillator
		clkin_50MHz : in    std_logic;

		-- --------------------------------------------------------
		-- User I/O
		-- --------------------------------------------------------
		--
		-- Reset (KEY0, DEV_CLRn)
		ext_rstN    : in    std_logic;

		-- Push button (KEY1)
		pb          : in    std_logic;

		-- Switches
		sw          : in    std_logic_vector(3 downto 0);

		-- LEDs
		led         : out   std_logic_vector(7 downto 0);

		-- --------------------------------------------------------
		-- Accelerometer and I2C EEPROM
		-- --------------------------------------------------------
		--
		-- The accelerometer can be accessed in I2C mode (csN high),
		-- or in 3-wire SPI mode (csN, sck, sdio).
		--

		-- Accelerometer
		accel_csN   : out   std_logic;
		accel_int   : in    std_logic;

		-- I2C clk/data or 3-wire SPI clk/data
		i2c_sck     : inout std_logic;
		i2c_sda     : inout std_logic;

		-- --------------------------------------------------------
		-- ADC
		-- --------------------------------------------------------
		--
		adc_csN    : out   std_logic;
		adc_sck    : out   std_logic;
		adc_mosi   : out   std_logic;
		adc_miso   : in    std_logic;

		-- --------------------------------------------------------
		-- EPCS
		-- --------------------------------------------------------
		--
		-- These dual-purpose pins must be configured for use in
		-- the device options as "Use as regular I/O".
		--
		epcs_csN   : out   std_logic;
		epcs_sck   : out   std_logic;
		epcs_mosi  : out   std_logic;
		epcs_miso  : in    std_logic;

		-- --------------------------------------------------------
		-- SDR SDRAM
		-- --------------------------------------------------------
		--
		-- Clock
		sdram_clk  : out   std_logic;

		-- Controls
		sdram_cke  : out   std_logic;
		sdram_csN  : out   std_logic;
		sdram_rasN : out   std_logic;
		sdram_casN : out   std_logic;
		sdram_weN  : out   std_logic;
		sdram_dqm  : out   std_logic_vector(1 downto 0);

		-- Address
		sdram_ba   : out   std_logic_vector( 1 downto 0);
		sdram_addr : out   std_logic_vector(12 downto 0);

		-- Data
		sdram_dq   : inout std_logic_vector(15 downto 0);

		-- --------------------------------------------------------
		-- GPIO connectors
		-- --------------------------------------------------------
		--
		-- GPIO-A
		gpin_a   : in    std_logic_vector( 1 downto 0);
		gpio_a   : inout std_logic_vector(33 downto 0);

		-- GPIO-B
		gpin_b   : in    std_logic_vector( 1 downto 0);
		gpio_b   : inout std_logic_vector(33 downto 0);

		-- GPIO-C
		gpin_c   : in    std_logic_vector( 2 downto 0);
		gpio_c   : inout std_logic_vector(12 downto 0)

	);
end entity;

-- ----------------------------------------------------------------

architecture sdram of de0_nano is

	-- ------------------------------------------------------------
	-- Components
	-- ------------------------------------------------------------
	--
	component sync is
		generic (
			RESET_STATE : std_logic;
			PIPELINE    : natural
		);
		port (
			clk   : in  std_logic;
			rstN  : in  std_logic;
			d     : in  std_logic;
			q     : out std_logic
		);
	end component;

	component pll is
		port (
			areset  : in  std_logic;
			inclk0  : in  std_logic;
			c0      : out std_logic;
			c1      : out std_logic;
			locked  : out std_logic
		);
	end component;

	component qsys_system is
		port (
			clk_clk       : in    std_logic;
			reset_reset_n : in    std_logic;
			sdram_cs_n    : out   std_logic;
			sdram_cas_n   : out   std_logic;
			sdram_ras_n   : out   std_logic;
			sdram_we_n    : out   std_logic;
			sdram_cke     : out   std_logic;
			sdram_addr    : out   std_logic_vector(12 downto 0);
			sdram_ba      : out   std_logic_vector( 1 downto 0);
			sdram_dqm     : out   std_logic_vector( 1 downto 0);
			sdram_dq      : inout std_logic_vector(15 downto 0)
		);
	end component;

	-- ------------------------------------------------------------
	-- Parameters
	-- ------------------------------------------------------------
	--
	-- 100MHz clock
	constant CLK_FREQUENCY : real := 100.0e6;

	-- Counter count required for ~0.5s pulse time on first LED
	constant COUNT_VALUE : real := 0.5*CLK_FREQUENCY;

	-- Counter width required (to blink 7 of the 8 LEDs)
	constant COUNT_WIDTH : integer :=
		integer(ceil(log2(COUNT_VALUE-1.0))) + 6;

	-- ------------------------------------------------------------
	-- Signals
	-- ------------------------------------------------------------
	--
	-- Synchronized reset
	signal rstN : std_logic;

	-- 100MHz system clock
	signal clk : std_logic;

	-- PLL locked status
	signal pll_locked : std_logic;

	-- Counter
	signal count : unsigned(COUNT_WIDTH-1 downto 0);

	-- Most significant bits of the counter
	alias led_count is count(COUNT_WIDTH-1 downto COUNT_WIDTH-7);

begin

	-- ------------------------------------------------------------
	-- PLL
	-- ------------------------------------------------------------
	--
	u1: pll
		port map (
			areset  => (not ext_rstN),
			inclk0  => clkin_50MHz,
			c0      => clk,
			c1      => sdram_clk,
			locked  => pll_locked
		);

	-- ------------------------------------------------------------
	-- Reset synchronizer
	-- ------------------------------------------------------------
	--
	u2: sync
        generic map (
            RESET_STATE => '0',
            PIPELINE    => 2
        )
        port map (
            clk   => clk,
            rstN  => (ext_rstN and pll_locked),
            d     => '1',
            q     => rstN
        );

	-- ------------------------------------------------------------
	-- Qsys system
	-- ------------------------------------------------------------
	--
    u3: qsys_system
        port map (
            clk_clk       => clk,
            reset_reset_n => rstN,
            sdram_cs_n    => sdram_csN,
            sdram_ras_n   => sdram_rasN,
            sdram_cas_n   => sdram_casN,
            sdram_we_n    => sdram_weN,
            sdram_cke     => sdram_cke,
            sdram_addr    => sdram_addr,
            sdram_ba      => sdram_ba,
            sdram_dqm     => sdram_dqm,
            sdram_dq      => sdram_dq
        );

	-- ------------------------------------------------------------
	-- LED counter
	-- ------------------------------------------------------------
	--
	process(clk, rstN)
	begin
		if (rstN = '0') then
			count <= (others => '0');
		elsif rising_edge(clk) then
			count <= count + 1;
		end if;
	end process;
	led(6 downto 0) <= std_logic_vector(led_count);

	-- Connect the push button to the MSB of the LEDs
	-- * the LED is off when the button is not pressed
	led(7) <= not pb;

	-- ============================================================
	-- Unused outputs
	-- ============================================================
	--
	-- Accelerometer
	accel_csN  <= '1';

	-- I2C
	i2c_sck    <= 'Z'; -- External pull-up
	i2c_sda    <= 'Z'; -- External pull-up

	-- ADC
	adc_csN    <= '1';
	adc_sck    <= '0';
	adc_mosi   <= '0';

	-- EPCS
	epcs_csN   <= 'Z';
	epcs_sck   <= 'Z';
	epcs_mosi  <= 'Z';

	-- SDR SDRAM
--	sdram_clk  <= '0';
--	sdram_cke  <= '0';
--	sdram_csN  <= '1';
--	sdram_rasN <= '1';
--	sdram_casN <= '1';
--	sdram_weN  <= '1';
--	sdram_dqm  <= (others => '1');
--	sdram_ba   <= (others => '0');
--	sdram_addr <= (others => '0');
--	sdram_dq   <= (others => '0');

	-- GPIO
	gpio_a     <= (others => 'Z');
	gpio_b     <= (others => 'Z');
	gpio_c     <= (others => 'Z');

end architecture;
