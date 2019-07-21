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
		--RowNo		: Integer := 4;
		--ColNo		: Integer := 4;

		PackWidth	: Integer := 8;
		DataWidth	: Integer := 8;
		AddrWidth	: Integer := 2;--previous value -> 4	

		RoChAddr		: Integer := 1;
		PhyChAddr		: Integer := 2;
		ViChAddr		: Integer := 1;--previous value -> 2
		PhyRoChAddr		: Integer := 2+1;
		RoCh			: Integer := 1;
		PhyCh			: Integer := 4;
		ViCh			: Integer := 1;--previous value -> 4
		PhyRoCh			: Integer := 4+1;
		PoissonDelayStr : String(3 Downto 1):="200";--previous value -> 500
		InpFileUniform  : StrArr6(0 to ColNo*RowNo-1):=("00.txt","01.txt","02.txt","03.txt");

		
 		PackGenNum : Unsigned(15 Downto 0) := To_Unsigned(5,16);
 		PackGen    : Unsigned(RowNo*ColNo-1 Downto 0):=(Others=>'1')
		);
	port (
		Clk				: In  std_logic;
		Reset			: In  std_logic;

		--SentCnt			: Out UnsignedArr16(RowNo*ColNo-1 Downto 0);
		--ReceCnt			: Out UnsignedArr16(RowNo*ColNo-1 Downto 0);
		--AveReceTime		: Out UnsignedArr20(RowNo*ColNo-1 Downto 0);
		--StopSim			: In Std_Logic

		PE00_InpData		: Out 	Signed(DataWidth-1 downto 0); 
		PE00_InpEn			: Out  	Std_Logic;
		PE00_InpReady		: In 	Unsigned(ViCh-1 downto 0);
		PE00_InpSel			: Out  	Unsigned(ViChAddr-1 downto 0);
		PE00_OutpData		: In 	Signed(DataWidth-1 downto 0); 
		PE00_OutpEn			: In 	Std_Logic;
		PE00_OutpReady		: Out  	Unsigned(ViCh-1 downto 0);
		PE00_OutpSel		: In 	Unsigned(ViChAddr-1 downto 0);

		PE01_InpData		: Out 	Signed(DataWidth-1 downto 0); 
		PE01_InpEn			: Out  	Std_Logic;
		PE01_InpReady		: In 	Unsigned(ViCh-1 downto 0);
		PE01_InpSel			: Out  	Unsigned(ViChAddr-1 downto 0);
		PE01_OutpData		: In 	Signed(DataWidth-1 downto 0); 
		PE01_OutpEn			: In 	Std_Logic;
		PE01_OutpReady		: Out  	Unsigned(ViCh-1 downto 0);
		PE01_OutpSel		: In 	Unsigned(ViChAddr-1 downto 0);

		PE10_InpData		: Out 	Signed(DataWidth-1 downto 0); 
		PE10_InpEn			: Out  	Std_Logic;
		PE10_InpReady		: In 	Unsigned(ViCh-1 downto 0);
		PE10_InpSel			: Out  	Unsigned(ViChAddr-1 downto 0);
		PE10_OutpData		: In 	Signed(DataWidth-1 downto 0); 
		PE10_OutpEn			: In 	Std_Logic;
		PE10_OutpReady		: Out  	Unsigned(ViCh-1 downto 0);
		PE10_OutpSel		: In 	Unsigned(ViChAddr-1 downto 0);

		PE11_InpData		: Out 	Signed(DataWidth-1 downto 0); 
		PE11_InpEn			: Out  	Std_Logic;
		PE11_InpReady		: In 	Unsigned(ViCh-1 downto 0);
		PE11_InpSel			: Out  	Unsigned(ViChAddr-1 downto 0);
		PE11_OutpData		: In 	Signed(DataWidth-1 downto 0); 
		PE11_OutpEn			: In 	Std_Logic;
		PE11_OutpReady		: Out  	Unsigned(ViCh-1 downto 0);
		PE11_OutpSel		: In 	Unsigned(ViChAddr-1 downto 0)



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

--mg1: For j in 0 to RowNo-1 Generate
--	mg2: For i in 0 to ColNo-1 Generate
--	--write(str,i);
--	--InpPoisson(j) <= String'(j);
--	--InpPoisson(j):=Int_to_string(j*ColNo+i);
--	Data2(j*ColNo+i) <= (Data(Index(j+1,i,ColNo,RowNo))(1),Data(Index(j,i+1,ColNo,RowNo))(0)
--						   ,Data(Index(j-1,i,ColNo,RowNo))(3),Data(Index(j,i-1,ColNo,RowNo))(2));
--	En2(j*ColNo+i) <= 	(En(Index(j+1,i,ColNo,RowNo))(1),En(Index(j,i+1,ColNo,RowNo))(0)
--						   ,En(Index(j-1,i,ColNo,RowNo))(3),En(Index(j,i-1,ColNo,RowNo))(2));
--	--Ready2(j*ColNo+i) <= 	(Ready(Index(j,i-1,ColNo,RowNo))(2),Ready(Index(j-1,i,ColNo,RowNo))(3)
--	--					   ,Ready(Index(j,i+1,ColNo,RowNo))(0),Ready(Index(j+1,i,ColNo,RowNo))(1));				   


----	Ready(Index(j+1,i,ColNo,RowNo))(1) <= Ready2(j*ColNo+i)(3);
----	Ready(Index(j,i+1,ColNo,RowNo))(0) <= Ready2(j*ColNo+i)(2);
----	Ready(Index(j-1,i,ColNo,RowNo))(3) <= Ready2(j*ColNo+i)(1);
----	Ready(Index(j,i-1,ColNo,RowNo))(2) <= Ready2(j*ColNo+i)(0);
--	ag3  : For k in 0 to ViCh-1 Generate
--		Ready(Index(j+1,i,ColNo,RowNo))(1 *ViCh+k) 	<= Ready2(j*ColNo+i)(3 *ViCh+k);
--		Ready(Index(j,i+1,ColNo,RowNo))(0 *ViCh+k) 	<= Ready2(j*ColNo+i)(2 *ViCh+k);
--		Ready(Index(j-1,i,ColNo,RowNo))(3 *ViCh+k) 	<= Ready2(j*ColNo+i)(1 *ViCh+k);
--		Ready(Index(j,i-1,ColNo,RowNo))(2 *ViCh+k) 	<= Ready2(j*ColNo+i)(0 *ViCh+k);
--	End Generate;	
	
--	Sel2(j*ColNo+i) <=	(Sel(Index(j+1,i,ColNo,RowNo))(1),Sel(Index(j,i+1,ColNo,RowNo))(0)
--						   ,Sel(Index(j-1,i,ColNo,RowNo))(3),Sel(Index(j,i-1,ColNo,RowNo))(2));					   
--m1: Entity Work.Node 
--	Generic Map(
--		--InpFilePoisson	=> InpFilePoisson(j*ColNo+i)	,	
--		--InpFileUniform	=> InpFileUniform(j*ColNo+i)	,	
--		--OutpFilePack	=> OutpFilePack(j*ColNo+i)		 ,
--		--OutpFileTime	=> OutpFileTime(j*ColNo+i)		,
	
--		InpFilePoisson	=> Str_Add(4,6,InpFilePoissonStr,InpFileUniform(j*ColNo+i))	,	
--		InpFileUniform	=> InpFileUniform(j*ColNo+i)	,	
--		OutpFilePack	=> Str_Add(9,6,OutpFilePackStr,InpFileUniform(j*ColNo+i))		 ,
--		OutpFileTime	=> Str_Add(9,6,OutpFileTimeStr,InpFileUniform(j*ColNo+i))		,
	
--		ViChAddr	=> ViChAddr		,
--		PhyRoChAddr	=> PhyRoChAddr	,
--		--			   --
--		PhyCh		=> PhyCh		,
--		ViCh		=> ViCh			,
--		RoCh 		=> RoCh 		,
--		PhyRoCh		=> PhyRoCh		,
--		--			   --
--		PackWidth	=> PackWidth	,
--		DataWidth	=> DataWidth	,
--		--			   --
--		CurNode		=> j*ColNo+i	,
--		--Y			=> j			,	
--		PackGen		=> PackGen(j*ColNo+i) ,
--		PackGenNum	=> PackGenNum
--		)
--	Port Map(
--		Clk				=> Clk			,	
--		Reset			=> Reset		,	

--		InpData			=> Data2(j*ColNo+i)	,	
--		InpEn			=> En2(j*ColNo+i)		,	
--		InpReady		=> Ready2(j*ColNo+i)	,
--		InpSel			=> Sel2(j*ColNo+i)		,		

--		OutpData		=> Data(j*ColNo+i),
--		OutpEn			=> En(j*ColNo+i)	,	
--		OutpReady		=> Ready(j*ColNo+i)	,
		
--		SentCnt			=> SentCnt(j*ColNo+i)	,
--		ReceCnt			=> ReceCnt(j*ColNo+i)	,
--		AveReceTime		=> AveReceTime(j*ColNo+i),
--		--sim
--		StopSim			=> StopSim,

--		OutpSel			=> Sel(j*ColNo+i)					
--	);
--	End Generate;	
--End Generate;	


	--*************************************************************************************
	--*************************************************************************************
	-- j = 0, i = 0;
	--*************************************************************************************
	--*************************************************************************************
Data2(0*ColNo+0) <= (Data(Index(0+1,0,ColNo,RowNo))(1),Data(Index(0,0+1,ColNo,RowNo))(0)
					   ,Data(Index(0-1,0,ColNo,RowNo))(3),Data(Index(0,0-1,ColNo,RowNo))(2));
En2(0*ColNo+0) <= 	(En(Index(0+1,0,ColNo,RowNo))(1),En(Index(0,0+1,ColNo,RowNo))(0)
					   ,En(Index(0-1,0,ColNo,RowNo))(3),En(Index(0,0-1,ColNo,RowNo))(2));

ag00 : For k in 0 to ViCh-1 Generate
	Ready(Index(0+1,0,ColNo,RowNo))(1 *ViCh+k) 	<= Ready2(0*ColNo+0)(3 *ViCh+k);
	Ready(Index(0,0+1,ColNo,RowNo))(0 *ViCh+k) 	<= Ready2(0*ColNo+0)(2 *ViCh+k);
	Ready(Index(0-1,0,ColNo,RowNo))(3 *ViCh+k) 	<= Ready2(0*ColNo+0)(1 *ViCh+k);
	Ready(Index(0,0-1,ColNo,RowNo))(2 *ViCh+k) 	<= Ready2(0*ColNo+0)(0 *ViCh+k);
End Generate;	

Sel2(0*ColNo+0) <=	(Sel(Index(0+1,0,ColNo,RowNo))(1),Sel(Index(0,0+1,ColNo,RowNo))(0)
					   ,Sel(Index(0-1,0,ColNo,RowNo))(3),Sel(Index(0,0-1,ColNo,RowNo))(2));					   
m00: Entity Work.Node 
	Generic Map(
		InpFilePoisson	=> Str_Add(4,6,InpFilePoissonStr,InpFileUniform(0*ColNo+0))	,	
		InpFileUniform	=> InpFileUniform(0*ColNo+0)	,	
		OutpFilePack	=> Str_Add(9,6,OutpFilePackStr,InpFileUniform(0*ColNo+0))		 ,
		OutpFileTime	=> Str_Add(9,6,OutpFileTimeStr,InpFileUniform(0*ColNo+0))		,
	
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
		CurNode		=> 0*ColNo+0	,
		--Y			=> j			,	
		PackGen		=> PackGen(0*ColNo+0) ,
		PackGenNum	=> PackGenNum
		)
	Port Map(
		Clk				=> Clk			,	
		Reset			=> Reset		,	

		InpData			=> Data2(0*ColNo+0)	,	
		InpEn			=> En2(0*ColNo+0)		,	
		InpReady		=> Ready2(0*ColNo+0)	,
		InpSel			=> Sel2(0*ColNo+0)		,		

		OutpData		=> Data(0*ColNo+0),
		OutpEn			=> En(0*ColNo+0)	,	
		OutpReady		=> Ready(0*ColNo+0)	,
		OutpSel			=> Sel(0*ColNo+0),

		PE_InpData		=> PE00_InpData,
		PE_InpEn		=> PE00_InpEn,
		PE_InpReady		=> PE00_InpReady,
		PE_InpSel		=> PE00_InpSel,

		PE_OutpData		=> PE00_OutpData,
		PE_OutpEn		=> PE00_OutpEn,
		PE_OutpReady 	=> PE00_OutpReady,
		PE_OutpSel		=> PE00_OutpSel				
	);



	--*************************************************************************************
	--*************************************************************************************
	-- j = 0, i = 1;
	--*************************************************************************************
	--*************************************************************************************
Data2(0*ColNo+1) <= (Data(Index(0+1,1,ColNo,RowNo))(1),Data(Index(0,1+1,ColNo,RowNo))(0)
						   ,Data(Index(0-1,1,ColNo,RowNo))(3),Data(Index(0,1-1,ColNo,RowNo))(2));
En2(0*ColNo+1) <= 	(En(Index(0+1,1,ColNo,RowNo))(1),En(Index(0,1+1,ColNo,RowNo))(0)
						   ,En(Index(0-1,1,ColNo,RowNo))(3),En(Index(0,1-1,ColNo,RowNo))(2));

ag01  : For k in 0 to ViCh-1 Generate
	Ready(Index(0+1,1,ColNo,RowNo))(1 *ViCh+k) 	<= Ready2(0*ColNo+1)(3 *ViCh+k);
	Ready(Index(0,1+1,ColNo,RowNo))(0 *ViCh+k) 	<= Ready2(0*ColNo+1)(2 *ViCh+k);
	Ready(Index(0-1,1,ColNo,RowNo))(3 *ViCh+k) 	<= Ready2(0*ColNo+1)(1 *ViCh+k);
	Ready(Index(0,1-1,ColNo,RowNo))(2 *ViCh+k) 	<= Ready2(0*ColNo+1)(0 *ViCh+k);
End Generate;	

Sel2(0*ColNo+1) <=	(Sel(Index(0+1,1,ColNo,RowNo))(1),Sel(Index(0,1+1,ColNo,RowNo))(0)
						   ,Sel(Index(0-1,1,ColNo,RowNo))(3),Sel(Index(0,1-1,ColNo,RowNo))(2));					   
m01: Entity Work.Node 
	Generic Map(
	
		InpFilePoisson	=> Str_Add(4,6,InpFilePoissonStr,InpFileUniform(0*ColNo+1))	,	
		InpFileUniform	=> InpFileUniform(0*ColNo+1)	,	
		OutpFilePack	=> Str_Add(9,6,OutpFilePackStr,InpFileUniform(0*ColNo+1))		 ,
		OutpFileTime	=> Str_Add(9,6,OutpFileTimeStr,InpFileUniform(0*ColNo+1))		,
	
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
		CurNode		=> 0*ColNo+1	,
		--Y			=> 0			,	
		PackGen		=> PackGen(0*ColNo+1) ,
		PackGenNum	=> PackGenNum
		)
	Port Map(
		Clk				=> Clk			,	
		Reset			=> Reset		,	

		InpData			=> Data2(0*ColNo+1)	,	
		InpEn			=> En2(0*ColNo+1)		,	
		InpReady		=> Ready2(0*ColNo+1)	,
		InpSel			=> Sel2(0*ColNo+1)		,		

		OutpData		=> Data(0*ColNo+1),
		OutpEn			=> En(0*ColNo+1)	,	
		OutpReady		=> Ready(0*ColNo+1)	,
		OutpSel			=> Sel(0*ColNo+1),

		PE_InpData		=> PE01_InpData,
		PE_InpEn		=> PE01_InpEn,
		PE_InpReady		=> PE01_InpReady,
		PE_InpSel		=> PE01_InpSel,

		PE_OutpData		=> PE01_OutpData,
		PE_OutpEn		=> PE01_OutpEn,
		PE_OutpReady 	=> PE01_OutpReady,
		PE_OutpSel		=> PE01_OutpSel					
	);

	--*************************************************************************************
	--*************************************************************************************
	-- j = 1, i = 0;
	--*************************************************************************************
	--*************************************************************************************
Data2(1*ColNo+0) <= (Data(Index(1+1,0,ColNo,RowNo))(1),Data(Index(1,0+1,ColNo,RowNo))(0)
						   ,Data(Index(1-1,0,ColNo,RowNo))(3),Data(Index(1,0-1,ColNo,RowNo))(2));
En2(1*ColNo+0) <= 	(En(Index(1+1,0,ColNo,RowNo))(1),En(Index(1,0+1,ColNo,RowNo))(0)
						   ,En(Index(1-1,0,ColNo,RowNo))(3),En(Index(1,0-1,ColNo,RowNo))(2));

ag10  : For k in 0 to ViCh-1 Generate
	Ready(Index(1+1,0,ColNo,RowNo))(1 *ViCh+k) 	<= Ready2(1*ColNo+0)(3 *ViCh+k);
	Ready(Index(1,0+1,ColNo,RowNo))(0 *ViCh+k) 	<= Ready2(1*ColNo+0)(2 *ViCh+k);
	Ready(Index(1-1,0,ColNo,RowNo))(3 *ViCh+k) 	<= Ready2(1*ColNo+0)(1 *ViCh+k);
	Ready(Index(1,0-1,ColNo,RowNo))(2 *ViCh+k) 	<= Ready2(1*ColNo+0)(0 *ViCh+k);
End Generate;	

Sel2(1*ColNo+0) <=	(Sel(Index(1+1,0,ColNo,RowNo))(1),Sel(Index(1,0+1,ColNo,RowNo))(0)
						   ,Sel(Index(1-1,0,ColNo,RowNo))(3),Sel(Index(1,0-1,ColNo,RowNo))(2));					   
m10: Entity Work.Node 
	Generic Map(
	
		InpFilePoisson	=> Str_Add(4,6,InpFilePoissonStr,InpFileUniform(1*ColNo+0))	,	
		InpFileUniform	=> InpFileUniform(1*ColNo+0)	,	
		OutpFilePack	=> Str_Add(9,6,OutpFilePackStr,InpFileUniform(1*ColNo+0))		 ,
		OutpFileTime	=> Str_Add(9,6,OutpFileTimeStr,InpFileUniform(1*ColNo+0))		,
	
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
		CurNode		=> 1*ColNo+0	,
		--Y			=> 1			,	
		PackGen		=> PackGen(1*ColNo+0) ,
		PackGenNum	=> PackGenNum
		)
	Port Map(
		Clk				=> Clk			,	
		Reset			=> Reset		,	

		InpData			=> Data2(1*ColNo+0)	,	
		InpEn			=> En2(1*ColNo+0)		,	
		InpReady		=> Ready2(1*ColNo+0)	,
		InpSel			=> Sel2(1*ColNo+0)		,		

		OutpData		=> Data(1*ColNo+0),
		OutpEn			=> En(1*ColNo+0)	,	
		OutpReady		=> Ready(1*ColNo+0)	,
		OutpSel			=> Sel(1*ColNo+0),

		PE_InpData		=> PE10_InpData,
		PE_InpEn		=> PE10_InpEn,
		PE_InpReady		=> PE10_InpReady,
		PE_InpSel		=> PE10_InpSel,

		PE_OutpData		=> PE10_OutpData,
		PE_OutpEn		=> PE10_OutpEn,
		PE_OutpReady 	=> PE10_OutpReady,
		PE_OutpSel		=> PE10_OutpSel					
	);

		--*************************************************************************************
	--*************************************************************************************
	-- j = 1, i = 1;
	--*************************************************************************************
	--*************************************************************************************
Data2(1*ColNo+1) <= (Data(Index(1+1,1,ColNo,RowNo))(1),Data(Index(1,1+1,ColNo,RowNo))(0)
						   ,Data(Index(1-1,1,ColNo,RowNo))(3),Data(Index(1,1-1,ColNo,RowNo))(2));
En2(1*ColNo+1) <= 	(En(Index(1+1,1,ColNo,RowNo))(1),En(Index(1,1+1,ColNo,RowNo))(0)
						   ,En(Index(1-1,1,ColNo,RowNo))(3),En(Index(1,1-1,ColNo,RowNo))(2));

ag11  : For k in 0 to ViCh-1 Generate
	Ready(Index(1+1,1,ColNo,RowNo))(1 *ViCh+k) 	<= Ready2(1*ColNo+1)(3 *ViCh+k);
	Ready(Index(1,1+1,ColNo,RowNo))(0 *ViCh+k) 	<= Ready2(1*ColNo+1)(2 *ViCh+k);
	Ready(Index(1-1,1,ColNo,RowNo))(3 *ViCh+k) 	<= Ready2(1*ColNo+1)(1 *ViCh+k);
	Ready(Index(1,1-1,ColNo,RowNo))(2 *ViCh+k) 	<= Ready2(1*ColNo+1)(0 *ViCh+k);
End Generate;	

Sel2(1*ColNo+1) <=	(Sel(Index(1+1,1,ColNo,RowNo))(1),Sel(Index(1,1+1,ColNo,RowNo))(0)
						   ,Sel(Index(1-1,1,ColNo,RowNo))(3),Sel(Index(1,1-1,ColNo,RowNo))(2));					   
m11: Entity Work.Node 
	Generic Map(
	
		InpFilePoisson	=> Str_Add(4,6,InpFilePoissonStr,InpFileUniform(1*ColNo+1))	,	
		InpFileUniform	=> InpFileUniform(1*ColNo+1)	,	
		OutpFilePack	=> Str_Add(9,6,OutpFilePackStr,InpFileUniform(1*ColNo+1))		 ,
		OutpFileTime	=> Str_Add(9,6,OutpFileTimeStr,InpFileUniform(1*ColNo+1))		,
	
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
		CurNode		=> 1*ColNo+1	,
		--Y			=> 1			,	
		PackGen		=> PackGen(1*ColNo+1) ,
		PackGenNum	=> PackGenNum
		)
	Port Map(
		Clk				=> Clk			,	
		Reset			=> Reset		,	

		InpData			=> Data2(1*ColNo+1)	,	
		InpEn			=> En2(1*ColNo+1)		,	
		InpReady		=> Ready2(1*ColNo+1)	,
		InpSel			=> Sel2(1*ColNo+1)		,		

		OutpData		=> Data(1*ColNo+1),
		OutpEn			=> En(1*ColNo+1)	,	
		OutpReady		=> Ready(1*ColNo+1)	,
		OutpSel			=> Sel(1*ColNo+1),

		PE_InpData		=> PE11_InpData,
		PE_InpEn		=> PE11_InpEn,
		PE_InpReady		=> PE11_InpReady,
		PE_InpSel		=> PE11_InpSel,

		PE_OutpData		=> PE11_OutpData,
		PE_OutpEn		=> PE11_OutpEn,
		PE_OutpReady 	=> PE11_OutpReady,
		PE_OutpSel		=> PE11_OutpSel					
	);

End;
