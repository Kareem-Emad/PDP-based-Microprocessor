library ieee;
use ieee.std_logic_1164.all;

entity MyAdder is
	port(
        a, b, cin : in std_logic;
        s, cout : out std_logic
    );
end MyAdder;

architecture MyAdder_arch of MyAdder is
begin
	s <= a xor b xor cin;
	cout <= (a and b) or (cin and (a xor b));
END MyAdder_arch;


