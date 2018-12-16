LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY MyRegister IS
	Generic ( n:integer:=16 );
	PORT (input: IN std_logic_vector(n-1 downto 0);
	output: OUT std_logic_vector(n-1 downto 0);
	en,clk,rst: IN std_logic
        );
END MyRegister;


architecture My_Register of MyRegister is
begin
  process (clk,input) is
  begin
    if rising_edge(clk) then
      if en ='1' then
        output<=input;
      end if;
    end if;
  end process;
  

end My_Register;

