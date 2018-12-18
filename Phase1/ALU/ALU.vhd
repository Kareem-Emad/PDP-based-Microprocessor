library ieee;
use ieee.std_logic_1164.all;

entity ALU is
    generic(n : integer := 16);
	port(
		a, b : in std_logic_vector (n-1 downto 0);
		f : out std_logic_vector (n-1 downto 0);
		s : in std_logic_vector(3 downto 0);
		cin : in std_logic;
		cout : out std_logic
	);
end ALU;

architecture ALU_arch of ALU is
component ALUPartA is
    generic(n : integer := 16);
    port(
        s0, s1, cin : in std_logic;
        a, b : in std_logic_vector(n-1 downto 0);
        f : out std_logic_vector(n-1 downto 0);
        cout : out std_logic
    );
end component;

component ALUPartB is
    generic(n : integer := 16);
	port( 
        s0, s1 : in std_logic;
        a, b : in std_logic_vector(n-1 downto 0);
        f : out std_logic_vector(n-1 downto 0)
     );
end component;

component ALUPartCD is
    generic(n : integer := 16);
	port( 
        s : in std_logic_vector(2 downto 0);
        a, b : in std_logic_vector(n-1 downto 0);
        f : out std_logic_vector(n-1 downto 0);
        cin : in std_logic;
        cout : out std_logic
    );
end component;

signal f_a : std_logic_vector(n-1 downto 0);
signal f_b : std_logic_vector(n-1 downto 0);
signal f_cd : std_logic_vector(n-1 downto 0);
signal cout_a, cout_cd : std_logic;
begin
	alu_a: ALUPartA generic map(n) port map(s(0), s(1), cin, a, b, f_a, cout_a);
	alu_b: ALUPartB generic map(n) port map(s(0), s(1), a, b, f_b);
	alu_cd: ALUPartCD generic map(n) port map(s(2 downto 0), a, b, f_cd, cin, cout_cd);
	f <= f_a when s(2) = '0' and s(3) = '0' else
		f_b when s(3) = '0' and s(2) = '1' else f_cd;
	cout <= cout_a when s(2) = '0' and s(3) = '0' else
			'0' when s(3) = '0' and s(2) = '1' else cout_cd;
end ALU_arch;