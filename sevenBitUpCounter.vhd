library ieee;
use ieee.std_logic_1164.all;

entity sevenBitUpCounter is
	port(i_value : in std_logic_vector(6 downto 0);
		i_resetBar, i_enable, i_load, i_clock : in std_logic;
		o_zero : out std_logic;
		o_Z : out std_logic_vector(6 downto 0));
end entity;

architecture rtl of sevenBitUpCounter is 
	
	component fourBitCounter
		PORT(i_value : in std_logic_vector(3 downto 0);
        i_resetBar, i_enable, i_load : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
		  o_zero : out std_logic;
        o_Z : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
	end component;
	
	component threeBitCounter
		PORT(
        i_value : in std_logic_vector(2 downto 0);
		  i_resetBar, i_enable, i_load : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
		  o_zero : out std_logic;
        o_Z : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
	end component;
	
	signal int_threeZero : std_logic;
begin
	LSBthree : threeBitCounter
		port map(i_value => i_value(2 downto 0),
			i_resetBar => i_resetBar,
			i_enable => i_enable,
			i_load => i_load,
			i_clock => i_clock,
			o_zero => int_threeZero,
			o_Z => o_Z(2 downto 0));
			
	MSBfour : fourBitCounter
		port map(i_value => i_value(6 downto 3),
			i_resetBar => i_resetBar,
			i_enable => int_threeZero or i_load,
			i_load => i_load,
			i_clock => i_clock,
			o_zero => o_zero,
			o_Z => o_Z(6 downto 3));
end rtl;