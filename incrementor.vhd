library ieee;
use ieee.std_logic_1164.all;

entity incrementor is
Generic ( n:integer:=16 );
port( offset: in std_logic_vector(n-1 downto 0);
      pcin:in std_logic_vector(n-1 downto 0);
	sel: in std_logic_vector(3 downto 0);
        enable:in std_logic;
        pcout:out std_logic_vector(n-1 downto 0)
        
	);
end incrementor;

architecture archinc of incrementor is

component nbitadder IS
	Generic ( n:integer:=16 );
	PORT (fa,fb: IN std_logic_vector(n-1 downto 0);
	f: OUT std_logic_vector(15 downto 0);
	cin: in std_logic ;
        e:in std_logic;
	cout: out std_logic);
END component;

signal added :std_logic_vector(n-1 downto 0);
signal outofbound:std_logic;
begin
 added<=offset when sel="1111"
 else
  "0000000000000001";




pcinc:nbitadder generic map(16) port map(pcin,added,pcout,'0',enable,outofbound);
 


end archinc; 