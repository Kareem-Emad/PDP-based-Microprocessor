LIBRARY IEEE;
USE IEEE.std_Logic_1164.all;

entity PLA is
	PORT(	IR    : in std_logic_vector (15 downto 0) ;	
		MPC   : in std_logic_vector(6 downto 0);
   		output: out std_logic_vector (6 downto 0)
	);
end entity PLA;

architecture PLAWorkFlow of PLA is
begin 
	process(IR, MPC)
	begin
		if(IR(15 downto 12) < "1001") then --If it's a two operand instruction
			if(MPC = "0000011") then --If the MPC is at the the beginning of the ROM (Fetch first operand)
				if(IR(1 downto 0) = "00") then       --Auto increment
					output <= "0000111";
				elsif(IR(1 downto 0) = "10") then    --Auto decrement
					output <= "0001110";
				elsif(IR(1 downto 0) = "01") then    --Indexed
					output <= "0011101";
				elsif(IR(2 downto 0) = "111") then   --Direct
					output <= "0101111";
				elsif(IR(2 downto 0) = "011") then   --Indirect
					output <= "0110111";
				end if;
			else --If it's not, then it's a fetch the second operand
				if(IR(7 downto 6) = "00") then       --Auto increment
					output <= "1000111";
				elsif(IR(7 downto 6) = "10") then    --Auto decrement
					output <= "1001110";
				elsif(IR(7 downto 6) = "01") then    --Indexed
					output <= "1011101";
				elsif(IR(8 downto 6) = "111") then   --Direct
					output <= "1101111";
				elsif(IR(8 downto 6) = "011") then   --Indirect
					output <= "1110111";
				end if;
			end if;
		end if;
	end process;

end architecture PLAWorkFlow;