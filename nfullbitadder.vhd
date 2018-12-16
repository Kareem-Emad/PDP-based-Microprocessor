LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY nbitadder IS
	Generic ( n:integer:=16 );
	PORT (fa,fb: IN std_logic_vector(n-1 downto 0);
	f: OUT std_logic_vector(n-1 downto 0);
	cin: in std_logic ;
        e:in std_logic;
	cout: out std_logic);
END nbitadder;

architecture n_bitadder of nbitadder is
COMPONENT my_adder IS
  PORT( a,b,cin,e : IN std_logic; s,cout : OUT std_logic);
   END COMPONENT;
signal temp :std_logic_vector(n downto 0);
begin 
	temp(0)<= cin;
  loop1: FOR i IN 0 TO n-1 GENERATE
          fx: my_adder PORT MAP  (fa(i),fb(i),temp(i),e,f(i),temp(i+1));
    END GENERATE;
    cout <= temp(n);
END n_bitadder;
 

