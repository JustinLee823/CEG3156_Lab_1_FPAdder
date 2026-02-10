library ieee;
use ieee.std_logic_1164.all;

entity twosComp7Bit is
	port(
		i_enable : in std_logic;
		i_Value : in std_logic_vector(6 downto 0);
		o_Value : out std_logic_vector(6 downto 0));
end twosComp7Bit;

architecture rtl of twosComp7Bit is
	
	component mux2to1_7bit
	port(i_0   : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
        i_1   : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
        i_sel : IN  STD_LOGIC;
        o_y   : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	end component;

	signal invert, invert_carry, mux_out : std_logic_vector(6 downto 0);
	signal carry : std_logic_vector(7 downto 0);
	
begin


	invert(0) <= not i_Value(0);
	invert(1) <= not i_Value(1);
	invert(2) <= not i_Value(2);
	invert(3) <= not i_Value(3);
	invert(4) <= not i_Value(4);
	invert(5) <= not i_Value(5);
	invert(6) <= not i_Value(6);
	
	carry(0) <= '1';
	
	invert_carry(0) <= invert(0) xor carry(0);
	invert_carry(1) <= invert(1) xor carry(1);
	invert_carry(2) <= invert(2) xor carry(2);
	invert_carry(3) <= invert(3) xor carry(3);
	invert_carry(4) <= invert(4) xor carry(4);
	invert_carry(5) <= invert(5) xor carry(5);
	invert_carry(6) <= invert(6) xor carry(6);
	
	carry(1) <= invert(0) and carry(0);
	carry(2) <= invert(1) and carry(1);
	carry(3) <= invert(2) and carry(2);
	carry(4) <= invert(3) and carry(3);
	carry(5) <= invert(0) and carry(4);
	carry(6) <= invert(1) and carry(5);
	carry(7) <= invert(2) and carry(6);

	select_out : mux2to1_7bit
	port map(i_0 => i_Value,
		i_1 => invert_carry,
		i_sel => i_enable,
		o_y => mux_out);
	
	o_Value <= mux_out;
end rtl;