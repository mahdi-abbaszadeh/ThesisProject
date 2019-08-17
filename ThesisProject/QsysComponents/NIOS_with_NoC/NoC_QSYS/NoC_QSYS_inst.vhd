	component NoC_QSYS is
		port (
			clk_clk : in std_logic := 'X'  -- clk
		);
	end component NoC_QSYS;

	u0 : component NoC_QSYS
		port map (
			clk_clk => CONNECTED_TO_clk_clk  -- clk.clk
		);

