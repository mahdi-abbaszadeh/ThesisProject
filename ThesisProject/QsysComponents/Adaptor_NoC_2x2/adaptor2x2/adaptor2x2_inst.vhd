	component adaptor2x2 is
		port (
			reset_reset_n : in std_logic := 'X'; -- reset_n
			clk_clk       : in std_logic := 'X'  -- clk
		);
	end component adaptor2x2;

	u0 : component adaptor2x2
		port map (
			reset_reset_n => CONNECTED_TO_reset_reset_n, -- reset.reset_n
			clk_clk       => CONNECTED_TO_clk_clk        --   clk.clk
		);

