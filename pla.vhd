LIBRARY IEEE;
USE IEEE.std_Logic_1164.all;

ENTITY pla IS
	PORT(	IR : in std_logic_vector (15 downto 0) ;	
   		output: out std_logic_vector (6 downto 0);
		MPC : in std_logic_vector(6 downto 0)
	);
END ENTITY pla;

ARCHITECTURE Data_flow OF pla IS
BEGIN 
	process(IR, MPC)
	begin
		if(IR(3 downto 0) < "1001") then --If it's a two operand instruction
			if(MPC = "0000011") then --If the MPC is at the the beginning of the ROM (Fetch first operand)
				if(IR(15 downto 14) = "00") then       --Auto increment
					output <= "0000100";
				elsif(IR(15 downto 14) = "10") then    --Auto decrement
					output <= "0001110";
				elsif(IR(15 downto 14) = "01") then    --Indexed
					output <= "0011101";
				elsif(IR(15 downto 13) = "111") then   --Direct
					output <= "0101111";
				elsif(IR(15 downto 13) = "110") then   --Indirect
					output <= "0110111";
				end if;
			else --If it's not, then it's a fetch the second operand
				if(IR(9 downto 8) = "00") then       --Auto increment
					output <= "1000100";
				elsif(IR(9 downto 8) = "10") then    --Auto decrement
					output <= "1001110";
				elsif(IR(9 downto 8) = "01") then    --Indexed
					output <= "1011101";
				elsif(IR(9 downto 7) = "111") then   --Direct
					output <= "1101111";
				elsif(IR(9 downto 7) = "110") then   --Indirect
					output <= "1110111";
				end if;
			end if;
		end if;
	end process;

END ARCHITECTURE;