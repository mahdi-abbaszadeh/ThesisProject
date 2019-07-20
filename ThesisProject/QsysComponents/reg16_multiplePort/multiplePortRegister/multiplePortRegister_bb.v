
module multiplePortRegister (
	clk_clk,
	q1_export,
	q2_export,
	resetn_reset_n);	

	input		clk_clk;
	output	[15:0]	q1_export;
	output	[15:0]	q2_export;
	input		resetn_reset_n;
endmodule
