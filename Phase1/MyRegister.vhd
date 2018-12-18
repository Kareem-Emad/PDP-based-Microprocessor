library ieee;
use ieee.std_logic_1164.all;

entity MyRegister is
    generic(n : integer := 16);
    port(
        d : in std_logic_vector(n-1 downto 0) := (others => '0');
        q : out std_logic_vector(n-1 downto 0) := (others => '0');
        ld, clk, rst : in std_logic := '0'
    );
end MyRegister;

architecture arch of MyRegister is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            q <= (others => '0');
        elsif rising_edge(clk) then
            if ld = '1' then
                q <= d;
            end if;
        end if;
    end process;
end arch;