library ieee;
use ieee.std_logic_1164.all;

entity FPAdder_Control is
port(GClock, GReset, FLAG : in std_logic;
	o_loadSignA, o_loadSignB : out std_logic;
	o_loadExpoA, o_loadExpoB : out std_logic_vector(6 downto 0);
	o_loadMantissaA, o_loadMantissaB : out std_logic_vector(7 downto 0));
end entity;

architecture rtl of FPAdder_Control is

begin

end rtl;