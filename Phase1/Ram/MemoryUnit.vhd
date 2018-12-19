library ieee;
use ieee.std_logic_1164.all;

entity MemoryUnit is
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
end MemoryUnit;

architecture MemoryUnit_arch of MemoryUnit is
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
    
component Ram is
    generic (
        n_reg_bits : integer := 16;
        n_address : integer := 6
    );
    port (
        clk: in std_logic;
        rw: in std_logic;
        address: in std_logic_vector(n_address - 1 downto 0);
        data_in: in std_logic_vector(n_reg_bits - 1 downto 0);
        data_out: out std_logic_vector(n_reg_bits - 1 downto 0)
    );
end component;
    
signal mdr_q : std_logic_vector(n-1 downto 0);
signal mdr_d : std_logic_vector(n-1 downto 0);
signal mar_q : std_logic_vector(n-1 downto 0);
signal mar_d : std_logic_vector(n-1 downto 0);
signal ram_out : std_logic_vector(n-1 downto 0);
signal mdr_in_select : std_logic;
signal mar_in_select : std_logic;
signal ram_clk : std_logic;

begin
    mdr_register: MyRegister generic map(n)
    port map (
        mdr_d, mdr_q, mdr_in_select, clk, rst
    );
    mdr_d <= ram_out when mem_read = '1' else
             bus_b when mem_read = '0';
    mdr_in_select <= mdr_in_select_b or mem_read;

    tri_mdr: tristate generic map(n) 
    port map (
        mdr_q, bus_a, mdr_out_select_a
    );
    
    mar_register: MyRegister generic map(n)
    port map (
        mar_d, mar_q, mar_in_select, clk, rst
    );
    mar_d <= bus_a when mar_in_select_a = '1' else
             bus_b when mar_in_select_b = '1';
    mar_in_select <= mar_in_select_a or mar_in_select_b;

    ram_def: ram generic map(n, n_address)
    port map (
        ram_clk, mem_write, mar_q(n_address-1 downto 0), mdr_q, ram_out
    );

    ram_clk <= not(clk);
end MemoryUnit_arch;
