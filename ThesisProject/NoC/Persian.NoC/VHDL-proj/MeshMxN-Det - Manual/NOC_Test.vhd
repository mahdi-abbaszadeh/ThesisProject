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
Use Work.ConnectionPack.All;
use work.FilePack.all;


entity NOC_Test is 
end;


architecture behavioral of NOC_Test is

--Constant RowNo: Integer :=8;
--Constant ColNo: Integer :=8;



	

constant Period : time := 10 ns;
--shared variable StopSim : boolean := false;



Constant InpFilePoissonStr : String(4 Downto 1) := Str_Add(3,1,PoissonDelayStr,"-"); --"500-"
Constant PStr : String(5 Downto 1) :="Pack-";
Constant OutpFilePackStr   : String(9 Downto 1) := Str_Add(5,4,PStr,InpFilePoissonStr); --"Pack-500-"
Constant TStr : String(5 Downto 1) :="Time-";
Constant OutpFileTimeStr   : String(9 Downto 1) := Str_Add(5,4,TStr,InpFilePoissonStr); --"Time-500-";

signal  Stop,Stop2	: Boolean;
Signal	Clk			: std_logic:='0';
Signal	Reset		: std_logic:='0';
Signal	SentCnt		: UnsignedArr16(RowNo*ColNo-1 Downto 0);
Signal	ReceCnt		: UnsignedArr16(RowNo*ColNo-1 Downto 0);		
Signal 	StopSim		: Std_Logic;	
Signal 	StopOut		: Std_Logic;	
Signal	AveReceTime	: UnsignedArr20(RowNo*ColNo-1 Downto 0);


Signal 	PE00_InpData		: 	Signed(DataWidth-1 downto 0); 
Signal 	PE00_InpEn			:  	Std_Logic;
Signal 	PE00_InpReady		:	Unsigned(ViCh-1 downto 0);
Signal 	PE00_InpSel			:  	Unsigned(ViChAddr-1 downto 0);

Signal 	PE00_OutpData		:	Signed(DataWidth-1 downto 0); 
Signal 	PE00_OutpEn			:	Std_Logic;
Signal 	PE00_OutpReady		:  	Unsigned(ViCh-1 downto 0);
Signal 	PE00_OutpSel		:	Unsigned(ViChAddr-1 downto 0);


Signal 	PE01_InpData		: 	Signed(DataWidth-1 downto 0); 
Signal 	PE01_InpEn			:  	Std_Logic;
Signal 	PE01_InpReady		:	Unsigned(ViCh-1 downto 0);
Signal 	PE01_InpSel			:  	Unsigned(ViChAddr-1 downto 0);

Signal 	PE01_OutpData		:	Signed(DataWidth-1 downto 0); 
Signal 	PE01_OutpEn			:	Std_Logic;
Signal 	PE01_OutpReady		:  	Unsigned(ViCh-1 downto 0);
Signal 	PE01_OutpSel		:	Unsigned(ViChAddr-1 downto 0);


Signal 	PE10_InpData		: 	Signed(DataWidth-1 downto 0); 
Signal 	PE10_InpEn			:  	Std_Logic;
Signal 	PE10_InpReady		:	Unsigned(ViCh-1 downto 0);
Signal 	PE10_InpSel			:  	Unsigned(ViChAddr-1 downto 0);

Signal 	PE10_OutpData		:	Signed(DataWidth-1 downto 0); 
Signal 	PE10_OutpEn			:	Std_Logic;
Signal 	PE10_OutpReady		:  	Unsigned(ViCh-1 downto 0);
Signal 	PE10_OutpSel		:	Unsigned(ViChAddr-1 downto 0);


Signal 	PE11_InpData		: 	Signed(DataWidth-1 downto 0); 
Signal 	PE11_InpEn			:  	Std_Logic;
Signal 	PE11_InpReady		:	Unsigned(ViCh-1 downto 0);
Signal 	PE11_InpSel			:  	Unsigned(ViChAddr-1 downto 0);

Signal 	PE11_OutpData		:	Signed(DataWidth-1 downto 0); 
Signal 	PE11_OutpEn			:	Std_Logic;
Signal 	PE11_OutpReady		:  	Unsigned(ViCh-1 downto 0);
Signal 	PE11_OutpSel		:	Unsigned(ViChAddr-1 downto 0);	


begin


cm: entity work.Computation
	Generic Map(
		--RowNo		,
		--ColNo		,
		PackGenNum	,
		PackGen)
	Port map(
		Clk				,
		Reset			,

		SentCnt			,
		ReceCnt			,
		AveReceTime		,
		StopOut			,
		StopSim
	);

c1:entity work.NOC 
	Generic Map(
		--RowNo		,
		--ColNo		,
		PackWidth	,
		DataWidth	,
		AddrWidth	,
		
		RoChAddr	,
		PhyChAddr	,
		ViChAddr	,
		PhyRoChAddr	,
		RoCh		,
		PhyCh		,
		ViCh		,
		PhyRoCh		,
		PoissonDelayStr,
		InpFileUniform(0 to ColNo*RowNo-1),
		
		PackGenNum	,
		PackGen)
port map(
		Clk				,
		Reset			,

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

--*************************************************************************************
--*************************************************************************************
-- j = 0, i = 0;
--*************************************************************************************
--*************************************************************************************
P00:entity work.PEv
	Generic Map(
		InpFilePoisson 	=> Str_Add(4,6,InpFilePoissonStr,InpFileUniform(0*ColNo+0)),	
		InpFileUniform	=> InpFileUniform(0*ColNo+0),	
		OutpFilePack	=> Str_Add(9,6,OutpFilePackStr,InpFileUniform(0*ColNo+0)) ,
		OutpFileTime	=> Str_Add(9,6,OutpFileTimeStr,InpFileUniform(0*ColNo+0)) ,
		DataWidth		=> DataWidth,
		ViChAddr		=> ViChAddr,
		ViCh			=> ViCh,
		--
		CurNode			=> 0*ColNo+0,
		PackSize		=> PackSize,
		PackWidth		=> PackWidth,
		PackGen			=> PackGen(0*ColNo+0),
		PackGenNum		=> PackGenNum
	)
	Port Map(
		Clk				=> Clk,
		Reset			=> Reset,

		InpData 		=> PE00_InpData     ,
		InpEn 			=> PE00_InpEn		,
		InpReady 		=> PE00_InpReady	,
		InpSel 			=> PE00_InpSel		,

		OutpData 		=> PE00_OutpData	,
		OutpEn 			=> PE00_OutpEn		,
		OutpReady 		=> PE00_OutpReady	,
		OutpSel 		=> PE00_OutpSel	,
		
		SentCnt			=> SentCnt(0*ColNo+0)		,			
		ReceCnt			=> ReceCnt(0*ColNo+0)		,
		AveReceTime		=> AveReceTime(0*ColNo+0)	,

		StopSim			=> StopSim
	);

--*************************************************************************************
--*************************************************************************************
-- j = 0, i = 1;
--*************************************************************************************
--*************************************************************************************
P01:entity work.PEv
	Generic Map(
		InpFilePoisson 	=> Str_Add(4,6,InpFilePoissonStr,InpFileUniform(0*ColNo+1)),	
		InpFileUniform	=> InpFileUniform(0*ColNo+1),	
		OutpFilePack	=> Str_Add(9,6,OutpFilePackStr,InpFileUniform(0*ColNo+1)) ,
		OutpFileTime	=> Str_Add(9,6,OutpFileTimeStr,InpFileUniform(0*ColNo+1)) ,
		DataWidth		=> DataWidth,
		ViChAddr		=> ViChAddr,
		ViCh			=> ViCh,
		--
		CurNode			=> 0*ColNo+1,
		PackSize		=> PackSize,
		PackWidth		=> PackWidth,
		PackGen			=> PackGen(0*ColNo+1),
		PackGenNum		=> PackGenNum
	)
	Port Map(
		Clk				=> Clk,
		Reset			=> Reset,

		InpData 		=> PE01_InpData     ,
		InpEn 			=> PE01_InpEn		,
		InpReady 		=> PE01_InpReady	,
		InpSel 			=> PE01_InpSel		,

		OutpData 		=> PE01_OutpData	,
		OutpEn 			=> PE01_OutpEn		,
		OutpReady 		=> PE01_OutpReady	,
		OutpSel 		=> PE01_OutpSel	,
		
		SentCnt			=> SentCnt(0*ColNo+1)		,			
		ReceCnt			=> ReceCnt(0*ColNo+1)		,
		AveReceTime		=> AveReceTime(0*ColNo+1)	,

		StopSim			=> StopSim
	);

--*************************************************************************************
--*************************************************************************************
-- j = 1, i = 0;
--*************************************************************************************
--*************************************************************************************
P10:entity work.PEv
	Generic Map(
		InpFilePoisson 	=> Str_Add(4,6,InpFilePoissonStr,InpFileUniform(1*ColNo+0)),	
		InpFileUniform	=> InpFileUniform(1*ColNo+0),	
		OutpFilePack	=> Str_Add(9,6,OutpFilePackStr,InpFileUniform(1*ColNo+0)) ,
		OutpFileTime	=> Str_Add(9,6,OutpFileTimeStr,InpFileUniform(1*ColNo+0)) ,
		DataWidth		=> DataWidth,
		ViChAddr		=> ViChAddr,
		ViCh			=> ViCh,
		--
		CurNode			=> 1*ColNo+0,
		PackSize		=> PackSize,
		PackWidth		=> PackWidth,
		PackGen			=> PackGen(1*ColNo+0),
		PackGenNum		=> PackGenNum
	)
	Port Map(
		Clk				=> Clk,
		Reset			=> Reset,

		InpData 		=> PE10_InpData     ,
		InpEn 			=> PE10_InpEn		,
		InpReady 		=> PE10_InpReady	,
		InpSel 			=> PE10_InpSel		,

		OutpData 		=> PE10_OutpData	,
		OutpEn 			=> PE10_OutpEn		,
		OutpReady 		=> PE10_OutpReady	,
		OutpSel 		=> PE10_OutpSel	,
		
		SentCnt			=> SentCnt(1*ColNo+0)		,			
		ReceCnt			=> ReceCnt(1*ColNo+0)		,
		AveReceTime		=> AveReceTime(1*ColNo+0)	,

		StopSim			=> StopSim
	);

	
--*************************************************************************************
--*************************************************************************************
-- j = 1, i = 1;
--*************************************************************************************
--*************************************************************************************
P11:entity work.PEv
	Generic Map(
		InpFilePoisson 	=> Str_Add(4,6,InpFilePoissonStr,InpFileUniform(1*ColNo+1)),	
		InpFileUniform	=> InpFileUniform(1*ColNo+1),	
		OutpFilePack	=> Str_Add(9,6,OutpFilePackStr,InpFileUniform(1*ColNo+1)) ,
		OutpFileTime	=> Str_Add(9,6,OutpFileTimeStr,InpFileUniform(1*ColNo+1)) ,
		DataWidth		=> DataWidth,
		ViChAddr		=> ViChAddr,
		ViCh			=> ViCh,
		--
		CurNode			=> 1*ColNo+1,
		PackSize		=> PackSize,
		PackWidth		=> PackWidth,
		PackGen			=> PackGen(1*ColNo+1),
		PackGenNum		=> PackGenNum
	)
	Port Map(
		Clk				=> Clk,
		Reset			=> Reset,

		InpData 		=> PE11_InpData     ,
		InpEn 			=> PE11_InpEn		,
		InpReady 		=> PE11_InpReady	,
		InpSel 			=> PE11_InpSel		,

		OutpData 		=> PE11_OutpData	,
		OutpEn 			=> PE11_OutpEn		,
		OutpReady 		=> PE11_OutpReady	,
		OutpSel 		=> PE11_OutpSel	,
		
		SentCnt			=> SentCnt(1*ColNo+1)		,			
		ReceCnt			=> ReceCnt(1*ColNo+1)		,
		AveReceTime		=> AveReceTime(1*ColNo+1)	,

		StopSim			=> StopSim
	);




	clk1: process
	begin
		while not Stop2 loop
			wait for Period/2;
			Clk <= not Clk;
		end loop;
		wait;
	end process;
	
	Stop <= False , True After Period*500 When ((StopOut='1') Or (Now>=150000*Period)) ;-- 30000*Period;
	Stop2 <= Stop After Period;
	
	StopSim <= '1' When (Stop) Else '0';
	
	ci:process
	begin
	
		Reset	<= '1';
		Wait for Period;
		wait until (rising_edge(Clk));-- 0-
		Reset	<= '0';
		wait;
	end process;

	
end;
