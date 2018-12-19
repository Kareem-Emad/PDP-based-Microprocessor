library ieee;
use ieee.std_logic_1164.all;

entity MyLevelRegister is
    generic(n : integer := 16);
    port(
        d : in std_logic_vector(n-1 downto 0) := (others => '0');
        q : out std_logic_vector(n-1 downto 0) := (others => '0');
        ld, clk, rst : in std_logic := '0'
    );
end MyLevelRegister;

architecture arch of MyLevelRegister is
begin
    process(clk, rst, d)
    begin
        if rst = '1' then
            q <= (others => '0');
        elsif clk = '1' then
            if ld = '1' then
                q <= d;
            end if;
        end if;
    end process;
end arch;