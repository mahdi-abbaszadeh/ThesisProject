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
		AddrWidth	: Integer := 4;	

		RoChAddr		: Integer := 1;
		PhyChAddr		: Integer := 2;
		ViChAddr		: Integer := 2;
		PhyRoChAddr		: Integer := 2+1;
		RoCh			: Integer := 1;
		PhyCh			: Integer := 4;
		ViCh			: Integer := 4;
		PhyRoCh			: Integer := 4+1;
		PoissonDelayStr : String(3 Downto 1):="500";
		InpFileUniform  : StrArr6(0 to ColNo*RowNo-1);--:=(Others=>(Others=>"_"));

		
 		PackGenNum : Unsigned(15 Downto 0) := To_Unsigned(5,16);
 		PackGen    : Unsigned(RowNo*ColNo-1 Downto 0):=(Others=>'1')
		);
	port (
		Clk				: In  std_logic;
		Reset			: In  std_logic;

		InpDataArr		: In  SignedArrDW(RowNo*ColNo-1 downto 0); --? 8+2 --outputdata from NIOS view
		InpEnArr		: In  Unsigned(RowNo*ColNo-1 downto 0);
		InpReadyArr		: Out Unsigned(RowNo*ColNo*ViCh-1 downto 0);
		InpSelArr		: In  UnsignedArrVCA(RowNo*ColNo-1 downto 0); -- ? ViChAddr=1

		OutpDataArr		: Out SignedArrDW(RowNo*ColNo-1 downto 0); --? 8+2
		OutpEnArr		: Out Unsigned(RowNo*ColNo-1 downto 0);
		OutpReadyArr	: In  Unsigned(RowNo*ColNo*ViCh-1 downto 0);
		OutpSelArr		: Out UnsignedArrVCA(RowNo*ColNo-1 downto 0) -- ? ViChAddr=1


		--SentCnt			: Out UnsignedArr16(RowNo*ColNo-1 Downto 0);
		--ReceCnt			: Out UnsignedArr16(RowNo*ColNo-1 Downto 0);
		--AveReceTime		: Out UnsignedArr20(RowNo*ColNo-1 Downto 0);
		--StopSim			: In Std_Logic
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


Type arrayOfSignedArrDW	 	is array (natural range <>) of SignedArrDW (PhyRoCh-1 downto 0);
Type arrayOfUnsigned	 	is array (natural range <>) of Unsigned(PhyRoCh-1 Downto 0);
Type arrayOfUnsignedViCh 	is array (natural range <>) of Unsigned(PhyRoCh*ViCh-1 Downto 0);
Type arrayOfUnsignedArrVCA 	is array (natural range <>) of UnsignedArrVCA(PhyRoCh-1 downto 0);

Signal InpData_sig 		: 	arrayOfSignedArrDW(ColNo*RowNo-1 Downto 0);
Signal InpEn_sig 		: 	arrayOfUnsigned(ColNo*RowNo-1 Downto 0);
Signal InpReady_sig 	: 	arrayOfUnsignedViCh(ColNo*RowNo-1 Downto 0); 
Signal InpSel_sig 		:	arrayOfUnsignedArrVCA(ColNo*RowNo-1 Downto 0);

Signal OutpData_sig 	: 	arrayOfSignedArrDW(ColNo*RowNo-1 Downto 0);
Signal OutpEn_sig 		: 	arrayOfUnsigned(ColNo*RowNo-1 Downto 0);
Signal OutpReady_sig 	: 	arrayOfUnsignedViCh(ColNo*RowNo-1 Downto 0);  
Signal OutpSel_sig 		: 	arrayOfUnsignedArrVCA(ColNo*RowNo-1 Downto 0);



begin 

mg1: For j in 0 to RowNo-1 Generate
	mg2: For i in 0 to ColNo-1 Generate
	--write(str,i);
	--InpPoisson(j) <= String'(j);
	--InpPoisson(j):=Int_to_string(j*ColNo+i);
	Data2(j*ColNo+i) <= (Data(Index(j+1,i,ColNo,RowNo))(1),Data(Index(j,i+1,ColNo,RowNo))(0)
						   ,Data(Index(j-1,i,ColNo,RowNo))(3),Data(Index(j,i-1,ColNo,RowNo))(2));
	En2(j*ColNo+i) <= 	(En(Index(j+1,i,ColNo,RowNo))(1),En(Index(j,i+1,ColNo,RowNo))(0)
						   ,En(Index(j-1,i,ColNo,RowNo))(3),En(Index(j,i-1,ColNo,RowNo))(2));
	--Ready2(j*ColNo+i) <= 	(Ready(Index(j,i-1,ColNo,RowNo))(2),Ready(Index(j-1,i,ColNo,RowNo))(3)
	--					   ,Ready(Index(j,i+1,ColNo,RowNo))(0),Ready(Index(j+1,i,ColNo,RowNo))(1));				   


--	Ready(Index(j+1,i,ColNo,RowNo))(1) <= Ready2(j*ColNo+i)(3);
--	Ready(Index(j,i+1,ColNo,RowNo))(0) <= Ready2(j*ColNo+i)(2);
--	Ready(Index(j-1,i,ColNo,RowNo))(3) <= Ready2(j*ColNo+i)(1);
--	Ready(Index(j,i-1,ColNo,RowNo))(2) <= Ready2(j*ColNo+i)(0);
	ag3  : For k in 0 to ViCh-1 Generate
		Ready(Index(j+1,i,ColNo,RowNo))(1 *ViCh+k) 	<= Ready2(j*ColNo+i)(3 *ViCh+k);
		Ready(Index(j,i+1,ColNo,RowNo))(0 *ViCh+k) 	<= Ready2(j*ColNo+i)(2 *ViCh+k);
		Ready(Index(j-1,i,ColNo,RowNo))(3 *ViCh+k) 	<= Ready2(j*ColNo+i)(1 *ViCh+k);
		Ready(Index(j,i-1,ColNo,RowNo))(2 *ViCh+k) 	<= Ready2(j*ColNo+i)(0 *ViCh+k);
	End Generate;	
	
	Sel2(j*ColNo+i) <=	(Sel(Index(j+1,i,ColNo,RowNo))(1),Sel(Index(j,i+1,ColNo,RowNo))(0)
						   ,Sel(Index(j-1,i,ColNo,RowNo))(3),Sel(Index(j,i-1,ColNo,RowNo))(2));


	InpData_sig(j*ColNo+i) 												<=  InpDataArr(j*ColNo+i)  	& Data2(j*ColNo+i);

	InpEn_sig(j*ColNo+i) 	 											<=	InpEnArr(j*ColNo+i) 	& En2(j*ColNo+i);

	InpReadyArr((j*ColNo+i)*ViCh + (ViCh-1) Downto (j*ColNo+i)*ViCh) 	<= 	InpReady_sig(j*ColNo+i)(PhyRoCh*ViCh-1 Downto (PhyRoCh-1)*ViCh);
	Ready2(j*ColNo+i)													<= 	InpReady_sig(j*ColNo+i)((PhyRoCh-1)*ViCh-1 Downto 0);

	InpSel_sig(j*ColNo+i) 	 											<=	InpSelArr(j*ColNo+i) 	& Sel2(j*ColNo+i);



	OutpDataArr(j*ColNo+i) 	<=	OutpData_sig(j*ColNo+i)(PhyRoCh-1);
	Data(j*ColNo+i) 		<=	OutpData_sig(j*ColNo+i)(PhyRoCh - 2 Downto 0);

	OutpEnArr(j*ColNo+i) 	<=	OutpEn_sig(j*ColNo+i)(PhyRoCh-1);
	En(j*ColNo+i)			<=	OutpEn_sig(j*ColNo+i)(PhyRoCh - 2 Downto 0);

	OutpReady_sig(j*ColNo+i)<=	OutpReadyArr((j*ColNo+i)*ViCh + (ViCh-1) Downto (j*ColNo+i)*ViCh) & Ready2(j*ColNo+i);

	OutpSelArr(j*ColNo+i)	<=	OutpSel_sig(j*ColNo+i)(PhyRoCh-1);	
	Sel(j*ColNo+i)			<=	OutpSel_sig(j*ColNo+i)(PhyRoCh - 2 Downto 0);


m1: Entity Work.Node 
	Generic Map(
		--InpFilePoisson	=> InpFilePoisson(j*ColNo+i)	,	
		--InpFileUniform	=> InpFileUniform(j*ColNo+i)	,	
		--OutpFilePack	=> OutpFilePack(j*ColNo+i)		 ,
		--OutpFileTime	=> OutpFileTime(j*ColNo+i)		,
	
		InpFilePoisson	=> Str_Add(4,6,InpFilePoissonStr,InpFileUniform(j*ColNo+i))	,	
		InpFileUniform	=> InpFileUniform(j*ColNo+i)	,	
		OutpFilePack	=> Str_Add(9,6,OutpFilePackStr,InpFileUniform(j*ColNo+i))		 ,
		OutpFileTime	=> Str_Add(9,6,OutpFileTimeStr,InpFileUniform(j*ColNo+i))		,
	
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
		CurNode     => j*ColNo+i	,
		--Y			=> j			,	
		PackGen		=> PackGen(j*ColNo+i) ,
		PackGenNum	=> PackGenNum
		)
	Port Map(
		Clk				=> Clk			,	
		Reset			=> Reset		,	

		InpData			=> InpData_sig(j*ColNo+i)  	,	
		InpEn			=> InpEn_sig(j*ColNo+i) 		,	
		InpReady		=> InpReady_sig(j*ColNo+i) 	,
		InpSel			=> InpSel_sig(j*ColNo+i) 		,		

		OutpData		=> OutpData_sig(j*ColNo+i) ,
		OutpEn			=> OutpEn_sig(j*ColNo+i) 	,	
		OutpReady		=> OutpReady_sig(j*ColNo+i) 	,
		OutpSel			=> OutpSel_sig(j*ColNo+i) 
		
		--SentCnt			=> SentCnt(j*ColNo+i)	,
		--ReceCnt			=> ReceCnt(j*ColNo+i)	,
		--AveReceTime		=> AveReceTime(j*ColNo+i),
		----sim
		--StopSim			=> StopSim

							
	);
	End Generate;	
End Generate;	

End;
