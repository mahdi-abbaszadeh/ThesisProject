module reg16_multiplePort_avalon_interface (clock, resetn, writedata, readdata, write, read,
byteenable,writedata2, readdata2, write2, read2,
byteenable2, chipselect, chipselect2, Q_export, Q_export2);

// signals for connecting to the Avalon fabric

input clock, resetn, read, write, read2, write2, chipselect, chipselect2;
input[1:0] byteenable, byteenable2;
input[15:0] writedata, writedata2;
output[15:0] readdata, readdata2;

// signal for exporting register contents outside of the embedded system
output[15:0] Q_export, Q_export2;

wire[1:0] local_byteenable, local_byteenable2;
wire[15:0] to_reg, from_reg, to_reg2, from_reg2;

assign to_reg = writedata;
assign to_reg2 = writedata2;

assign local_byteenable = (chipselect & write) ? byteenable : 2'd0;
assign local_byteenable2 = (chipselect2 & write2) ? byteenable2 : 2'd0;

reg16 U1 ( .clock(clock), .resetn(resetn), .D(to_reg), .D2(to_reg2), 
	.byteenable(local_byteenable), .byteenable2(local_byteenable2), .Q(from_reg), .Q2(from_reg2));

assign readdata = from_reg;
assign Q_export = from_reg;

assign readdata2 = from_reg2;
assign Q_export2 = from_reg2;

endmodule 