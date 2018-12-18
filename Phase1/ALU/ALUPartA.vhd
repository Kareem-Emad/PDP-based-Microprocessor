library ieee;
use ieee.std_logic_1164.all;

entity ALUPartA is
    generic(n : integer := 16);
    port(
        s0, s1, cin : in std_logic := '0';
        a, b : in std_logic_vector(n-1 downto 0) := (others => '0');
        f : out std_logic_vector(n-1 downto 0) := (others => '0');
        cout : out std_logic := '0'
    );
end ALUPartA;

architecture ALUPartA_arch of ALUPartA is
component MyNBitAdder IS
    generic(n : integer := 16);
	port(
		x : in std_logic_vector(n-1 downto 0);
		y : in std_logic_vector(n-1 downto 0);
		cin : in std_logic;
		z : out std_logic_vector(n-1 downto 0);
		cout : out std_logic
	);
end component;

signal b_tmp : std_logic_vector(n-1 downto 0) := (others => '0');
signal f_tmp : std_logic_vector(n-1 downto 0) := (others => '0');
signal cout_tmp : std_logic := '0';
begin
    b_tmp <= (others => '0') when s1 = '0' and s0 = '0' else 
            b when s1 = '0' and s0 = '1' else
            not(b) when s1 = '1' and s0 = '0' else
            (others => '1') when s0 = '1' and s1 = '1';
    
    zf: MyNBitAdder generic map(n)
        port map(a, b_tmp, cin, f_tmp, cout_tmp);

    cout <= '0' when s0 = '1' and s1 = '1' and cin = '1' else cout_tmp;
    f <= (others => '0') when cin = '1' and s0 = '1' and s1 = '1' else f_tmp; 
end ALUPartA_arch;