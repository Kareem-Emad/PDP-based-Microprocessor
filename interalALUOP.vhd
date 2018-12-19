library ieee;
use ieee.std_logic_1164.all;

entity internalALUOP is
    port(
        IR    : in std_logic_vector(15 downto 0);
        RegNum: in std_logic;
        opcode: out std_logic
    );
end entity;

architecture internalALUOPWorkFlow of internalALUOP is
begin
    process (IR, RegNum)
    begin
        if(RegNum = '0') then
            if(IR(1 downto 0) = "00") then
                opcode <= '0'; --Add
            end if;

            if(IR(1 downto 0) = "10") then
                opcode <= '1'; --Subtract
            end if;
        end if;

        if(RegNum = '1') then
            if(IR(7 downto 6) = "00") then
                opcode <= '0'; --Add
            end if;

            if(IR(7 downto 6) = "10") then
                opcode <= '1'; --Subtract
            end if;
        end if;
    end process;
end architecture internalALUOPWorkFlow;