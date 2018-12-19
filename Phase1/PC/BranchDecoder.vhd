library ieee;
use ieee.std_logic_1164.all;

entity BranchDecoder is 
    generic( n : integer := 16 );
    port(
        c_flag : in std_logic;
        n_flag : in std_logic;
        z_flag : in std_logic;
        p_flag : in std_logic;
        o_flag : in std_logic;
        ir_q : in std_logic_vector(n-1 downto 0);
        offset  : out std_logic_vector(n-1 downto 0)
    );
end BranchDecoder;

architecture BranchDecoder_arch of BranchDecoder is
signal ir_is_branch : std_logic;
signal ir_offset_condition : std_logic;
signal branch_type : std_logic_vector(2 downto 0);
begin
    ir_is_branch <= '1' when ir_q(n-1 downto n-4) = "1111" and
                            (ir_q(n - 5) and ir_q(n - 6) and ir_q(n - 6)) = '0'
                        else '0';
    branch_type <= ir_q(n-5 downto n-7);
    
    ir_offset_condition <= 
        '1' when branch_type = "000"
        else z_flag when branch_type = "001"
        else not(z_flag) when branch_type = "010"
        else not(c_flag) when branch_type = "011"
        else not(c_flag) or z_flag when branch_type = "100"
        else c_flag when branch_type = "101"
        else c_flag or z_flag  when branch_type = "110";

    offset <= (others => '0') when ir_is_branch = '0' or ir_offset_condition = '0' else
              "0000000" & ir_q(n - 8 downto 0);
end BranchDecoder_arch;