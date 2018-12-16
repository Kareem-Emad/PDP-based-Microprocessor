LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Tristate IS
	Generic ( n:integer:=16 );
	PORT (input: IN std_logic_vector(n-1 downto 0);
	output: OUT std_logic_vector(n-1 downto 0);
	c: IN std_logic
        );
END Tristate;


architecture Tristate_arc of Tristate is

begin
output<= input  when c='1' 
else
 (others=>'Z');

end Tristate_arc;

