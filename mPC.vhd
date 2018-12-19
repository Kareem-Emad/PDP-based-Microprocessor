library ieee;
use ieee.std_logic_1164.all;

entity mPCUpdate is
	port(
		PLAOut     : in std_logic_vector(6 downto 0);
		branchType : in std_logic_vector(3 downto 0);
		bitOringOut: in std_logic_vector(6 downto 0);
		mPC        : out std_logic_vector(6 downto 0)
	);
end entity mPCUpdate;

architecture mPCUpdateWorkFlow of mPCUpdate is 
	component MUX2
		port(
			in1: in std_logic_vector(6 downto 0);
			in2: in std_logic_vector(6 downto 0);
			F  : out std_logic_vector(6 downto 0);
			sel: in std_logic_vector(3 downto 0)  
		);
	end component;

	signal mPCtmp: std_logic_vector(6 downto 0);
begin
	MX: MUX2 port map(PLAOut, bitOringOut, mPCtmp, branchType);
	mPC <= mPCtmp;
end architecture mPCUpdateWorkFlow;