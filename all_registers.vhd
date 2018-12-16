library ieee;
use ieee.std_logic_1164.all;
entity all_registers is
Generic ( n:integer:=16 );
 port( bussB:inout std_logic_vector ( n-1 downto 0) ;
       bussA:inout std_logic_vector ( n-1 downto 0) ;
       Rsrcout:std_logic;
       Rdstin:in std_logic;
       RA:in std_logic;
       incpc:in std_logic;
       pcin:in std_logic;
       endsig:in std_logic;
       pcout:in std_logic;
       BR:in std_logic_vector(3 downto 0);
       Yin,Yout:in std_logic;
       IRout,IRin:in std_logic;
       Xin,Xout:in std_logic;
       Zin,Zout:in std_logic;
       Aluin:out std_logic_vector(n-1 downto 0);
       Aluout:in std_logic_vector(n-1 downto 0);
       clk:in std_logic
	);

end all_registers ;







architecture archreg of all_registers is 
component MyRegister  is 

	Generic ( n:integer:=16 );
	PORT (input: IN std_logic_vector(n-1 downto 0);
	output: OUT std_logic_vector(n-1 downto 0);
	en,clk,rst: IN std_logic
        );
END  component;




component register_file is
Generic ( n:integer:=16 );
 port( bussB:inout std_logic_vector ( n-1 downto 0) ;
       bussA:out std_logic_vector ( n-1 downto 0) ;
	rst:in std_logic_vector(5 downto 0);
	s1:in std_logic_vector(2 downto 0);
	s2:in std_logic_vector(2 downto 0);
	e1,e2,clk,eA:in std_logic
	
	);

end component;


component incrementor is
Generic ( n:integer:=16 );
port( offset: in std_logic_vector(n-1 downto 0);
      pcin:in std_logic_vector(n-1 downto 0);
	sel: in std_logic_vector(3 downto 0);
        enable:in std_logic;
        pcout:out std_logic_vector(n-1 downto 0)
        
	);
end component;



component tristate is
Generic ( n:integer:=16 );
PORT (input: IN std_logic_vector(n-1 downto 0);
	output: OUT std_logic_vector(n-1 downto 0);
	c: IN std_logic
        );

end  component ;
signal pout:std_logic_vector(16 downto 0);
signal pin:std_logic_vector(16 downto 0);
signal Y:std_logic_vector(16 downto 0);
signal IR:std_logic_vector(16 downto 0);
signal X:std_logic_vector(16 downto 0);
signal Z:std_logic_vector(16 downto 0);
begin



regfile:register_file  generic map(16) PORT MAP (bussB,bussA,"000000",IR(12 downto 10),IR(2 downto 0),Rsrcout,Rdstin,clk,RA);--check IR again
---------------------------------------------------------------
tri1pc: tristate generic map(16) PORT MAP (pin,bussA,pcout);
pc: MyRegister generic map(16)PORT MAP (bussA,pout,pcin,clk,endsig);
tri2pc: tristate generic map(16) PORT MAP (pout,bussB,pcout);
pcinc:incrementor generic map(16)PORT MAP (IR(8 downto 0),pout,BR,incpc,pin);--get offset from IR later

----------------------------------------------------------------
Yreg: MyRegister generic map(16)PORT MAP (bussA,Y,Yin,clk,'0');
triY: tristate generic map(16) PORT MAP (Y,bussB,Yout);
-------------------------------------------------------------
IRreg: MyRegister generic map(16)PORT MAP (bussA,IR,IRin,clk,'0');
triIR: tristate generic map(16) PORT MAP (IR,bussB,IRout);
-------------------------------------------------------------------
Xreg: MyRegister generic map(16)PORT MAP (bussB,X,Xin,clk,'0');
triX: tristate generic map(16) PORT MAP (X,Aluin,Xout);
-------------------------------------------------------------------
Zreg: MyRegister generic map(16)PORT MAP (Aluout,Z,Zin,clk,'0');
triZ: tristate generic map(16) PORT MAP (Z,bussB,Zout);

end archreg;
