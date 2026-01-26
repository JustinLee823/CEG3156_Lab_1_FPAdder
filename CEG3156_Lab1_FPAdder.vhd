library ieee;
use ieee.std_logic_1164.all;

entity FPAdder_Top is
port(SignA, SignB : in std_logic; 
	ExponentA, ExponentB : in std_logic_vector(6 downto 0); 
	MantissaA, MantissaB : in std_logic_vector(7 downto 0);
	GClock, GReset : in std_logic;
	SignOut : out std_logic;
	ExponentOut : out std_logic_vector(6 downto 0);
	MantissaOut : out std_logic_vector(7 downto 0));
end entity;

architecture rtl of FPAdder_Top is

begin

end rtl;