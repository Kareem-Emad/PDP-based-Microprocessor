library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is 
	port(
		address   : in std_logic_vector(6 downto 0);
		dataOut   : out std_logic_vector(15 downto 0);
		readEnable: in std_logic 
	);
end entity ROM;

architecture ROMWorkFlow of ROM is
	--Define the ROM type and instantiate the ROM
	type ROM is array(0 to 127) of std_logic_vector(15 downto 0);
	signal mem: ROM;

begin
	dataOut <= mem(to_integer(unsigned(address))) when (readEnable = '1')
	else (others => 'Z');
end architecture ROMWorkFlow;
