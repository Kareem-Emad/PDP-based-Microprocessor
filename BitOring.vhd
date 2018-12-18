library ieee;
use ieee.std_logic_1164.all;

entity BitOring is 
	port(
		IR         : in std_logic_vector(15 downto 0);
		mPC        : in std_logic_vector(6 downto 0);
		newMPC     : out std_logic_vector(6 downto 0)
	);
end entity BitOring;


architecture BitOringWorkFlow of BitOring is 
	signal bitOringBit: std_logic;
begin
	bitOringBit <= IR(7) when mPC(6) = '1'
	else IR(13);

	newMPC <= mPC;
	newMPC(1) <= mPC(1) or bitOringBit;
end architecture BitOringWorkFlow;