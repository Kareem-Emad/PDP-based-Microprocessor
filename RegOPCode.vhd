library ieee;
use ieee.std_logic_1164.all;

entity RegOPCode is
    port(
        IR : in std_logic_vector(15 downto 0);
        RegNum: in std_logic;
        opcode: out std_logic_vector(5 downto 0)
    );
end entity;

architecture RegOPCodeWorkFlow of RegOPCode is
begin
    process (IR, RegNum)
    begin
        if(RegNum = '0') then
            if(IR(5 downto 3) = "000") then
                opcode <= "000001";
            end if;

            if(IR(5 downto 3) = "001") then
                opcode <= "000010";
            end if;

            if(IR(5 downto 3) = "010") then
                opcode <= "000100";
            end if;

            if(IR(5 downto 3) = "011") then
                opcode <= "001000";
            end if;

            if(IR(5 downto 3) = "100") then
                opcode <= "010000";
            end if;

            if(IR(5 downto 3) = "101") then
                opcode <= "100000";
            end if;
        end if;

        if(RegNum = '1') then
            if(IR(11 downto 9) = "000") then
                opcode <= "000001";
            end if;

            if(IR(11 downto 9) = "001") then
                opcode <= "000010";
            end if;

            if(IR(11 downto 9) = "010") then
                opcode <= "000100";
            end if;

            if(IR(11 downto 9) = "011") then
                opcode <= "001000";
            end if;

            if(IR(11 downto 9) = "100") then
                opcode <= "010000";
            end if;

            if(IR(11 downto 9) = "101") then
                opcode <= "100000";
            end if;
        end if;
    end process;
end architecture RegOPCodeWorkFlow;