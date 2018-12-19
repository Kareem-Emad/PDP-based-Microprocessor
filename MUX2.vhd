library ieee;
use ieee.std_logic_1164.all;

entity MUX2 is
	port(
		in1: in std_logic_vector(6 downto 0);
		in2: in std_logic_vector(6 downto 0);
		F  : out std_logic_vector(6 downto 0);
		sel: in std_logic_vector(3 downto 0)  
	);
end entity MUX2;

architecture MUX2DataFlow of MUX2 is
begin
	F <= in1 when sel = "1001"
	else in2 when sel = "1010"
	else "ZZZZZZZ";
end architecture MUX2DataFlow;