library ieee;
use ieee.std_logic_1164.all;

entity Tristate is
    generic(n : integer := 16);
    port(
        d : in std_logic_vector(n-1 downto 0);
        q : out std_logic_vector(n-1 downto 0);
        ld : in std_logic
    );
end Tristate;

architecture Tristate_arch of Tristate is
begin
    q <= d when ld = '1' else (others => 'Z');
end Tristate_arch;