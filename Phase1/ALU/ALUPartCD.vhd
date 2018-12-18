library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUPartCD is
    generic(n : integer := 16);
	port( 
        s : in std_logic_vector(2 downto 0) := (others => '0');
        a, b : in std_logic_vector(n-1 downto 0) := (others => '0');
        f : out std_logic_vector(n-1 downto 0) := (others => '0');
        cin : in std_logic := '0';
        cout : out std_logic := '0'
    );
end ALUPartCD;

architecture ALUPartCD_arch OF ALUPartCD is
    signal a_sig : std_logic_vector(n-1 downto 0) := (others => '0');
begin
    a_sig <= a;
    f <= '0' & a(n-1 downto 1) when s = "000" else
        a(0) & a(n-1 downto 1) when s = "001" else
        cin & a(n-1 downto 1) when s = "010" else
        a(n-1) & a(n-1 downto 1) when s = "011" else
        a(n-2 downto 0) & '0' when s = "100" else
        a(n-2 downto 0) & a(n-1) when s = "101" else
        a(n-2 downto 0) & cin when s = "110" else
        (others => '0') when s = "111";
    cout <= a(0) when s <= "011"  else
            a(n-1) when s <= "110" else '0';
end ALUPartCD_arch;