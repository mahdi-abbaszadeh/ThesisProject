module adaptor (
	clock,
	reset,

	reaData_00,
	read_00,
	irq_00,
	writeData_00,
	write_00,
	waiteRequest_00,

	reaData_01,
	read_01,
	irq_01,
	writeData_01,
	write_01,
	waiteRequest_01,

	reaData_10,
	read_10,
	irq_10,
	writeData_10,
	write_10,
	waiteRequest_10,

	reaData_11,
	read_11,
	irq_11,
	writeData_11,
	write_11,
	waiteRequest_11
);

parameter DataWidth = 8;

input clock, reset;

input read_00, write_00;
input [DataWidth - 1:0] writeData_00;
output[DataWidth - 1:0] reaData_00;
output irq_00, waiteRequest_00;

input read_01, write_01;
input [DataWidth - 1:0] writeData_01;
output[DataWidth - 1:0] reaData_01;
output irq_01, waiteRequest_01;

input read_10, write_10;
input [DataWidth - 1:0] writeData_10;
output[DataWidth - 1:0] reaData_10;
output irq_10, waiteRequest_10;

input read_11, write_11;
input [DataWidth - 1:0] writeData_11;
output[DataWidth - 1:0] reaData_11;
output irq_11, waiteRequest_11;

wire fifo_wr_en_00, fifo_full_00, fifo_empty_00;
wire[DataWidth - 1:0] fifo_data_in_00;

wire fifo_wr_en_01, fifo_full_01, fifo_empty_01;
wire[DataWidth - 1:0] fifo_data_in_01;

wire fifo_wr_en_10, fifo_full_10, fifo_empty_10;
wire[DataWidth - 1:0] fifo_data_in_10;

wire fifo_wr_en_11, fifo_full_11, fifo_empty_11;
wire[DataWidth - 1:0] fifo_data_in_11;

wire inpSel_00;
wire inpSel_01;
wire inpSel_10;
wire inpSel_11;


//irq assigned to inpEn
assign irq_00 = fifo_wr_en_00;
assign irq_01 = fifo_wr_en_01;
assign irq_10 = fifo_wr_en_10;
assign irq_11 = fifo_wr_en_11;



syn_fifo #(.DATA_WIDTH(DataWidth)) f00 (
	.clk(clock),
	.rst(reset),
	.wr_cs(1),
	.rd_cs(1),
	.rd_en(read_00),
	.wr_en(fifo_wr_en_00),
	.data_in(fifo_data_in_00),
	.full (fifo_full_00),
	.empty(fifo_empty_00),
	.data_out(reaData_00)
	);

syn_fifo #(.DATA_WIDTH(DataWidth)) f01 (
	.clk(clock),
	.rst(reset),
	.wr_cs(1),
	.rd_cs(1),
	.rd_en(read_01),
	.wr_en(fifo_wr_en_01),
	.data_in(fifo_data_in_01),
	.full (fifo_full_01),
	.empty(fifo_empty_01),
	.data_out(reaData_01)
	);

syn_fifo #(.DATA_WIDTH(DataWidth)) f10 (
	.clk(clock),
	.rst(reset),
	.wr_cs(1),
	.rd_cs(1),
	.rd_en(read_10),
	.wr_en(fifo_wr_en_10),
	.data_in(fifo_data_in_10),
	.full (fifo_full_10),
	.empty(fifo_empty_10),
	.data_out(reaData_10)
	);

syn_fifo #(.DATA_WIDTH(DataWidth)) f11 (
	.clk(clock),
	.rst(reset),
	.wr_cs(1),
	.rd_cs(1),
	.rd_en(read_11),
	.wr_en(fifo_wr_en_11),
	.data_in(fifo_data_in_11),
	.full (fifo_full_11),
	.empty(fifo_empty_11),
	.data_out(reaData_11)
	);


NOC n1(
	.Clk(clock),
	.Reset(reset),

	.PE00_InpData	(fifo_data_in_00),
	.PE00_InpEn		(fifo_wr_en_00),
	.PE00_InpReady	(~fifo_full_00),
	.PE00_InpSel	(inpSel_00),

	.PE00_OutpData	(writeData_00),
	.PE00_OutpEn	(write_00),	
	.PE00_OutpReady	(waiteRequest_00),
	.PE00_OutpSel	(1),
	

	.PE01_InpData	(fifo_data_in_01),
	.PE01_InpEn		(fifo_wr_en_01),
	.PE01_InpReady	(~fifo_full_01),
	.PE01_InpSel	(inpSel_01),	
	
	.PE01_OutpData	(writeData_01),
	.PE01_OutpEn	(write_01),	
	.PE01_OutpReady	(waiteRequest_01),
	.PE01_OutpSel	(1),
	

	.PE10_InpData	(fifo_data_in_10),
	.PE10_InpEn		(fifo_wr_en_10),
	.PE10_InpReady	(~fifo_full_10),
	.PE10_InpSel	(inpSel_10),	
	
	.PE10_OutpData	(writeData_10),
	.PE10_OutpEn	(write_10),	
	.PE10_OutpReady	(waiteRequest_10),
	.PE10_OutpSel	(1),
	

	.PE11_InpData	(fifo_data_in_11),
	.PE11_InpEn		(fifo_wr_en_11),
	.PE11_InpReady	(~fifo_full_11),
	.PE11_InpSel	(inpSel_11),	
	
	.PE11_OutpData	(writeData_11),
	.PE11_OutpEn	(write_11),	
	.PE11_OutpReady	(waiteRequest_11),
	.PE11_OutpSel	(1)

	);


endmodule // adaptor
