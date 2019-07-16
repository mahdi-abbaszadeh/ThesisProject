	component multiplePortRegister is
		port (
			clk_clk        : in  std_logic                     := 'X'; -- clk
			q1_export      : out std_logic_vector(15 downto 0);        -- export
			q2_export      : out std_logic_vector(15 downto 0);        -- export
			resetn_reset_n : in  std_logic                     := 'X'  -- reset_n
		);
	end component multiplePortRegister;

	u0 : component multiplePortRegister
		port map (
			clk_clk        => CONNECTED_TO_clk_clk,        --    clk.clk
			q1_export      => CONNECTED_TO_q1_export,      --     q1.export
			q2_export      => CONNECTED_TO_q2_export,      --     q2.export
			resetn_reset_n => CONNECTED_TO_resetn_reset_n  -- resetn.reset_n
		);

