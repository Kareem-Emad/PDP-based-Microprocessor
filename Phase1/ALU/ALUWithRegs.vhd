library ieee;
use ieee.std_logic_1164.all;

entity ALUWithRegs is
    generic(n : integer := 16);
	port(
        -- basic signals
        clk, rst : in std_logic := '0';

        -- second operand, output and selection lines
		b : in std_logic_vector (n-1 downto 0) := (others => '0');
        s : in std_logic_vector(3 downto 0) := (others => '0');
        
        -- x register related
        x_in_bus : in std_logic_vector(n-1 downto 0) := (others => '0');
        x_in_select : in std_logic := '0';
        
        -- z register related
        z_out_bus : out std_logic_vector(n-1 downto 0) := (others => '0');
        -- z_in_select to accept from ALU and z_out_select to output to z_out_bus
        z_in_select, z_out_select : in std_logic := '0';
        
        -- alu related
        alu_out_select : in std_logic := '0';
        alu_out_bus : out std_logic_vector(n-1 downto 0) := (others => '0');
        
        -- flag register output
        c_flag : out std_logic := '0';
        n_flag : out std_logic;
        z_flag : out std_logic;
        p_flag : out std_logic;
        o_flag : out std_logic;
        update_flag : in std_logic
    );
end ALUWithRegs;

architecture ALUWithRegs_arch of ALUWithRegs is
component ALU is
    generic(n : integer := 16);
    port(
        a, b : in std_logic_vector (n-1 downto 0);
        f : out std_logic_vector (n-1 downto 0);
        s : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        cout : out std_logic
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

component Tristate is
    generic(n : integer := 16);
    port(
        d : in std_logic_vector(n-1 downto 0);
        q : out std_logic_vector(n-1 downto 0);
        ld : in std_logic
    );
end component;

component FlagReg is
    generic(n : integer := 16);
    port(
        clk, rst : in std_logic := '0';
        a_msb, b_msb, cout : in std_logic := '0';
        f : in std_logic_vector(n-1 downto 0) := (others => '0');
        s : in std_logic_vector(3 downto 0) := (others => '0');
        c_flag : out std_logic := '0';
        n_flag : out std_logic := '0';
        z_flag : out std_logic := '0';
        p_flag : out std_logic := '0';
        o_flag : out std_logic := '0';
        update_flag : in std_logic := '0'
    );
end component;

signal alu_a : std_logic_vector(n-1 downto 0) := (others => '0');
signal alu_a_msb : std_logic := '0';
signal alu_b_msb : std_logic := '0';
signal alu_f : std_logic_vector(n-1 downto 0) := (others => '0');
signal alu_cin : std_logic := '0';
signal alu_cout : std_logic := '0';
signal x_d : std_logic_vector(n-1 downto 0) := (others => '0');
signal x_q : std_logic_vector(n-1 downto 0) := (others => '0');
signal z_d : std_logic_vector(n-1 downto 0) := (others => '0');
signal z_q : std_logic_vector(n-1 downto 0) := (others => '0');

begin
    alu_define: ALU generic map(n)
    port map(
        alu_a, b, alu_f, s, alu_cin, alu_cout
    );
    alu_a <= x_q;

    flag_reg_define: FlagReg generic map(n)
    port map(
        clk, rst,
        alu_a_msb, alu_b_msb, alu_cout, alu_f, s,
        c_flag, n_flag, z_flag, p_flag, o_flag, update_flag
    );
    alu_a_msb <= alu_a(n-1);
    alu_b_msb <= b(n-1);
 
    reg_x_define: MyRegister generic map(n)
    port map(
        x_d, x_q, x_in_select, clk, rst
    );
    x_d <= x_in_bus;

    reg_z_define: MyRegister generic map(n)
    port map(
        z_d, z_q, z_in_select, clk, rst
    );
    z_d <= alu_f;

    alu_tristate: Tristate generic map(n)
    port map(
        alu_f, alu_out_bus, alu_out_select
    );

    z_tristate: Tristate generic map(n)
    port map(
        z_q, z_out_bus, z_out_select
    );



end ALUWithRegs_arch;
