LIBRARY IEEE;
USE IEEE.std_Logic_1164.all;

ENTITY pla IS
PORT(	IR : in std_logic_vector (15 downto 0) ;	
   	output: out std_logic_vector (6 downto 0);
	MPC : in std_logic_vector(6 downto 0));
END ENTITY pla;

ARCHITECTURE Data_flow OF pla IS
BEGIN 
-- if the MPC is at the start(after fetching the instruction ) and it's a two op instruction
-- then go to address of decoding first operand
output <= "0000000" when MPC = "0000010"  and IR(3 downto 0) < "1000"
-- if we are not at the start ,but the op code is two operand and we decoded the first op
-- then go to address of decoding second operand
else "0000000"  when  (MPC < "111011") and IR(3 downto 0) < "1000"
-- if we are two operand and done with two operands
-- then go to operation code
else  "0000000"  when  (MPC > "111011") and IR(3 downto 0) < "1000"
-- if the MPC is at the start(after fetching the instruction ) and it's a 1 op instruction
-- then go to address of decoding first operand
else "0000000" when MPC = "0000010"  and IR(4 downto 0) < "11101"
-- if we are not at the start ,but the op code is 1 operand and we decoded the first op
-- then go to address of operation
else "0000000"  when  IR(4 downto 0) < "11101"
-- if the op code is branching ,then go to the branching operation
else "0000000" when  IR(5 downto 0) < "1111110"
-- if the op code is no operation , then go to no op operation
else "0000000" when  IR(6 downto 0) < "111111100";

END ARCHITECTURE;