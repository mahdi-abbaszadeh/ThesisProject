-- NOCSynSim
-- Network on a Chip Synthesisable and Simulation VHDL Model
-- Version: 1.0 
-- Last Update: 2006/10/04
-- Sharif University of Technology
-- Computer Department
-- High Performance Computing Group - Dr.Sarbazi Azad
-- Author: D.Rahmati

Library IEEE;
Use IEEE.STD_LOGIC_1164.All;
Use IEEE.NUMERIC_STD.All;
Use Work.ConnectionPack.All;

entity Node is
	generic(
		InpFilePoisson	: String  := "Poisson.txt";
		InpFileUniform	: String  := "Uniform.txt";
		OutpFilePack	: String  := "Outp.txt";
		OutpFileTime	: String  := "TimeOutp.txt";

		ViChAddr	: Integer := 1;
		PhyRoChAddr	: Integer := 2+1;
		--
		PhyCh		: Integer := 4;
		ViCh		: Integer := 2;
		RoCh 		: Integer := 1;
		PhyRoCh		: Integer := 4+1;
		--
		PackWidth	: Integer := 8;
		DataWidth	: Integer := 8;
		CorWidth	: Integer := 4;
		--
		--X			: Integer := 0;
		--Y			: Integer := 0;
		CurNode		: Integer := 0;
		PackGen		: std_logic :='1';
		PackGenNum	: Unsigned(15 Downto 0)
	);
	Port(
		Clk				: In  std_logic;
		Reset			: In  std_logic;

		InpData			: In  SignedArrDW(PhyRoCh-1 downto 0); --? 8+2
		InpEn			: In  Unsigned(PhyRoCh-1 downto 0);
		InpReady		: Out Unsigned(PhyRoCh*ViCh-1 downto 0);
		InpSel			: In  UnsignedArrVCA(PhyRoCh-1 downto 0); -- ? ViChAddr=1

		OutpData		: Out SignedArrDW(PhyRoCh-1 downto 0); --? 8+2
		OutpEn			: Out Unsigned(PhyRoCh-1 downto 0);
		OutpReady		: In  Unsigned(PhyRoCh*ViCh-1 downto 0);
		OutpSel			: Out UnsignedArrVCA(PhyRoCh-1 downto 0) -- ? ViChAddr=1

		--SentCnt			: Out Unsigned(15 Downto 0);
		--ReceCnt			: Out Unsigned(15 Downto 0);
		--AveReceTime		: Out Unsigned(19 Downto 0);
		--StopSim			: In Std_Logic
	);
End;


Architecture behavioral of Node is

Signal	CurrentNode		: Integer := 0;
--Signal	YY				: Integer := 0;

--Signal InpSel			: UnsignedArrVCA(PhyCh-1 downto 0); -- ? ViChAddr=1

--Signal	OutpSel			: UnsignedArrVCA(PhyCh-1 downto 0); -- ? ViChAddr=1
		
Signal	OutpDataArr		: SignedArrDW(PhyRoCh-1 downto 0); --? 8+2
Signal	OutpEnArr		: Unsigned(PhyRoCh-1 downto 0);
Signal	OutpReadyArr	: Unsigned(PhyRoCh*ViCh-1 downto 0);
Signal	OutpSelArr		: UnsignedArrVCA(PhyRoCh-1 downto 0); -- ? ViChAddr=1

Signal	InpDataArr		: SignedArrDW(PhyRoCh-1 downto 0); --? 8+2
Signal	InpEnArr		: Unsigned(PhyRoCh-1 downto 0);
Signal	InpReadyArr		: Unsigned(PhyRoCh*ViCh-1 downto 0);
Signal 	InpSelArr		: UnsignedArrVCA(PhyRoCh-1 downto 0); -- ? ViChAddr=1

Begin

CurrentNode <= CurNode;
--YY <= Y;

InpDataArr(PhyRoCh-1 Downto 0) 	<=	InpData		;		
InpEnArr(PhyRoCh-1 Downto 0)	<=	InpEn		;	
InpReady						<=	InpReadyArr(PhyRoCh*ViCh-1 Downto 0);	
InpSelArr(PhyRoCh-1 Downto 0)	<=	InpSel		;	

OutpData	<=	OutpDataArr(PhyRoCh-1 Downto 0)		;	
OutpEn		<=	OutpEnArr(PhyRoCh-1 Downto 0)			;	
OutpReadyArr(PhyRoCh*ViCh-1 Downto 0) <= OutpReady	;	
OutpSel		<=	OutpSelArr(PhyRoCh-1 Downto 0)		;	

n1: Entity Work.Router 
	Generic Map(
		ViChAddr		,
		PhyRoChAddr	,
		--
		PhyCh		,
		ViCh			,
		RoCh 		,
		PhyRoCh		,
		--
		PackWidth	,
		DataWidth	,
		CorWidth	,
		--
		CurNode	
			
		)
	Port Map(
		 Clk			,	
		 Reset		,	

		 InpDataArr	,	
		 InpEnArr		,	
		 InpReadyArr	,
		 InpSelArr	,		

		 OutpDataArr	,
		 OutpEnArr	,	
		 OutpReadyArr	,	
		 OutpSelArr			
	);
	
--n2: Entity Work.PEv 
--		Generic Map(
--			InpFilePoisson,	
--			InpFileUniform,	
--			OutpFilePack	 ,
--			OutpFileTime	,
--			DataWidth	,
--			ViChAddr		,
--			ViCh			,
--			--
--			CurNode	,
--			PackSize,
--			PackWidth	,
--			PackGen		,
--			PackGenNum
--		)
--		Port Map(
--			Clk						,
--			Reset						,
	
--			OutpDataArr(PhyRoCh-1)	,
--			OutpEnArr(PhyRoCh-1)		,
--			OutpReadyArr(PhyRoCh*ViCh-1 Downto (PhyRoCh-1)*ViCh)	,
--			OutpSelArr(PhyRoCh-1)		,
	
--			InpDataArr(PhyRoCh-1)		,
--			InpEnArr(PhyRoCh-1)		,
--			InpReadyArr(PhyRoCh*ViCh-1 Downto (PhyRoCh-1)*ViCh)	,
--			InpSelArr(PhyRoCh-1)		,		
			
--			SentCnt,			
--			ReceCnt,
--			AveReceTime,

--			StopSim

--	);
End;