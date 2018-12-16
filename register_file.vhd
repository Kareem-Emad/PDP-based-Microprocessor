library ieee;
use ieee.std_logic_1164.all;
entity register_file is
Generic ( n:integer:=16 );
 port( bussB:inout std_logic_vector ( n-1 downto 0) ;
       bussA:out std_logic_vector ( n-1 downto 0) ;
	rst:in std_logic_vector(5 downto 0);
	s1:in std_logic_vector(2 downto 0);
	s2:in std_logic_vector(2 downto 0);
	e1,e2,clk,eA:in std_logic
	
	);

end register_file ;







architecture archreg of register_file is 
 component tristate is
Generic ( n:integer:=16 );
PORT (input: IN std_logic_vector(n-1 downto 0);
	output: OUT std_logic_vector(n-1 downto 0);
	c: IN std_logic
        );

end  component ;


component decoder is

port( s: in std_logic_vector (2 downto 0);
	o:out std_logic_vector(5 downto 0);
	e:in std_logic
	);
end  component ;




component MyRegister  is 

	Generic ( n:integer:=16 );
	PORT (input: IN std_logic_vector(n-1 downto 0);
	output: OUT std_logic_vector(n-1 downto 0);
	en,clk,rst: IN std_logic
        );
END  component;



signal decout1 :std_logic_vector ( 5 downto 0);
signal decout2:std_logic_vector ( 5 downto 0);
signal decoutA:std_logic_vector ( 5 downto 0);
signal regout:std_logic_vector ( 6*n-1 downto 0);


begin
dec1:decoder port map(s1,decout1,e1);
dec2:decoder port map(s2,decout2,e2);
decA:decoder port map(s2,decoutA,eA);


loop1:FOR i IN 0 TO 5 GENERATE
          triq: tristate generic map(16) PORT MAP (regout((i+1)*n-1 downto i*n),bussB,decout1(i));
    END GENERATE;


loop2:FOR i IN 0 TO 5 GENERATE
          reg: MyRegister generic map(16)PORT MAP (bussB,regout((i+1)*n-1 downto i*n),decout2(i),clk,rst(i));
    END GENERATE;


loop3:FOR i IN 0 TO 5 GENERATE
          triq: tristate generic map(16) PORT MAP (regout((i+1)*n-1 downto i*n),bussA,decoutA(i));
    END GENERATE;

end archreg;