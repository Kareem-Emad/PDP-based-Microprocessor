library ieee;
use ieee.std_logic_1164.all;

entity MyNBitAdder is
    generic(n : integer := 16);
	port(
		x : in std_logic_vector(n-1 downto 0);
		y : in std_logic_vector(n-1 downto 0);
		cin : in std_logic;
		z : out std_logic_vector(n-1 downto 0);
		cout : out std_logic
	);
end MyNBitAdder;

architecture MyNBitAdder_arch of MyNBitAdder is
component MyAdder is
	port(
        a, b, cin : in std_logic;
        s, cout : out std_logic
    );
end component;

signal temp : std_logic_vector(n-1 DOWNTO 0);
begin
	f0: MyAdder port map(x(0), y(0), cin, z(0), temp(0));
	loop1: for i in 1 to n-1 generate
		fx: MyAdder port map (x(i), y(i), temp(i - 1), z(i), temp(i));
	end generate;
	cout <= temp(n-1);
end MyNBitAdder_arch;
