library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
	
	generic(
        	n:integer:=16;
        	n_registers : integer := 6;
        	memory_address_size : integer := 16
    	);
	port(
		--microinst: in std_logic_vector(16 downto 0);
            	IR       : in std_logic_vector(15 downto 0);
            	regNum   : in std_logic;
				clk      : in std_logic;

		--- General purpose registers control signals & possibly SP
        	reg_in_select_B  : out std_logic_vector(n_registers - 1 downto 0) := (others => '0');
        	reg_out_select_A : out std_logic_vector(n_registers - 1 downto 0) := (others => '0');
        	reg_out_select_B : out std_logic_vector(n_registers - 1 downto 0) := (others => '0');  
        	
        	--- PC related
        	pc_inc : out std_logic := '0';
        	pc_out : out std_logic := '0';
            	pc_rst : out std_logic := '0';

        	--- ALU related
        	alu_out : out std_logic := '0';
            	alu_select : out std_logic_vector(4 downto 0) := (others => '0');
            	alu_select_i : out std_logic := '0'; 
        	y_in, y_out : out std_logic := '0';
        	ir_in, ir_out : out std_logic := '0';
        	x_in : out std_logic := '0';
        	z_out, z_in : out std_logic := '0';

            	--- Memory related
            	mem_read, mem_write : out std_logic := '0';
            	mar_in_select_A : out std_logic := '0';
            	mar_in_select_B : out std_logic := '0';
            	mdr_out_select : out std_logic := '0';
            	mdr_in_select : out std_logic := '0';

            	--- Tristate 
            	grp1 : out std_logic_vector(2 downto 0);
            	grp2 : out std_logic_vector(1 downto 0);
            	grp3 : out std_logic;
            	grp4 : out std_logic;
            	grp5 : out std_logic;
            	grp6 : out std_logic_vector(7 downto 0);
            	grp7 : out std_logic_vector(1 downto 0);
            	grp8 : out std_logic_vector(2 downto 0);
            	grp9 : out std_logic_vector(1 downto 0)
	);
end entity;

architecture ControlUnitWorkFlow of ControlUnit is
	component ROMModule
		port(
			IR : in std_logic_vector(15 downto 0);
			clk: in std_logic;
			micro: out std_logic_vector(16 downto 0)
		);
	end component;

	component ROMDecoder
		port(
			microinst: in std_logic_vector(16 downto 0);
            		IR       : in std_logic_vector(15 downto 0);
            		regNum   : in std_logic;

		    	--- General purpose registers control signals & possibly SP
        		reg_in_select_B  : out std_logic_vector(n_registers - 1 downto 0) := (others => '0');
        		reg_out_select_A : out std_logic_vector(n_registers - 1 downto 0) := (others => '0');
        		reg_out_select_B : out std_logic_vector(n_registers - 1 downto 0) := (others => '0');  
        	
        		--- PC related
        		pc_inc : out std_logic := '0';
        		pc_out : out std_logic := '0';
            		pc_rst : out std_logic := '0';

        		--- ALU related
        		alu_out : out std_logic := '0';
            		alu_select : out std_logic_vector(4 downto 0) := (others => '0');
            		alu_select_i : out std_logic := '0'; 
        		y_in, y_out : out std_logic := '0';
        		ir_in, ir_out : out std_logic := '0';
        		x_in : out std_logic := '0';
        		z_out, z_in : out std_logic := '0';

            		--- Memory related
            		mem_read, mem_write : out std_logic := '0';
            		mar_in_select_A : out std_logic := '0';
            		mar_in_select_B : out std_logic := '0';
            		mdr_out_select : out std_logic := '0';
            		mdr_in_select : out std_logic := '0';

            		--- Tristate 
            		grp1 : out std_logic_vector(2 downto 0);
            		grp2 : out std_logic_vector(1 downto 0);
            		grp3 : out std_logic;
            		grp4 : out std_logic;
            		grp5 : out std_logic;
            		grp6 : out std_logic_vector(7 downto 0);
            		grp7 : out std_logic_vector(1 downto 0);
            		grp8 : out std_logic_vector(2 downto 0);
            		grp9 : out std_logic_vector(1 downto 0)
		);
	end component;
	
	signal microinst: std_logic_vector(16 downto 0);
begin
	ROMModuleX: ROMModule port map(IR, clk, microinst);

	ROMDecoderX: ROMDecoder port map(microinst, IR, regNum, reg_in_select_B, reg_out_select_A, reg_out_select_B, 
	pc_inc, pc_out, pc_rst, alu_out, alu_select, alu_select_i, y_in, y_out, ir_in, ir_out, x_in, z_out, z_in, mem_read, 
	mem_write, mar_in_select_A, mar_in_select_B, mdr_out_select, mdr_in_select, grp1, grp2, grp3, grp4, grp5, grp6, grp7, grp8, grp9);

end architecture ControlUnitWorkFlow;
