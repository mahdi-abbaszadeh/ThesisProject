-- NOCSynSim
-- Network on a Chip Synthesisable and Simulation VHDL Model
-- Version: 1.0 
-- Last Update: 2006/10/04
-- Sharif University of Technology
-- Computer Department
-- High Performance Computing Group
-- Author: D.Rahmati

Library IEEE;
Use IEEE.STD_LOGIC_1164.All;
Use IEEE.NUMERIC_STD.All;
Use Work.ConnectionPack.All;
use work.FilePack.all;

entity ReaderV is
	generic(
		InpFilePoisson	: String  := "Poisson.txt";
		InpFileUniform	: String  := "Uniform.txt";

		DataWidth	: Integer := 8;
		ViChAddr	: Integer := 1;
		ViCh		: Integer := 1;
		--
		--X			: Integer := 0;
		--Y			: Integer := 0;
		CurNode		: Integer := 0;
		PackWidth	: Integer := 8; -- bit of pack size
		PackGen		: std_logic :='1';
		PackGenNum	: Unsigned(15 Downto 0);
		PackSize: Integer :=64

	);
	Port(
		Clk				: In  Std_Logic:='0';
		Reset			: In  Std_Logic;

		OutpData		: Out SignedArrDW(ViCh-1 downto 0);--(DataWidth-1 downto 0); 
		OutpEn			: Buffer Unsigned(ViCh-1 downto 0);
		OutpReady		: In  Unsigned(ViCh-1 downto 0);
		
		SentCnt			: Buffer Unsigned(15 Downto 0);
		ReadFin			: Out Boolean;
		Stop			: In Boolean
	);
End;


Architecture Behavioral of ReaderV is

--Constant RowNo: Integer :=4;
--Constant ColNo: Integer :=4;
Constant PoissonWidth : Integer := 14; --2**14=16000
Constant TimeOffset : Integer := 3;


signal DataPoisson:	IntVectorNx1(ViCh-1 Downto 0);
signal DataUniform:	IntVectorNx1(ViCh-1 Downto 0);
Signal TimeSum:	Integer;
signal ReadFin1:	boolean;
signal ReadFin2:	boolean;
Signal Counter :  UnsignedArr14(ViCh-1 Downto 0); -- (PoissonWidth-1 Downto 0);
Signal Receiver :  IntVector(ViCh-1 Downto 0);
Signal TimeCounter :  Unsigned(31 Downto 0);
Signal LTCounter :  UnsignedArr32(ViCh-1 Downto 0);
Signal Data :  SignedArrDW(ViCh-1 Downto 0);--(DataWidth-1 Downto 0);
Signal Rec :  SignedArrDW(ViCh-1 Downto 0);--(DataWidth-1 Downto 0);
signal OutpEnPoisson:Unsigned(ViCh-1 Downto 0);
signal OutpEnUniform:Unsigned(ViCh-1 Downto 0);
signal ReadF,PreReadF :	std_logic;
signal ReadFI,PreReadFI:Unsigned(ViCh-1 Downto 0);
Signal FirstTime : Std_Logic;
Signal PackCnt : Unsigned(15 Downto 0);
Signal DisableSend : Unsigned(ViCh-1 Downto 0);
Begin

	OutpData <= Data;					
	ReadFin <= ReadFin1 And ReadFin2;

 
	Process (Clk)
		Begin
			If (Rising_Edge(Clk)) Then
				If (Reset='1') Then
					TimeCounter <= (Others=>'0');
				Else
					TimeCounter <= TimeCounter + 1;
				End If;		
			End If;
	End Process;	


	fr1: ReadFileV1(Len			=> ViCh,
					FileName	=> InpFilePoisson,
					Clock		=> Clk,
					ReadEn		=> ReadF,
					ReadEnI		=> ReadFI,
					Stop		=> Stop,
					Output		=> DataPoisson,
					Finished	=> ReadFin1,
					DataValid	=> OutpEnPoisson);

	fr2: ReadFileV1(Len			=> ViCh,	
					FileName	=> InpFileUniform,
					Clock		=> Clk,
					ReadEn		=> ReadF,
					ReadEnI		=> ReadFI,
					Stop		=> Stop,
					Output		=> DataUniform,
					Finished	=> ReadFin2,
					DataValid	=> OutpEnUniform);
	
	SentCnt <= PackCnt;

	Process(Clk)
	Variable TimeSumVar : Integer;
	Variable Continue : Std_Logic;
	Variable PackCntVar : Unsigned(15 Downto 0);
	
	Begin
		If Rising_Edge(Clk) Then
			If (Reset='1') Then
				Counter <= (Others=>(Others=>'0'));
				--
				ReadFI <= (Others=>'0');
				FirstTime <= '1';
				Receiver <= (Others=>0);
				TimeSum <= PackSize;
				PackCnt <= (Others=>'0');
				DisableSend <= (Others=>'0');
			Else
				PackCntVar := PackCnt;
				For i In 0 To ViCh-1 Loop
					If (OutpReady(i)='1') Or (FirstTime='1')Then
						If (Counter(i)>=PackSize) Then -- surely FirstTime is '0'
							If (LTCounter(i)<=TimeCounter) Then
								Counter(i) <= (Others=>'0');
							End IF;
						Else
							--
							If (FirstTime='0') And (Counter(i)=0) Then
								If (PackCntVar>=PackGenNum) Then
									DisableSend(i) <= '1';
								Elsif(PackGen='1') Then
									PackCntVar := PackCntVar+1;
								End If;		
							End If;
							--
							Counter(i) <= Counter(i)+1;
						End IF;
					End If;
				End Loop;	
				PackCnt <= PackCntVar;
				PreReadF <= ReadF;
				TimeSumVar := TimeSum;
				For i In 0 To ViCh-1 Loop
					If (OutpReady(i)='1') Or (FirstTime='1') Or (ReadFI(i)='1') Then
						ReadFI(i) <= '0';
						If (Counter(i)=PackSize-3) And (ReadFI(i)='0')Then -- only one clk ReadF may be '1'
							ReadFI(i) <= '1';
						Elsif (Counter(i)=PackSize-1) Then
							FirstTime <= '0';						
						End If;
					End If;			
					--------------------- 
					PreReadFI(i) <= ReadFI(i);
					If (PreReadFI(i)='1') Then
						If (OutpEnPoisson(i)='1') Then -- not necessary
							TimeSumVar := TimeSumVar + DataPoisson(i)(1);
							LTCounter(i) <= To_Unsigned(TimeSumVar,32);
						End If;
						If (OutpEnUniform(i)='1') Then -- not necessary
							Receiver(i) <= DataUniform(i)(1);
						End If;
					End If;	
				End Loop;	
				TimeSum <= TimeSumVar;
			End If;
		End If;
	End Process;
	
	Process(Counter,LTCounter,Receiver,FirstTime,ReadFI)
--	Process(Counter,LTCounter,Receiver,FirstTime,LatchedSendActive,ReadFI,OutpReady)
	Variable ReadFVar : Std_Logic;
	Begin
		ReadFVar := '0';
		For i In 0 To ViCh-1 Loop
			If (Counter(i)=0) Then
				-- 05, Aug 2006 topology globalization by D.R.	
				--Data(i) <= To_Signed(Receiver(i),DataWidth) Mod ColNo; --x
				Data(i) <= To_Signed(Receiver(i),DataWidth); --x
			Elsif (Counter(i)=1) Then
				-- 05, Aug 2006 topology globalization by D.R.	
				Data(i) <= To_Signed(CurNode,DataWidth); --y
				--Data(i) <= To_Signed(DefExtData,DataWidth); --y
			Elsif (Counter(i)=2) Then
				Data(i) <= To_Signed(PackSize,DataWidth);
			Elsif (Counter(i)=3) Then
				Data(i) <= Signed(LTCounter(i)(31 Downto 24));
			Elsif (Counter(i)=4) Then
				Data(i) <= Signed(LTCounter(i)(23 Downto 16));
			Elsif (Counter(i)=5) Then
				Data(i) <= Signed(LTCounter(i)(15 Downto 8));
			Elsif (Counter(i)=6) Then
				Data(i) <= Signed(LTCounter(i)(7 Downto 0));
			Elsif (Counter(i)=7) Then
				Data(i) <= To_Signed(CurNode,DataWidth);
			Elsif (Counter(i)=8) Then
				--Data(i) <= To_Signed(CurNode,DataWidth);
				Data(i) <= To_Signed(Receiver(i),DataWidth);
				Rec(i) <= To_Signed(Receiver(i),DataWidth);
			Elsif (Counter(i)=PackSize-1) Then
				Data(i) <= To_Signed(Receiver(i)+100,DataWidth);
			Else
				Data(i) <= Rec(i);
			End If;
			
			-- bug If ((Counter(i)>=0) And (Counter(i)<=PackSize-1) And (FirstTime='0') And (LatchedSendActive(i)='1')) Then
			-- bug2 If ((Counter(i)>=0) And (Counter(i)<=PackSize-1) And (FirstTime='0') And (SendEn='1') And (PackGen='1')) Then
			-- bug3 If ((Counter(i)>=0) And (Counter(i)<=PackSize-1) And (FirstTime='0') And (PackCnt<PackGenNum) And (PackGen='1')) Then
			If ((Counter(i)>=0) And (Counter(i)<=PackSize-1) And (FirstTime='0') And (DisableSend(i)='0') And (PackGen='1')) Then
				OutpEn(i) <= '1';
			Else
				OutpEn(i) <= '0';
			End If;	

			ReadFVar := ReadFVar Or ReadFI(i);		
			
		End Loop;	
		ReadF <= ReadFVar;
	End Process;
	
End;

Library IEEE;
Use IEEE.STD_LOGIC_1164.All;
Use IEEE.NUMERIC_STD.All;
Use Work.ConnectionPack.All;
use work.FilePack.all;

use STD.textio.all;                     -- basic I/O
use IEEE.std_logic_textio.all;          -- I/O for logic types

entity Writer is
	generic(
		OutpFilePack	: String  := "Outp.txt";
		OutpFileTime	: String  := "TimeOutp.txt";
		DataWidth	: Integer := 8;
		ViChAddr	: Integer := 1;
		ViCh		: Integer := 1;
		--
		--X			: Integer := 0;
		--Y			: Integer := 0;
		CurNode		: Integer := 0;
		PackWidth	: Integer := 8; -- bit of pack size
		PackGen		: std_logic :='1';
		PackGenNum	: Unsigned(15 Downto 0);
		PackSize: Integer :=64

	);
	Port(
		Clk				: In  Std_Logic:='0';
		Reset			: In  Std_Logic;

		InpData			: In  Signed(DataWidth-1 downto 0); 
		InpEn			: In  Std_Logic;
		InpReady		: Out Std_Logic;
	
		ReceCnt			: Buffer Unsigned(15 Downto 0);	
		AveReceTime		: Out Unsigned(19 Downto 0);
		SumTimeData		: Buffer Integer;
		Number			: Buffer Integer;
		WriteFin		: Out Boolean;
		Stop			: In Boolean
	);
End;


Architecture Behavioral of Writer is

Constant TimeOffset : Integer := 3;
Constant IgnorePercent :Integer :=RecePackIgnorePercent/ViCh; --20%
signal SaveData:	IntVector(1 to 1);
signal TData:	IntVector(1 to 3);
Signal TimeData:	Integer;
--Signal SumTimeData:	Integer;
--Signal Number:	Integer:=1000000;
signal WriteTime:	std_logic;
signal WriteFin1:boolean;
signal WriteFin2:boolean;
Signal InpPackCounter :  Unsigned(PackWidth-1 Downto 0);
Signal TimeCounter :  Unsigned(31 Downto 0);
signal PreInpEn:	std_logic;
Signal PackFinishedFlag : Std_Logic:='0';
Signal IgnoreNum :Integer ;
Signal RecNode,SrcNode,ErrNo :Integer ;
Begin

	WriteFin <= WriteFin1 And WriteFin2;
	Process (Clk)
		Begin
			If (Rising_Edge(Clk)) Then
				If (Reset='1') Then
					TimeCounter <= (Others=>'0');
				Else
					TimeCounter <= TimeCounter + 1;
				End If;		
			End If;
	End Process;	


		fw1: WriteFile2(WriteActive => DumpTimePackFile,	
						FileName	=> OutpFilePack,
						Clock		=> Clk,
						WriteEn		=> InpEn,
						Stop		=> Stop,
						Input		=> SaveData,
						Finished	=> WriteFin1);
					
		fw2: WriteFile2(WriteActive => DumpTimePackFile,	
						FileName	=> OutpFileTime,
						Clock		=> Clk,
						WriteEn		=> WriteTime,
						Stop		=> Stop,
						Input		=> TData,
						Finished	=> WriteFin2);
					
		SaveData(1) <= to_integer(InpData);
		TData(1) <= TimeData;
		TData(2) <= SumTimeData;
		IgnoreNum <= To_Integer((IgnorePercent*PackGenNum)/100);
		Number <= (To_Integer(ReceCnt)-IgnoreNum) When (ReceCnt>((IgnorePercent*PackGenNum)/100)) Else 0;
		TData(3) <= SumTimeData/Number When (Number/=0) Else 0;
		AveReceTime <= To_Unsigned(SumTimeData/Number,20) When (Number/=0) Else (Others=>'0');
		InpReady <= '1';
		------
		------
		
		
		--Process (Clk)
		--Begin
		--	If (Rising_Edge(Clk)) Then
		--		If (Reset='1') Then
		--			ReceCnt	<= (Others=>'0');			
		--		Else
		--			If (WriteTime='1') Then
		--				ReceCnt <= ReceCnt +1;
		--			End If;	
		--		End If;
		--	End If;
		--End Process;
		
		Process (Clk)
        variable my_line : line;  -- type 'line' comes from textio
		Begin
			If (Rising_Edge(Clk)) Then
				If (Reset='1') Then
					InpPackCounter <= (Others=>'0');
					WriteTime <= '0';							
					SumTimeData <= 0;
					--
					ReceCnt	<= (Others=>'0');	
					ErrNo <= 0;
				Else
					PreInpEn <= InpEn;
					--after bug 2
					PackFinishedFlag <='0';
					--
					If (InpEn='1') Then
						InpPackCounter <= InpPackCounter + 1;
						If(InpPackCounter>=PackSize-1) Then
							InpPackCounter <= (Others=>'0');
							PackFinishedFlag<='1';
						End If;	
						If(InpPackCounter=TimeOffset) Then
							TimeData <= to_integer(Unsigned(InpData));
						End If;	
						If(InpPackCounter=TimeOffset+1) Then
							TimeData <= TimeData*256+to_integer(Unsigned(InpData));
						End If;	
						If(InpPackCounter=TimeOffset+2) Then
							TimeData <= TimeData*256+to_integer(Unsigned(InpData));
						End If;	
						If(InpPackCounter=TimeOffset+3) Then
							TimeData <= TimeData*256+to_integer(Unsigned(InpData));
						End If;	
						If(InpPackCounter=TimeOffset+4) Then -- Rec node
							SrcNode <= to_integer(Unsigned(InpData));
						End If;	
						If(InpPackCounter=TimeOffset+5) Then -- Rec node
							RecNode <= to_integer(Unsigned(InpData));
						End If;	
					End If;
					
					WriteTime <= '0';		
					-- bug 1: inpen -- If (PreInpEn='1') And (InpEn='0') Then
					-- bug 2: If (PreInpEn='1') And (InpEn='0') And (PackFinishedFlag='1') Then
					If (PackFinishedFlag='1') Then
						WriteTime <= '1';
						--
						ReceCnt <= ReceCnt +1;
						--
						-- after bug 2 : PackFinishedFlag <='0';
						TimeData <= to_integer(TimeCounter)-TimeData;
						SumTimeData <= SumTimeData+to_integer(TimeCounter)-TimeData;
						--
						--If(ReceCnt<=(IgnorePercent*PackGenNum)/100) Then
						If(ReceCnt<(IgnorePercent*PackGenNum)/100) Then
							SumTimeData <= 0;
						End IF;	
						--
						If (CurNode/=RecNode) Then 
							--write(my_line, string'("No="));   -- formatting
							--write(my_line, ErrNo);   -- formatting

							write(my_line, string'("Error Code 10, SCD:"));   -- formatting
               				write(my_line, SrcNode);   -- formatting
							write(my_line, string'(","));   -- formatting
               				write(my_line, CurNode);   -- formatting
							write(my_line, string'(","));   -- formatting
               				write(my_line, RecNode);   -- formatting
               				writeline(output, my_line);               -- write to "output"
               				ErrNo <= ErrNo+1;
               				If(ErrNo>=3) Then
								assert false report "Simulation Failure" severity failure;               				
							End if;
						End If;
					End If;
				End If;		
			End If;
		End Process;	
End;

Library IEEE;
Use IEEE.STD_LOGIC_1164.All;
Use IEEE.NUMERIC_STD.All;
Use Work.ConnectionPack.All;

entity DeMux is
	generic(
		DataWidth	: Integer := 8;
		ViChAddr	: Integer := 1;
		ViCh		: Integer := 2 -- 2**ViChAddr
	);
	port(
		Clk			: In  std_logic;
		Reset		: In  std_logic;
		Sel			: In  Unsigned(ViChAddr-1 Downto 0);
		
		InpData		: In  Signed(DataWidth-1 downto 0); 
		InpEn		: In  Std_Logic;
		InpReady	: Out Unsigned(ViCh-1 downto 0); --Std_Logic;

		OutpData	: Out SignedArrDW(ViCh-1 downto 0); --? DataWidth=8
		OutpEn		: Out Unsigned(ViCh-1 downto 0);
		OutpReady	: In  Unsigned(ViCh-1 downto 0)	
	);
End;


Architecture behavioral of DeMux is

Begin
--	Process(Sel,Reset,OutpReady)
--	Variable Tmp : Integer;
--	Begin
--		If (Reset='1') Then
--		Else	
--			For i In 0 To ViCh-1 Loop  
--				Full(i) <= '0';
--			End Loop;	
--		End If;	
--	End Process;

	Process(Sel,Reset,OutpReady,InpData,InpEn)
	Begin
		If (Reset='1') Then
			InpReady <= (Others=>'0');
			OutpData <= (Others=>(Others=>'0'));
			OutpEn <= (Others=>'0');
		Else	
			For i In 0 To ViCh-1 Loop  
				InpReady(i) <= OutpReady(i);
				OutpData(i) <= (Others=>'0');
				OutpEn(i) <= '0';
				If (Sel=i) Then
					OutpData(i) <= InpData;
					OutpEn(i) <= InpEn;
				End If;
			End Loop;	
		End If;	
	End Process;
	
--	Process (Clk)
--	Begin
--		If (Rising_Edge(Clk)) Then
--			If (Reset='1') Then
--				OutpData <= (Others=>(Others=>'0'));
--				OutpEn <= (Others=>'0');
--				--InpReady <= '0';
--			Else
--				For i In 0 To ViCh-1 Loop 
--					InpReady(i) <= OutpReady(i) Or ( Not Full(i));
--					If (Sel=i) Then
--						OutpData(i) <= InpData;
--						OutpEn(i) <= InpEn;
--						--InpReady <= OutpReady(i);
--					Else	
--						OutpData(i) <= (Others=>'0');
--						OutpEn(i) <= '0';
--					End If;
--				End Loop;	
--			End If;	
--		End If;			
--	End Process;
End;

Library IEEE;
Use IEEE.STD_LOGIC_1164.All;
Use IEEE.NUMERIC_STD.All;
Use Work.ConnectionPack.All;

entity DeMux is
	generic(
		DataWidth	: Integer := 8;
		ViChAddr	: Integer := 1;
		ViCh		: Integer := 2 -- 2**ViChAddr
	);
	port(
		Clk			: In  std_logic;
		Reset		: In  std_logic;
		Sel			: In  Unsigned(ViChAddr-1 Downto 0);
		
		InpData		: In  Signed(DataWidth-1 downto 0); 
		InpEn		: In  Std_Logic;
		InpReady	: Out Unsigned(ViCh-1 downto 0); --Std_Logic;

		OutpData	: Out SignedArrDW(ViCh-1 downto 0); --? DataWidth=8
		OutpEn		: Out Unsigned(ViCh-1 downto 0);
		OutpReady	: In  Unsigned(ViCh-1 downto 0)	
	);
End;


Architecture behavioral of DeMux is

Begin
--	Process(Sel,Reset,OutpReady)
--	Variable Tmp : Integer;
--	Begin
--		If (Reset='1') Then
--		Else	
--			For i In 0 To ViCh-1 Loop  
--				Full(i) <= '0';
--			End Loop;	
--		End If;	
--	End Process;

	Process(Sel,Reset,OutpReady,InpData,InpEn)
	Begin
		If (Reset='1') Then
			InpReady <= (Others=>'0');
			OutpData <= (Others=>(Others=>'0'));
			OutpEn <= (Others=>'0');
		Else	
			For i In 0 To ViCh-1 Loop  
				InpReady(i) <= OutpReady(i);
				OutpData(i) <= (Others=>'0');
				OutpEn(i) <= '0';
				If (Sel=i) Then
					OutpData(i) <= InpData;
					OutpEn(i) <= InpEn;
				End If;
			End Loop;	
		End If;	
	End Process;
	
--	Process (Clk)
--	Begin
--		If (Rising_Edge(Clk)) Then
--			If (Reset='1') Then
--				OutpData <= (Others=>(Others=>'0'));
--				OutpEn <= (Others=>'0');
--				--InpReady <= '0';
--			Else
--				For i In 0 To ViCh-1 Loop 
--					InpReady(i) <= OutpReady(i) Or ( Not Full(i));
--					If (Sel=i) Then
--						OutpData(i) <= InpData;
--						OutpEn(i) <= InpEn;
--						--InpReady <= OutpReady(i);
--					Else	
--						OutpData(i) <= (Others=>'0');
--						OutpEn(i) <= '0';
--					End If;
--				End Loop;	
--			End If;	
--		End If;			
--	End Process;
End;

Library IEEE;
Use IEEE.STD_LOGIC_1164.All;
Use IEEE.NUMERIC_STD.All;
Use Work.ConnectionPack.All;

entity Selector is
	generic(
		ViChAddr	: Integer := 1;
		ViCh		: Integer := 2 -- 2**ViChAddr
	);
	port(
		Clk			: In  std_logic;
		Reset		: In  std_logic;
		Sel			: Buffer Unsigned(ViChAddr-1 Downto 0):=(Others=>'0');
		InpEn		: In  Unsigned(ViCh-1 downto 0);
		OutpReady	: In  Unsigned(ViCh-1 downto 0) --Std_Logic
	);
End;


Architecture behavioral of Selector is
Signal Flag : Unsigned(2 Downto 0);
Begin
	--Sel <= (Others=>'0');
	
	Process (Clk)
	Variable Assigned : Std_Logic;
	Variable SelV : Integer;
	Begin
	
		If (Rising_Edge(Clk)) Then
			If (Reset='1') Then
				Sel <= (Others=>'0');
				Flag <= (Others=>'0');
			Else
				If (InpEn(To_Integer(Sel))='0') Or (OutpReady(To_Integer(Sel))='0')  Then
					Sel <= Sel+1;
					If (sel=ViCh-1) Then
						sel <= (Others=>'0');
					End If;						
				End If;	
			End If;
		End If;


--		If (Rising_Edge(Clk)) Then
--			Sel <= Sel+1;
--		End If;

------------------------------------------

--		If (Rising_Edge(Clk)) Then
--			If (Reset='1') Then
--				Sel <= (Others=>'0');
--				Flag <= (Others=>'0');
--			Else
--				--If (InpEn(To_Integer(Sel))='0') Or (OutpReady(To_Integer(Sel))='0')  Then
--				If (InpEn(To_Integer(Sel))='0') Then
--					Flag <= Flag+1;
--				End If;
--				If (Flag>=3) And (InpEn(To_Integer(Sel))='0') Then
--					Flag <= (Others=>'0');
--					Assigned:='0';
--					Sel <= (Others=>'Z');
--					For i In 1 To ViCh-1 Loop 
--						SelV:= 0;--To_Integer(Sel)+i;
--						--If (SelV>ViCh-1) Then
--						--	SelV := SelV - ViCh;
--						--End If;	
--						If (OutpReady(SelV)='1') And (Assigned='0') Then	
--							Sel<=To_Unsigned(SelV,ViChAddr);
--							Assigned:='1';
--						End If;
--					End Loop;
--				End If;	
--			End If;	
--		End If;			
	End Process;
End;

Library IEEE;
Use IEEE.STD_LOGIC_1164.All;
Use IEEE.NUMERIC_STD.All;
Use Work.ConnectionPack.All;

entity Mux is
	generic(
		DataWidth	: Integer := 8;
		ViChAddr	: Integer := 1;
		ViCh		: Integer := 2 -- 2**ViChAddr
	);
	port(
		Clk			: In  std_logic;
		Reset		: In  std_logic;
		Sel			: Buffer Unsigned(ViChAddr-1 Downto 0);
		
		InpData		: In  SignedArrDW(ViCh-1 downto 0); --? DataWidth=8
		InpEn		: In  Unsigned(ViCh-1 downto 0);
		InpReady	: Out Unsigned(ViCh-1 downto 0);	

		OutpData	: Out Signed(DataWidth-1 downto 0); 
		OutpEn		: Out Std_Logic;
		OutpReady	: In  Unsigned(ViCh-1 downto 0) --Std_Logic
	);
End;


Architecture behavioral of Mux is
Signal Sel_Int : Unsigned(ViChAddr-1 Downto 0);
Begin

	Process(Sel_Int,Reset,OutpReady)
	Variable Tmp : Integer;
	Begin
		If (Reset='1') Then
			InpReady <= (Others=>'0');
		Else	
			For i In 0 To ViCh-1 Loop  
				InpReady(i) <= '0';
				If (Sel_Int=i) Then
					InpReady(i) <= OutpReady(i);
				End If;
			End Loop;	
		End If;	
	End Process;
	
	Process (Sel_Int,Reset,OutpReady,InpEn,InpData)
	Begin
		If (Reset='1') Then
			OutpData <= (Others=>'0');
			OutpEn <= '0';
		Else
			OutpData <= (Others=>'Z');
			OutpEn <= '0';						
			For i In 0 To ViCh-1 Loop
--				If (Sel_Int=i) And (InpEn(i)='1') And (OutpReady(i)='1')Then
				If (Sel_Int=i) And (InpEn(i)='1') Then
					OutpData <= InpData(i);
					OutpEn <= '1';			
				End If;
			End Loop;	
		End If;
	End Process;
	Sel <= Sel_Int;

--	Process (Clk)
--	Variable PreInd : Integer:=0;
--	Begin
--		If (Rising_Edge(Clk)) Then
--			If (Reset='1') Then
--				OutpData <= (Others=>'0');
--				OutpEn <= '0';
--				Sel <= (Others=>'0');
--			Else
--				Sel <= Sel_Int;
--				OutpData <= (Others=>'Z');
--				OutpEn <= '0';						
--				For i In 0 To ViCh-1 Loop
--					If (Sel_Int=i) And (InpEn(i)='1') Then
--						OutpData <= InpData(i);
--						OutpEn <= '1';			
--					End If;
--				End Loop;	
--			End If;
--		End If;			
--	End Process;
	
	c1:Entity Work.Selector 
		Generic Map(
			ViChAddr	,
			ViCh		
		)
		Port Map(
			Clk			,
			Reset		,
			Sel_Int		,
			InpEn		,
			OutpReady	
	);
End;

Library IEEE;
Use IEEE.STD_LOGIC_1164.All;
Use IEEE.NUMERIC_STD.All;
Use Work.ConnectionPack.All;
use work.FilePack.all;

entity PEv is
	generic(
		InpFilePoisson	: String  := "Poisson.txt";
		InpFileUniform	: String  := "Uniform.txt";
		OutpFilePack	: String  := "Outp.txt";
		OutpFileTime	: String  := "TimeOutp.txt";
		DataWidth		: Integer := 8;
		ViChAddr		: Integer := 1;
		ViCh			: Integer := 1;
		--
		--X			: Integer := 0;
		--Y			: Integer := 0;
		CurNode		: Integer := 0;
		PackSize 	: Integer :=64;
		PackWidth		: Integer := 8; -- bit of pack size
		PackGen			: std_logic :='1';
		PackGenNum		: Unsigned(15 Downto 0)
	);
	Port(
		Clk				: In  Std_Logic:='0';
		Reset			: In  Std_Logic;

		InpData			: In  Signed(DataWidth-1 downto 0); 
		InpEn			: In  Std_Logic;
		InpReady		: Out Unsigned(ViCh-1 downto 0);
		InpSel			: In  Unsigned(ViChAddr-1 downto 0); 

		OutpData		: Out Signed(DataWidth-1 downto 0); 
		OutpEn			: Buffer Std_Logic;
		OutpReady		: In  Unsigned(ViCh-1 downto 0);
		OutpSel			: Out Unsigned(ViChAddr-1 downto 0);
		
		SentCnt			: Out Unsigned(15 Downto 0);
		ReceCnt			: Out Unsigned(15 Downto 0);
		
		AveReceTime		: Out Unsigned(19 Downto 0);
		StopSim			: In Std_Logic
	);
End;

Architecture behavioral of PEv is

Signal OutpDataArr	: SignedArrDW(ViCh-1 downto 0);
Signal OutpEnArr	: Unsigned(Vich-1 Downto 0);
Signal OutpReadyArr	: Unsigned(Vich-1 Downto 0);

Signal	InpDataArr	: SignedArrDW(ViCh-1 downto 0); 
Signal	InpEnArr	: Unsigned(Vich-1 Downto 0);
Signal	InpReadyArr	: Unsigned(Vich-1 Downto 0);

signal Stop			: Boolean;

signal ReadFin		: boolean;
signal WriteFin		: boolean;

Signal ReceCntArr		: UnsignedArr16(ViCh-1 Downto 0);	
Signal AveReceTimeArr	: UnsignedArr20(ViCh-1 Downto 0);
Signal SumTimeDataArr	: IntVector(ViCh-1 Downto 0);
Signal NumberArr		: IntVector(ViCh-1 Downto 0);
signal WriteFinArr		: BoolArr(ViCh-1 Downto 0);
 
Begin

Stop <= (StopSim='1') Or (ReadFin And WriteFin);
	

c1: Entity Work.ReaderV 
	Generic Map(
		InpFilePoisson	,
		InpFileUniform	,

		DataWidth		,
		ViChAddr		,	
		ViCh			,	
		--
		CurNode			,
		--Y				,
		PackWidth		,	
		PackGen			,	
		PackGenNum		,	
		PackSize
	)
	
	Port Map(
		Clk				=> Clk			,	
		Reset			=> Reset		,	
										
		OutpData		=> OutpDataArr	,
		OutpEn			=> OutpEnArr	,	
		OutpReady		=> OutpReadyArr	,	
		
		SentCnt			=> SentCnt		,	
		ReadFin			=> ReadFin		,	
		Stop			=> Stop			
	);
	
c2: Entity Work.Mux 
		Generic Map(
			DataWidth	,
			ViChAddr	,
			ViCh		 -- 2**ViChAddr
		)
		Port Map(
			Clk		   						,
			Reset	   						,
			OutpSel	   						,
			
			OutpDataArr 					,
			OutpEnArr	  					,
			OutpReadyArr					,
	
			OutpData						,
			OutpEn  						,
			OutpReady	  					
	);

mx2: For j in 0 to ViCh-1 Generate	

c3: Entity Work.Writer
		Generic Map(
			--Str_Add(16,2,Str_Int_Add2(15,OutpFilePack,j),"--"),
			Str_Int_Add2(15,OutpFilePack,j),
			Str_Int_Add2(15,OutpFileTime,j)	, 
			DataWidth		,
			ViChAddr		,	
			ViCh			,	
			--
			CurNode			,	
			--Y				,
			PackWidth		,	
			PackGen			,	
			PackGenNum		,	
			PackSize
		)
		Port Map(
			Clk				=> Clk				,
			Reset			=> Reset			,

			InpData			=> InpDataArr(j)	,
			InpEn			=> InpEnArr(j)		,
			InpReady		=> InpReadyArr(j)	,

			ReceCnt			=> ReceCntArr(j)	,	
			AveReceTime		=> AveReceTimeArr(j),	
			SumTimeData		=> SumTimeDataArr(j),		
			Number			=> NumberArr(j),			
			
			WriteFin		=> WriteFinArr(j)		,
			Stop			=> Stop			
	);
	
End Generate;

Process(ReceCntArr,AveReceTimeArr,WriteFinArr,SumTimeDataArr,NumberArr)
Variable ReceCntVar : Integer;
Variable SumReceTimeVar : Integer;
Variable NumberVar : Integer;
Variable WriteFinVar : Boolean;
Variable ViChNotZero : Integer;
Begin
	ReceCntVar := 0;
	SumReceTimeVar := 0;
	WriteFinVar := True;
	ViChNotZero := ViCh;
	NumberVar := 0;
	For i In 0 To ViCh-1 Loop
			ReceCntVar := ReceCntVar+To_Integer(ReceCntArr(i));
--			AveReceTimeVar := AveReceTimeVar + To_Integer(AveReceTimeArr(i));
			SumReceTimeVar := SumReceTimeVar + SumTimeDataArr(i);
			NumberVar := NumberVar + NumberArr(i);
			WriteFinVar := WriteFinVar And WriteFinArr(i);
	End Loop;	
	ReceCnt <= To_Unsigned(ReceCntVar,16);
	If (NumberVar/=0) Then
		AveReceTime <= To_Unsigned(SumReceTimeVar/NumberVar,20); 
	Else 
		AveReceTime <= (Others=>'0');
	End If;
	WriteFin <= WriteFinVar;
End Process;
	
c4: Entity Work.DeMux 
		Generic Map(
			DataWidth	,
			ViChAddr	,
			ViCh		 -- 2**ViChAddr
		)
		Port Map(
			Clk			,
			Reset		,
			InpSel		,

			InpData		, 
			InpEn		,
			InpReady	, 

			InpDataArr	, 
			InpEnArr	,
			InpReadyArr		
	);
End;