library ieee;
use ieee.std_logic_1164.all;

entity twosComp8Bit is
	port(
		i_Value : in std_logic_vector(7 downto 0);
		o_Value : out std_logic_vector(7 downto 0));
end twosComp8Bit;

architecture rtl of twosComp8Bit is
	signal invert : std_logic_vector(7 downto 0);
	signal carry : std_logic_vector(8 downto 0);
	
begin
	invert(0) <= not i_Value(0);
	invert(1) <= not i_Value(1);
	invert(2) <= not i_Value(2);
	invert(3) <= not i_Value(3);
	invert(4) <= not i_Value(4);
	invert(5) <= not i_Value(5);
	invert(6) <= not i_Value(6);
	invert(7) <= not i_Value(7);
	
	carry(0) <= '1';
	
	o_Value(0) <= invert(0) xor carry(0);
	o_Value(1) <= invert(1) xor carry(1);
	o_Value(2) <= invert(2) xor carry(2);
	o_Value(3) <= invert(3) xor carry(3);
	o_Value(4) <= invert(4) xor carry(4);
	o_Value(5) <= invert(5) xor carry(5);
	o_Value(6) <= invert(6) xor carry(6);
	o_Value(7) <= invert(7) xor carry(7);
	carry(1) <= invert(0) and carry(0);
	carry(2) <= invert(1) and carry(1);
	carry(3) <= invert(2) and carry(2);
	carry(4) <= invert(3) and carry(3);
	carry(5) <= invert(0) and carry(4);
	carry(6) <= invert(1) and carry(5);
	carry(7) <= invert(2) and carry(6);
	carry(8) <= invert(3) and carry(7);
end rtl;