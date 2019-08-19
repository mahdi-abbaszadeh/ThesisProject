-- ----------------------------------------------------------------
-- sync.vhd
--
-- 3/16/2007 D. W. Hawkins (dwh@ovro.caltech.edu)
--
-- A synchronizer for active high or low external signals.
--
-- The reset state for the synchronizer is the inactive level.
-- The generic is used to generate the appropriate reset state.
--
-- ----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-- ----------------------------------------------------------------

entity sync is
	generic (
		-- Reset state
		RESET_STATE : std_logic := '0'; -- '0' for active low sync

		-- Synchronizer pipeline delays (2 or more DFFs)
		PIPELINE    : natural   := 2
	);
    port (
        clk   : in  std_logic;
        rstN  : in  std_logic;
        d     : in  std_logic;
        q     : out std_logic
    );
end entity;

-- ----------------------------------------------------------------

architecture behavioral of sync is
    signal d_meta : std_logic_vector(PIPELINE-1 downto 0) :=
    	(others => RESET_STATE);
begin
	process(clk, rstN)
	begin
		if (rstN = '0') then
			d_meta <= (others => RESET_STATE);
		elsif (clk'event and clk = '1') then
			d_meta(0) <= d;
			for i in 1 to PIPELINE-1 loop
				d_meta(i) <= d_meta(i-1);
			end loop;
		end if;
	end process;
	q <= d_meta(PIPELINE-1);
end architecture;

