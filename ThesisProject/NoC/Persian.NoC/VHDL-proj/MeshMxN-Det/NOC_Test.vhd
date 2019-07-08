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
Use work.FilePack.all;


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


Signal InpData_sig 		: 	SignedArrDW(RowNo*ColNo-1 downto 0); --? 8+2 --outputdata from NIOS view
Signal InpEn_sig 		: 	Unsigned(RowNo*ColNo-1 downto 0);
Signal InpReady_sig 	: 	Unsigned(RowNo*ColNo*ViCh-1 downto 0);
Signal InpSel_sig 		:	UnsignedArrVCA(RowNo*ColNo-1 downto 0); -- ? ViChAddr=1

Signal OutpData_sig 	: 	SignedArrDW(RowNo*ColNo-1 downto 0); --? 8+2
Signal OutpEn_sig 		: 	Unsigned(RowNo*ColNo-1 downto 0);
Signal OutpReady_sig 	: 	Unsigned(RowNo*ColNo*ViCh-1 downto 0);
Signal OutpSel_sig 		: 	UnsignedArrVCA(RowNo*ColNo-1 downto 0); -- ? ViChAddr=1


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
		Clk				=> 	Clk		,	
		Reset			=>	Reset		,
		InpDataArr		=>	InpData_sig	,
		InpEnArr		=>	InpEn_sig 	,
		InpReadyArr		=>	InpReady_sig, 	
		InpSelArr		=>	InpSel_sig 	,

		OutpDataArr		=>	OutpData_sig, 
		OutpEnArr		=>	OutpEn_sig 	,
		OutpReadyArr	=>	OutpReady_sig,
		OutpSelArr		=>	OutpSel_sig 	
		--SentCnt			,
		--ReceCnt			,
		--AveReceTime		,
		--StopSim
		);

	mg1: For j in 0 to RowNo-1 Generate
		mg2: For i in 0 to ColNo-1 Generate

		p1: Entity Work.PEv 
			Generic Map(
				InpFilePoisson 	=> Str_Add(4,6,InpFilePoissonStr,InpFileUniform(j*ColNo+i)),	
				InpFileUniform	=> InpFileUniform(j*ColNo+i),	
				OutpFilePack	=> Str_Add(9,6,OutpFilePackStr,InpFileUniform(j*ColNo+i)) ,
				OutpFileTime	=> Str_Add(9,6,OutpFileTimeStr,InpFileUniform(j*ColNo+i)) ,
				DataWidth		=> DataWidth,
				ViChAddr		=> ViChAddr,
				ViCh			=> ViCh,
				--
				CurNode			=> j*ColNo+i,
				PackSize		=> PackSize,
				PackWidth		=> PackWidth,
				PackGen			=> PackGen(j*ColNo+i),
				PackGenNum		=> PackGenNum
			)
			Port Map(
				Clk				=> Clk,
				Reset			=> Reset,
		
				InpData 		=> OutpData_sig(j*ColNo+i),
				InpEn 			=> OutpEn_sig(j*ColNo+i),
				InpReady 		=> OutpReady_sig((j*ColNo+i)*ViCh + (ViCh-1) Downto (j*ColNo+i)*ViCh),
				InpSel 			=> OutpSel_sig(j*ColNo+i),
		
				OutpData 		=> InpData_sig(j*ColNo+i),
				OutpEn 			=> InpEn_sig(j*ColNo+i),
				OutpReady 		=> InpReady_sig((j*ColNo+i)*ViCh + (ViCh-1) Downto (j*ColNo+i)*ViCh),
				OutpSel 		=> InpSel_sig(j*ColNo+i),
				
				SentCnt			=> SentCnt(j*ColNo+i)		,			
				ReceCnt			=> ReceCnt(j*ColNo+i)		,
				AveReceTime		=> AveReceTime(j*ColNo+i)	,

				StopSim			=> StopSim		
		);

		End Generate;	
	End Generate;


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
