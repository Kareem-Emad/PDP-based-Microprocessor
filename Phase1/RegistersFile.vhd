library ieee;
use ieee.std_logic_1164.all;

entity RegisterFile is
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
end RegisterFile;

architecture RegisterFile_arch of RegisterFile is 
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

type vector_array is array(0 to n_registers-1) of std_logic_vector(n-1 downto 0);
signal q_arr : vector_array;
begin
	tristate_loop_bus_A : for i in 0 to n_registers-1 generate
		triq: tristate generic map(n)
			port map(q_arr(i), busA, reg_out_select_A(i));
	end generate;

	tristate_loop_bus_B : for i in 0 to n_registers-1 generate
		triq: tristate generic map(n)
			port map(q_arr(i), busB, reg_out_select_B(i));
	end generate;

	reg_loop : for i in 0 to n_registers-1 generate
		reg: MyRegister generic map(n)
			port map(busB, q_arr(i), reg_in_select_B(i), clk, rst);
    end generate;
end RegisterFile_arch;