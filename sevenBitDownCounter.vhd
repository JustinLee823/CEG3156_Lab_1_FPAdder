library ieee;
use ieee.std_logic_1164.all;

entity sevenBitDownCounter is
	port(i_value : in std_logic_vector(6 downto 0);
		i_resetBar, i_clock, i_load, i_enable : in std_logic;
		o_zero : out std_logic;
		o_Z : out std_logic_vector(6 downto 0));
end entity;

architecture rtl of sevenBitDownCounter is
	
	component threeBitDownCounter
		port(i_value : in std_logic_vector(2 downto 0);
			i_resetBar, i_enable, i_load, i_clock : in std_logic;
			o_zero : out std_logic;
			o_Z : out std_logic_vector(2 downto 0));
	end component;
	
	component fourBitDownCounter
		port(i_value : in std_logic_vector(3 downto 0);
			i_resetBar, i_enable, i_load, i_clock : in std_logic;
			o_zero : out std_logic;
			o_Z : out std_logic_vector(3 downto 0));
	end component;

	 signal threeBitZeroFlag, fourBitZeroFlag, msbEnable : std_logic;
	 signal int_Z  : std_logic_vector(6 downto 0);
begin

	msbEnable <= threeBitZeroFlag and i_enable;
	
	LSB3Bit : threeBitDownCounter
	port map(i_value => i_value(2 downto 0),
		i_resetBar => i_resetBar,
		i_enable => i_enable,
		i_load => i_load,
		i_clock => i_clock,
		o_zero => threeBitZeroFlag,
		o_Z => o_Z(2 downto 0));--int_Z(2 downto 0));
		
	
	MSB4Bit : fourBitDownCounter
	port map(i_value => i_value(6 downto 3),
		i_resetBar => i_resetBar,
		i_enable => msbEnable,
		i_load => i_load,
		i_clock => i_clock,
		o_zero => fourBitZeroFlag,
		o_Z => o_Z(6 downto 3));--int_Z(6 downto 3));
	
	o_zero <= threeBitZeroFlag; --and fourBitZeroFlag;
	

end rtl;