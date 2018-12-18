library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mPCInrementor is
	port(
		input : in  std_logic_vector(6 downto 0);
		output: out std_logic_vector(6 downto 0)
	);
end entity;

architecture mPCInrementorWorkFlow of mPCInrementor is
begin
	output <= input + 1;
end architecture mPCInrementorWorkFlow;
