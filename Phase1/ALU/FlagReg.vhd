library ieee;
use ieee.std_logic_1164.all;

entity FlagReg is
    generic(n : integer := 16);
    port(
        clk, rst : in std_logic := '0';
        a_msb, b_msb, cout : in std_logic := '0';
        f : in std_logic_vector (n-1 downto 0) := (others => '0');
        s : in std_logic_vector(3 downto 0) := (others => '0');
        c_flag : out std_logic := '0';
        n_flag : out std_logic := '0';
        z_flag : out std_logic := '0';
        p_flag : out std_logic := '0';
        o_flag : out std_logic := '0';
        update_flag : in std_logic := '0'
    );
end FlagReg;

architecture FlagReg_arch of FlagReg is
component MyRegister is
    generic(n : integer := 5);
    port(
        d : in std_logic_vector(n-1 downto 0) := (others => '0');
        q : out std_logic_vector(n-1 downto 0) := (others => '0');
        ld, clk, rst : in std_logic := '0'
    );
end component;

signal reg_d : std_logic_vector(n-1 downto 0) := (others => '0');
signal reg_q : std_logic_vector(n-1 downto 0) := (others => '0');
signal is_add_sub : std_logic := '0';
signal is_add : std_logic := '0';
signal is_sub : std_logic := '0';
constant zeros : std_logic_vector(n-1 downto 0) := (others => '0');
begin
    reg_define: MyRegister generic map(n)
        port map(reg_d, reg_q, update_flag, clk, rst);
    
    is_add_sub <= '1' when s(2) = '0' and s(3) = '0' else '0';
    is_add <= '1' when s(1) = '0' and is_add_sub = '1' else '0';
    is_sub <= '1' when s(1) = '1' and is_add_sub = '1' else '0' ;
    
    -- carry flag
    reg_d(0) <= cout;
    -- negative flag
    reg_d(1) <= f(n-1);
    -- zero flag
    reg_d(2) <= '1' when f = zeros else '0';
    -- parity flag 
    reg_d(3) <= not(f(0));
    -- overflow flag
    reg_d(4) <= '1' 
        when(
            is_add = '1'  and (
                (a_msb = '0' and b_msb = '0' and f(n-1) = '1')
                or
                (a_msb = '1' and b_msb = '1' and f(n-1) = '0')
                )
            ) or (
            is_sub = '1' and (
                (a_msb = '0' and b_msb ='1' and f(n-1)='1') 
                or
                (a_msb = '1'and b_msb ='0' and f(n-1)='0')
                )
            ) else '0';
                    
    c_flag <= reg_q(0);
    n_flag <= reg_q(1);
    z_flag <= reg_q(2);
    p_flag <= reg_q(3);
    o_flag <= reg_q(4);
end FlagReg_arch;
     