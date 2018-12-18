library ieee;
use ieee.std_logic_1164.all;

entity ALUPartB is
    generic(n : integer := 16);
	port( 
        s0, s1 : in std_logic := '0';
        a, b : in std_logic_vector(n-1 downto 0) := (others => '0');
        f : out std_logic_vector(n-1 downto 0) := (others => '0')
     );
end ALUPartB;

architecture ALUPartB_arch OF ALUPartB is
begin
    f <= a and b when s1 = '0' and s0 = '0' else
        a or b when s1 = '0' and s0 = '1' else
        a xor b when s1 = '1' and s0 = '0' else
        not a when s1 = '1' and s0 = '1';
end ALUPartB_arch;