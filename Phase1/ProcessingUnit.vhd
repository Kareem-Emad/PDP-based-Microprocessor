library ieee;
use ieee.std_logic_1164.all;

entity ProcessingUnit is
    generic(
        n:integer:=16;
        n_registers : integer := 6;
        memory_address_size : integer := 16
    );
    port(
        clk : in std_logic;
        --- General purpose registers control signals & possibly SP
        reg_in_select_B : in std_logic_vector(n_registers - 1 downto 0) := (others => '0');
        reg_out_select_A : in std_logic_vector(n_registers - 1 downto 0) := (others => '0');
        reg_out_select_B : in std_logic_vector(n_registers - 1 downto 0) := (others => '0');  
        reg_rst : in std_logic;
        --- PC related
        pc_inc : in std_logic := '0';
        pc_out : in std_logic := '0';
        pc_rst : in std_logic := '0';
        --- ALU related
        alu_out_select : in std_logic := '0';
        alu_update_flag : in std_logic := '0';
        alu_select : in std_logic_vector(3 downto 0) := (others => '0');
        alu_use_carry : in std_logic := '0';
        y_in_select, y_out_select, y_rst : in std_logic := '0';
        ir_in_select, ir_out_select, ir_rst : in std_logic := '0';
        x_in_select, x_rst : in std_logic := '0';
        z_out_select, z_in_select, z_rst : in std_logic := '0';
        --- Memory related
        mem_rst : in std_logic := '0';
        mem_read, mem_write : in std_logic := '0';
        mar_in_select_A : in std_logic := '0';
        mar_in_select_B : in std_logic := '0';
        mdr_out_select : in std_logic := '0';
        mdr_in_select : in std_logic := '0'
    );
end ProcessingUnit;

architecture ProcessingUnit_arch of ProcessingUnit is
component RegisterFile is
    generic(
        n : integer := 16;
        n_registers : integer := 6
    );
    port(
        clk, rst : in std_logic := '0';
        busA : out std_logic_vector (n-1 downto 0) := (others => '0');
        busB : inout std_logic_vector (n-1 downto 0) := (others => '0');
        reg_in_select_B : in std_logic_vector(n_registers - 1 downto 0) := (others => '0');
        reg_out_select_A : in std_logic_vector(n_registers - 1 downto 0) := (others => '0');
        reg_out_select_B : in std_logic_vector(n_registers - 1 downto 0) := (others => '0')
    );
end component;

component PCReg is
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
end component;

component MemoryUnit is
    generic (
        n : integer := 16;
        n_address : integer := 8
    );
    port(
        clk, rst : in std_logic := '0';
        mem_read : in std_logic := '0';
        mem_write : in std_logic := '0';
        bus_a : inout std_logic_vector(n - 1 downto 0) := (others => '0');
        bus_b : inout std_logic_vector(n - 1 downto 0) := (others => '0');
        mar_in_select_a : in std_logic := '0';
        mar_in_select_b : in std_logic := '0';
        mdr_out_select_a : in std_logic := '0';
        mdr_in_select_b : in std_logic := '0'
    );
end component;

component ALUWithRegs is
    generic(n : integer := 16);
	port(
        clk, rst : in std_logic := '0';
		b : in std_logic_vector (n-1 downto 0) := (others => '0');
        s : in std_logic_vector(3 downto 0) := (others => '0');
        use_carry : in std_logic;
        x_in_bus : in std_logic_vector(n-1 downto 0) := (others => '0');
        x_in_select : in std_logic := '0';
        z_out_bus : out std_logic_vector(n-1 downto 0) := (others => '0');
        z_in_select, z_out_select : in std_logic := '0';
        alu_out_select : in std_logic := '0';
        alu_out_bus : out std_logic_vector(n-1 downto 0) := (others => '0');
        c_flag : out std_logic := '0';
        n_flag : out std_logic;
        z_flag : out std_logic;
        p_flag : out std_logic;
        o_flag : out std_logic;
        update_flag : in std_logic
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



component MyRegister is
    generic(n : integer := 16);
    port(
        d : in std_logic_vector(n-1 downto 0) := (others => '0');
        q : out std_logic_vector(n-1 downto 0) := (others => '0');
        ld, clk, rst : in std_logic := '0'
    );
end component;

signal busA : std_logic_vector(n-1 downto 0) := (others => '0');
signal busB : std_logic_vector(n-1 downto 0) := (others => '0');

signal c_flag : std_logic := '0';
signal n_flag : std_logic := '0';
signal z_flag : std_logic := '0';
signal p_flag : std_logic := '0';
signal o_flag : std_logic := '0';

signal ir_q : std_logic_vector(n-1 downto 0) := (others => '0');

signal y_q : std_logic_vector(n-1 downto 0) := (others => '0');

begin
    register_file_define : RegisterFile generic map(n, n_registers)
    port map(
        clk, reg_rst, busA, busB, reg_in_select_B, reg_out_select_A, reg_out_select_B
    );

    alu_define : ALUWithRegs generic map(n)
    port map(
        clk, reg_rst, busA, alu_select, alu_use_carry, busB, x_in_select,
        busB, z_in_select, z_out_select, alu_out_select, busB,
        c_flag, n_flag, z_flag, p_flag, o_flag, alu_update_flag
    );
    
    ram_define : MemoryUnit generic map(n, memory_address_size)
    port map(
        clk, reg_rst, mem_read, mem_write, busA, busB,
        mar_in_select_A, mar_in_select_B, mdr_out_select,
        mdr_in_select
    );

    ir_define : MyRegister generic map(n)
    port map(
        busA, ir_q, ir_in_select, clk, reg_rst
    );

    y_define : MyRegister generic map(n)
    port map(
        busA, y_q, y_in_select, clk, reg_rst
    );

    y_tristate : Tristate generic map(n)
    port map(
        y_q, busB, y_out_select
    );

    pc_define : PCReg generic map(n)
    port map(
        clk,pc_rst,'0',pc_out,busA,busB,pc_inc,ir_q,c_flag,n_flag,z_flag,p_flag,o_flag
    );



end ProcessingUnit_arch;