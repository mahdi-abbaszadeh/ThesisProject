module wrapper (
	clock,
	reset,

	PE00_InpData	,
	PE00_InpEn		,
	PE00_InpReady	,
	PE00_InpSel		,

	PE00_OutpData	,
	PE00_OutpEn		,
	PE00_OutpReady	,
	PE00_OutpSel	,
	

	PE01_InpData	,
	PE01_InpEn		,
	PE01_InpReady	,
	PE01_InpSel		,
	
	PE01_OutpData	,
	PE01_OutpEn		,
	PE01_OutpReady	,
	PE01_OutpSel	,
	

	PE10_InpData	,
	PE10_InpEn		,
	PE10_InpReady	,
	PE10_InpSel		,
	
	PE10_OutpData	,
	PE10_OutpEn		,
	PE10_OutpReady	,
	PE10_OutpSel	,
	

	PE11_InpData	,
	PE11_InpEn		,
	PE11_InpReady	,
	PE11_InpSel		,
	
	PE11_OutpData	,
	PE11_OutpEn		,
	PE11_OutpReady	,
	PE11_OutpSel

	);

parameter RowNo       = 2;
parameter ColNo       = 2;
parameter PackWidth   = 8;
parameter DataWidth   = 8;
parameter AddrWidth   = 2;
parameter RoChAddr	  = 1;
parameter PhyChAddr	  = 2;
parameter ViChAddr	  = 1;
parameter PhyRoChAddr = 3;		
parameter RoCh		  = 1;
parameter PhyCh		  = 4;
parameter ViCh		  = 1;
parameter PhyRoCh	  = 5;

input clock, reset;

output 	[DataWidth - 1:0] PE00_InpData;
output 	PE00_InpEn;
input  	PE00_InpReady;
output 	[ViChAddr - 1:0] PE00_InpSel;

input 	[DataWidth - 1:0] PE00_OutpData;
input 	PE00_OutpEn;
output 	PE00_OutpReady;
input 	[ViChAddr - 1:0] PE00_OutpSel;


output 	[DataWidth - 1:0] PE01_InpData;
output 	PE01_InpEn;
input  	PE01_InpReady;
output 	[ViChAddr - 1:0] PE01_InpSel;

input 	[DataWidth - 1:0] PE01_OutpData;
input 	PE01_OutpEn;
output 	PE01_OutpReady;
input 	[ViChAddr - 1:0] PE01_OutpSel;


output 	[DataWidth - 1:0] PE10_InpData;
output 	PE10_InpEn;
input  	PE10_InpReady;
output 	[ViChAddr - 1:0] PE10_InpSel;

input 	[DataWidth - 1:0] PE10_OutpData;
input 	PE10_OutpEn;
output 	PE10_OutpReady;
input 	[ViChAddr - 1:0] PE10_OutpSel;


output 	[DataWidth - 1:0] PE11_InpData;
output 	PE11_InpEn;
input  	PE11_InpReady;
output 	[ViChAddr - 1:0] PE11_InpSel;

input 	[DataWidth - 1:0] PE11_OutpData;
input 	PE11_OutpEn;
output 	PE11_OutpReady;
input 	[ViChAddr - 1:0] PE11_OutpSel;


NOC #(
	.RowNo(RowNo),
	.ColNo(ColNo),
	.PackWidth(PackWidth),
	.DataWidth(DataWidth),
	.AddrWidth(AddrWidth),
	.RoChAddr(RoChAddr),
	.PhyChAddr(PhyChAddr),
	.ViChAddr(ViChAddr),
	.PhyRoChAddr(PhyRoChAddr),
	.RoCh(RoCh),
	.PhyCh(PhyCh),
	.ViCh(ViCh),
	.PhyRoCh(PhyRoCh)
	)

	n1(
	.Clk(clock),
	.Reset(reset),

	.PE00_InpData	(PE00_InpData),
	.PE00_InpEn		(PE00_InpEn),
	.PE00_InpReady	(PE00_InpReady),
	.PE00_InpSel	(PE00_InpSel),

	.PE00_OutpData	(PE00_OutpData),
	.PE00_OutpEn	(PE00_OutpEn),
	.PE00_OutpReady	(PE00_OutpReady),
	.PE00_OutpSel	(PE00_OutpSel),
	

	.PE01_InpData	(PE01_InpData),
	.PE01_InpEn		(PE01_InpEn),
	.PE01_InpReady	(PE01_InpReady),
	.PE01_InpSel	(PE01_InpSel),
	
	.PE01_OutpData	(PE01_OutpData),
	.PE01_OutpEn	(PE01_OutpEn),
	.PE01_OutpReady	(PE01_OutpReady),
	.PE01_OutpSel	(PE01_OutpSel),
	

	.PE10_InpData	(PE10_InpData),
	.PE10_InpEn		(PE10_InpEn	),
	.PE10_InpReady	(PE10_InpReady),
	.PE10_InpSel	(PE10_InpSel),
	
	.PE10_OutpData	(PE10_OutpData),
	.PE10_OutpEn	(PE10_OutpEn),
	.PE10_OutpReady	(PE10_OutpReady),
	.PE10_OutpSel	(PE10_OutpSel),
	

	.PE11_InpData	(PE11_InpData),
	.PE11_InpEn		(PE11_InpEn),
	.PE11_InpReady	(PE11_InpReady),
	.PE11_InpSel	(PE11_InpSel),
	
	.PE11_OutpData	(PE11_OutpData),
	.PE11_OutpEn	(PE11_OutpEn),
	.PE11_OutpReady	(PE11_OutpReady),
	.PE11_OutpSel	(PE11_OutpSel)
	);

endmodule 