library ieee;
use ieee.std_logic_1164.all;

entity ALUOP is 
    port(
        IR    : in std_logic_vector(15 downto 0);
        opcode: out std_logic_vector(4 downto 0)
    );
end entity;


architecture ALUOPWorkFlow of ALUOP is
begin
    process(IR)
    begin
        if(IR(15 downto 12) < "1001") then
            if(IR(15 downto 12) = "0001") then
                opcode <= "00010";
            end if;

            if(IR(15 downto 12) = "0010") then
                opcode <= "00011";
            end if;

            if(IR(15 downto 12) = "0011") then
                opcode <= "00101";
            end if;

            if(IR(15 downto 12) = "0100") then
                opcode <= "00100";
            end if;

            if(IR(15 downto 12) = "0101") then
                opcode <= "01000";
            end if;

            if(IR(15 downto 12) = "0110") then
                opcode <= "01010";
            end if;

            if(IR(15 downto 12) = "0111") then
                opcode <= "01100";
            end if;
        end if;
    --To add one operand operations
    end process;
end architecture ALUOPWorkFlow; 