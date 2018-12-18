library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROMModule is
	port(
		IR : in std_logic_vector(15 downto 0);
		clk: in std_logic
	);
end entity ROMModule;

architecture ROMModuleWorkFlow of ROMModule is 
	component PLA 
		PORT(	
			IR    : in std_logic_vector (15 downto 0) ;	
			MPC   : in std_logic_vector(6 downto 0);
   			output: out std_logic_vector (6 downto 0)
		);
	end component;

	component ROM
		port(
			address   : in std_logic_vector(6 downto 0);
			dataOut   : out std_logic_vector(19 downto 0)
		);
	end component;

	component BitOring 
		port(
			IR         : in std_logic_vector(15 downto 0);
			mPC        : in std_logic_vector(6 downto 0);
			newMPC     : out std_logic_vector(6 downto 0)
		);
	end component;

	component mPCUpdate
		port(
			PLAOut     : in std_logic_vector(6 downto 0);
			branchType : in std_logic_vector(3 downto 0);
			bitOringOut: in std_logic_vector(6 downto 0);
			mPC        : out std_logic_vector(6 downto 0)
		);
	end component;
		
	component mPCInrementor
		port(
			input : in  std_logic_vector(6 downto 0);
			output: out std_logic_vector(6 downto 0)
		);
	end component;

	signal mPC           : std_logic_vector(6 downto 0);
	signal ROMout        : std_logic_vector(19 downto 0);
	signal BitOringOut   : std_logic_vector(6 downto 0);
	signal PLAOut        : std_logic_vector(6 downto 0);
	signal IncrementedmPC: std_logic_vector(6 downto 0);
	
begin
	ROMX: ROM port map(mPC, ROMout);
	
	BitOringX: BitOring port map(IR, mPC, BitOringOut);

	PLAX: PLA port map(IR, mPC, PLAOut);
	
	mPCInrementorX: mPCInrementor port map(mPC, IncrementedmPC);
	
	mPC <= PLAOut when (ROMout(10 downto 7) = "1001") and rising_edge(clk)
	else BitOringOut when (ROMout(10 downto 7) = "1010") and rising_edge(clk) and (not (bitOringOut = mPC))
	else IncrementedmPC when rising_edge(clk);

end architecture ROMModuleWorkFlow;