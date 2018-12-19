library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity PCReg is
    generic(n : integer := 16);
	port(
        clk, rst : in std_logic := '0';
        pc_in_bus_select : in std_logic := '0';
        pc_out_bus_select : in std_logic := '0';
        pc_in_bus : in std_logic_vector(n-1 downto 0) := (others => '0');
        pc_out_bus : out std_logic_vector(n-1 downto 0) := (others => '0');
        pc_inc : in std_logic := '0';
        ir_q : in std_logic_vector(n-1 downto 0) := (others => '0');
        c_flag : in std_logic := '0';
        n_flag : in std_logic := '0';
        z_flag : in std_logic := '0';
        p_flag : in std_logic := '0';
        o_flag : in std_logic := '0'
    );
end PCReg;

architecture PCReg_arch of PCReg is
component MyRegister is
    generic(n : integer := 16);
    port(
        d : in std_logic_vector(n-1 downto 0) := (others => '0');
        q : out std_logic_vector(n-1 downto 0) := (others => '0');
        ld, clk, rst : in std_logic := '0'
    );
end component;

component Tristate is
    generic(n : integer := 16);
    port(
        d : in std_logic_vector(n-1 downto 0);
        q : out std_logic_vector(n-1 downto 0);
        ld : in std_logic
    );
end component;

component BranchDecoder is 
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
end component;

component MyNBitAdder IS
    generic(n : integer := 16);
	port(
		x : in std_logic_vector(n-1 downto 0);
		y : in std_logic_vector(n-1 downto 0);
		cin : in std_logic;
		z : out std_logic_vector(n-1 downto 0);
		cout : out std_logic
	);
end component;

signal pc_d : std_logic_vector(n-1 downto 0) := (others => '0');
signal pc_incremented : std_logic_vector(n-1 downto 0) := (others => '0');
signal stupid_carry : std_logic;
signal pc_q : std_logic_vector(n-1 downto 0) := (others => '0');
signal pc_in_select : std_logic := '0';  
signal offset : std_logic_vector(n-1 downto 0) := (others => '0');  

begin
    pc_define: MyRegister generic map(n)
    port map(
        pc_d, pc_q, pc_in_select, clk, rst
    );
    pc_in_select <= pc_in_bus_select or pc_inc;
    pc_d <= pc_in_bus when pc_in_bus_select = '1' else
            pc_incremented when pc_inc = '1' else
            (others => 'Z');
    
    calc_pc_inc: MyNBitAdder generic map(n)
        port map(pc_q, offset, '1', pc_incremented, stupid_carry);

    pc_tristate: Tristate generic map(n)
    port map(
        pc_q, pc_out_bus, pc_out_bus_select
    );

    branch_decoder_define: BranchDecoder generic map(n)
    port map(
        c_flag, n_flag, z_flag, p_flag, o_flag, ir_q, offset
    );
end PCReg_arch;
