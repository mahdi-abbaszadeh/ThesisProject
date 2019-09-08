-- NOCSynSim
-- Network on a Chip Synthesisable and Simulation VHDL Model
-- Version: 1.0 
-- Last Update: 2006/10/04
-- Sharif University of Technology
-- Computer Department
-- High Performance Computing Group - Dr.Sarbazi Azad
-- Author: D.Rahmati

Library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.FilePack.all;
Use Work.ConnectionPack.All;
use std.textio.all;



entity NOC is  --MeshMxN
Generic(
		RowNo		: Integer := @NoC.RowNo;
		ColNo		: Integer := @NoC.ColNo;

		PackWidth	: Integer := @NoC.PackWidth;
		DataWidth	: Integer := @NoC.DataWidth;
		AddrWidth	: Integer := @NoC.AddrWidth;	

		RoChAddr		: Integer := @NoC.RoChAddr;
		PhyChAddr		: Integer := @NoC.PhyChAddr;
		ViChAddr		: Integer := @NoC.ViChAddr;
		PhyRoChAddr		: Integer := @NoC.PhyRoChAddr;
		RoCh			: Integer := @NoC.RoCh;
		PhyCh			: Integer := @NoC.PhyCh;
		ViCh			: Integer := @NoC.ViCh;
		PhyRoCh			: Integer := @NoC.PhyRoCh;
		PoissonDelayStr : String(3 Downto 1):="200";
		InpFileUniform  : StrArr6(0 to @numOfTiles-1):=(
		#for @tile in @tiles:
		#if (@tile.number < 10)
		#if (@tile.number == @numOfTiles - 1)
		"0@{tile.number}.txt"
		#else
		"0@{tile.number}.txt",
		#end
		#else
		#if (@tile.number == @numOfTiles - 1)
		"@{tile.number}.txt"
		#else
		"@{tile.number}.txt",
		#end
		#end
		#end
		);

		
 		PackGenNum : Unsigned(15 Downto 0) := To_Unsigned(300,16);
 		PackGen    : Unsigned(@numOfTiles-1 Downto 0):=(Others=>'1')
		);
	port (
		Clk				: In  std_logic;
		Reset			: In  std_logic;

		--SentCnt			: Out UnsignedArr16(RowNo*ColNo-1 Downto 0);
		--ReceCnt			: Out UnsignedArr16(RowNo*ColNo-1 Downto 0);
		--AveReceTime		: Out UnsignedArr20(RowNo*ColNo-1 Downto 0);
		--StopSim			: In Std_Logic
		#for @tile in @tiles:

		PE@{tile.number}_InpData		: Out 	Signed(DataWidth-1 downto 0); 
		PE@{tile.number}_InpEn			: Out  	Std_Logic;
		PE@{tile.number}_InpReady		: In 	Unsigned(ViCh-1 downto 0);
		PE@{tile.number}_InpSel			: Out  	Unsigned(ViChAddr-1 downto 0);
		PE@{tile.number}_OutpData		: In 	Signed(DataWidth-1 downto 0); 
		PE@{tile.number}_OutpEn			: In 	Std_Logic;
		PE@{tile.number}_OutpReady		: Out  	Unsigned(ViCh-1 downto 0);
		#if (@tile.number == @numOfTiles - 1)
		PE@{tile.number}_OutpSel		: In 	Unsigned(ViChAddr-1 downto 0)
		#else
		PE@{tile.number}_OutpSel		: In 	Unsigned(ViChAddr-1 downto 0);
		#end
		#end
		);
end;


architecture behavioral of NOC is


	
--Constant	InpFilePoisson	: String  := "1000.txt";
--Constant	InpFileUniform	: String  := "Uniform.txt";
--Constant	OutpFilePack	: String  := "FullPack.txt";
--Constant	OutpFileTime	: String  := "Time.txt";

--Type StrArr9 is Array(0 to ColNo*RowNo-1) of String(9 Downto 1);
--Type StrArr14 is Array(0 to ColNo*RowNo-1) of String(14 Downto 1);
--Type StrArr11 is Array(0 to ColNo*RowNo-1) of String(11 Downto 1);
--Type StrArr6 is Array(0 to ColNo*RowNo-1) of String(6 Downto 1);
--Type StrArr16 is Array(0 to ColNo*RowNo-1) of String(16 Downto 1);
--Type StrArr10 is Array(0 to ColNo*RowNo-1) of String(10 Downto 1);
--Type StrArr5 is Array(0 to ColNo*RowNo-1) of String(5 Downto 1);
--Type StrArr15 is Array(0 to ColNo*RowNo-1) of String(15 Downto 1);
--constant InpFilePoisson :StrArr10:=(
--								"500-00.txt",
--								"500-01.txt",
--								"500-02.txt",
--								"500-03.txt",
--								"500-04.txt",
--								"500-05.txt",
--								"500-06.txt",
--								"500-07.txt",
--								"500-08.txt",
--								"500-09.txt",
--								"500-10.txt",
--								"500-11.txt",
--								"500-12.txt",
--								"500-13.txt",
--								"500-14.txt",
--								"500-15.txt"																
--								);

Constant InpFilePoissonStr : String(4 Downto 1) := Str_Add(3,1,PoissonDelayStr,"-"); --"500-"
Constant PStr : String(5 Downto 1) :="Pack-";
Constant OutpFilePackStr   : String(9 Downto 1) := Str_Add(5,4,PStr,InpFilePoissonStr); --"Pack-500-"
Constant TStr : String(5 Downto 1) :="Time-";
Constant OutpFileTimeStr   : String(9 Downto 1) := Str_Add(5,4,TStr,InpFilePoissonStr); --"Time-500-";


--constant InpFileUniform :StrArr6:=(
--								"00.txt",
--								"01.txt",
--								"02.txt",
--								"03.txt",
--								"04.txt",
--								"05.txt",
--								"06.txt",
--								"07.txt",
--								"08.txt",
--								"09.txt",
--								"10.txt",
--								"11.txt",
--								"12.txt",
--								"13.txt",
--								"14.txt",
--								"15.txt",																
--								"16.txt",
--								"17.txt",
--								"18.txt",
--								"19.txt",
--								"20.txt",
--								"21.txt",
--								"22.txt",
--								"23.txt",
--								"24.txt",
--								"25.txt",
--								"26.txt",
--								"27.txt",
--								"28.txt",
--								"29.txt",
--								"30.txt",
--								"31.txt",																
--								"32.txt",
--								"33.txt",
--								"34.txt",
--								"35.txt",
--								"36.txt",
--								"37.txt",
--								"38.txt",
--								"39.txt",
--								"40.txt",
--								"41.txt",
--								"42.txt",
--								"43.txt",
--								"44.txt",
--								"45.txt",
--								"46.txt",
--								"47.txt",																
--								"48.txt",
--								"49.txt",
--								"50.txt",
--								"51.txt",
--								"52.txt",
--								"53.txt",
--								"54.txt",
--								"55.txt",
--								"56.txt",
--								"57.txt",
--								"58.txt",
--								"59.txt",
--								"60.txt",
--								"61.txt",
--								"62.txt",
--								"63.txt"													
--								); 

--constant OutpFilePack :StrArr15:=(
--								"Pack-500-00.txt",
--								"Pack-500-01.txt",
--								"Pack-500-02.txt",
--								"Pack-500-03.txt",
--								"Pack-500-04.txt",
--								"Pack-500-05.txt",
--								"Pack-500-06.txt",
--								"Pack-500-07.txt",
--								"Pack-500-08.txt",
--								"Pack-500-09.txt",
--								"Pack-500-10.txt",
--								"Pack-500-11.txt",
--								"Pack-500-12.txt",
--								"Pack-500-13.txt",
--								"Pack-500-14.txt",
--								"Pack-500-15.txt"																
--								); 
--constant OutpFileTime :StrArr15:=(
--								"Time-500-00.txt",
--								"Time-500-01.txt",
--								"Time-500-02.txt",
--								"Time-500-03.txt",
--								"Time-500-04.txt",
--								"Time-500-05.txt",
--								"Time-500-06.txt",
--								"Time-500-07.txt",
--								"Time-500-08.txt",
--								"Time-500-09.txt",
--								"Time-500-10.txt",
--								"Time-500-11.txt",
--								"Time-500-12.txt",
--								"Time-500-13.txt",
--								"Time-500-14.txt",
--								"Time-500-15.txt"																
--								); 						
																		
Function Index(	j,i		: Integer;
				ColNo,RowNo	: Integer )
						return Integer Is
									
variable Res:	Integer;
variable ii,jj: Integer;
begin
	jj:=j;
	ii:=i;
	if (jj=-1) Then
		jj:=RowNo-1;
	End If;
	if (jj=RowNo) Then
		jj:=0;
	End If;
	if (ii=-1) Then
		ii:=ColNo-1;
	End If;
	if (ii=ColNo) Then
		ii:=0;
	End If;
	
	--Res := (j mod ColNo)*ColNo+(i mod ColNo); 
	Res := jj*ColNo+ii; 
	return Res;
end;								
		
Type UnsignedArrViChAddr is array (natural range <>) of Unsigned(ViChAddr-1 Downto 0);
Type UnsignedArrPhyxVi is array (natural range <>) of Unsigned(PhyCh*ViCh-1 Downto 0); --PhyCh*ViCh=4*1
Type SignedArrMNxPhyChxDataWidth is array(ColNo*RowNo-1 Downto 0) of SignedArrDW(PhyCh-1 downto 0);
Type UnsignedArrMNxPhyxViChAddr is array(ColNo*RowNo-1 Downto 0) of UnsignedArrVCA(PhyCh-1 downto 0);
Type UnsignedArrPhy is array (natural range <>) of Unsigned(PhyCh-1 Downto 0);

Signal	Data	: SignedArrMNxPhyChxDataWidth:=(Others=>(Others=>(Others=>'0'))); --? 8+2
Signal	Data2	: SignedArrMNxPhyChxDataWidth:=(Others=>(Others=>(Others=>'0'))); --? 8+2
Signal	En		: UnsignedArrPhy(ColNo*RowNo-1 downto 0):=(Others=>(Others=>'0'));
Signal	En2		: UnsignedArrPhy(ColNo*RowNo-1 downto 0):=(Others=>(Others=>'0'));
Signal	Ready	: UnsignedArrPhyxVi(ColNo*RowNo-1 downto 0):=(Others=>(Others=>'0')); --note: ViCh=1	->> 4=4*1(ViCh)
Signal	Ready2	: UnsignedArrPhyxVi(ColNo*RowNo-1 downto 0):=(Others=>(Others=>'0')); --note: ViCh=1
Signal	Sel		: UnsignedArrMNxPhyxViChAddr; --ers=>" ? ViChAddr=1
Signal	Sel2	: UnsignedArrMNxPhyxViChAddr; --ers=>" ? ViChAddr=1

begin 

#for @tile in @tiles:

--*************************************************************************************
	--*************************************************************************************
	-- j = @{tile.j}, i = @{tile.i};
	--*************************************************************************************
	--*************************************************************************************
Data2(@{tile.j}*ColNo+@{tile.i}) <= (Data(Index(@{tile.j}+1,@{tile.i},ColNo,RowNo))(1),Data(Index(@{tile.j},@{tile.i}+1,ColNo,RowNo))(0)
						   ,Data(Index(@{tile.j}-1,@{tile.i},ColNo,RowNo))(3),Data(Index(@{tile.j},@{tile.i}-1,ColNo,RowNo))(2));
En2(@{tile.j}*ColNo+@{tile.i}) <= 	(En(Index(@{tile.j}+1,@{tile.i},ColNo,RowNo))(1),En(Index(@{tile.j},@{tile.i}+1,ColNo,RowNo))(0)
						   ,En(Index(@{tile.j}-1,@{tile.i},ColNo,RowNo))(3),En(Index(@{tile.j},@{tile.i}-1,ColNo,RowNo))(2));

ag@tile.number  : For k in 0 to ViCh-1 Generate
	Ready(Index(@{tile.j}+1,@{tile.i},ColNo,RowNo))(1 *ViCh+k) 	<= Ready2(@{tile.j}*ColNo+@{tile.i})(3 *ViCh+k);
	Ready(Index(@{tile.j},@{tile.i}+1,ColNo,RowNo))(0 *ViCh+k) 	<= Ready2(@{tile.j}*ColNo+@{tile.i})(2 *ViCh+k);
	Ready(Index(@{tile.j}-1,@{tile.i},ColNo,RowNo))(3 *ViCh+k) 	<= Ready2(@{tile.j}*ColNo+@{tile.i})(1 *ViCh+k);
	Ready(Index(@{tile.j},@{tile.i}-1,ColNo,RowNo))(2 *ViCh+k) 	<= Ready2(@{tile.j}*ColNo+@{tile.i})(0 *ViCh+k);
End Generate;	

Sel2(@{tile.j}*ColNo+@{tile.i}) <=	(Sel(Index(@{tile.j}+1,@{tile.i},ColNo,RowNo))(1),Sel(Index(@{tile.j},@{tile.i}+1,ColNo,RowNo))(0)
						   ,Sel(Index(@{tile.j}-1,@{tile.i},ColNo,RowNo))(3),Sel(Index(@{tile.j},@{tile.i}-1,ColNo,RowNo))(2));					   
m@{tile.number}: Entity Work.Node 
	Generic Map(
	
		InpFilePoisson	=> Str_Add(4,6,InpFilePoissonStr,InpFileUniform(@{tile.j}*ColNo+@{tile.i}))	,	
		InpFileUniform	=> InpFileUniform(@{tile.j}*ColNo+@{tile.i})	,	
		OutpFilePack	=> Str_Add(9,6,OutpFilePackStr,InpFileUniform(@{tile.j}*ColNo+@{tile.i}))		 ,
		OutpFileTime	=> Str_Add(9,6,OutpFileTimeStr,InpFileUniform(@{tile.j}*ColNo+@{tile.i}))		,
	
		ViChAddr	=> ViChAddr		,
		PhyRoChAddr	=> PhyRoChAddr	,
		--			   --
		PhyCh		=> PhyCh		,
		ViCh		=> ViCh			,
		RoCh 		=> RoCh 		,
		PhyRoCh		=> PhyRoCh		,
		--			   --
		PackWidth	=> PackWidth	,
		DataWidth	=> DataWidth	,
		--			   --
		CurNode		=> @{tile.j}*ColNo+@{tile.i}	,	
		PackGen		=> PackGen(@{tile.j}*ColNo+@{tile.i}) ,
		PackGenNum	=> PackGenNum
		)
	Port Map(
		Clk				=> Clk			,	
		Reset			=> Reset		,	

		InpData			=> Data2(@{tile.j}*ColNo+@{tile.i})	,	
		InpEn			=> En2(@{tile.j}*ColNo+@{tile.i})		,	
		InpReady		=> Ready2(@{tile.j}*ColNo+@{tile.i})	,
		InpSel			=> Sel2(@{tile.j}*ColNo+@{tile.i})		,		

		OutpData		=> Data(@{tile.j}*ColNo+@{tile.i}),
		OutpEn			=> En(@{tile.j}*ColNo+@{tile.i})	,	
		OutpReady		=> Ready(@{tile.j}*ColNo+@{tile.i})	,
		OutpSel			=> Sel(@{tile.j}*ColNo+@{tile.i}),

		PE_InpData		=> PE@{tile.number}_InpData,
		PE_InpEn		=> PE@{tile.number}_InpEn,
		PE_InpReady		=> PE@{tile.number}_InpReady,
		PE_InpSel		=> PE@{tile.number}_InpSel,

		PE_OutpData		=> PE@{tile.number}_OutpData,
		PE_OutpEn		=> PE@{tile.number}_OutpEn,
		PE_OutpReady 	=> PE@{tile.number}_OutpReady,
		PE_OutpSel		=> PE@{tile.number}_OutpSel					
	);

#end

End;
