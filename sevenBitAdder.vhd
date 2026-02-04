library ieee;
use ieee.std_logic_1164.all;

entity sevenBitAdder is
	port(i_a, i_b : in std_logic_vector(6 downto 0);
		i_cin : in std_logic;
		o_cout : out std_logic;
		o_Value : out std_logic_vector(6 downto 0));
end sevenBitAdder;

architecture rtl of sevenBitAdder is

	signal carry : std_logic_vector(7 downto 0);
	
begin
	carry(0) <= i_cin;
	
	o_Value(0) <= i_a(0) xor i_b(0) xor carry(0);
	o_Value(1) <= i_a(1) xor i_b(1) xor carry(1);
	o_Value(2) <= i_a(2) xor i_b(2) xor carry(2);
	o_Value(3) <= i_a(3) xor i_b(3) xor carry(3);
	o_Value(4) <= i_a(4) xor i_b(4) xor carry(4);
	o_Value(5) <= i_a(5) xor i_b(5) xor carry(5);
	o_Value(6) <= i_a(6) xor i_b(6) xor carry(6);
	
	carry(1) <= (i_a(0) and i_b(0)) or (i_a(0) and carry(0)) or (i_b(0) and  carry(0));
	carry(2) <= (i_a(1) and i_b(1)) or (i_a(1) and carry(1)) or (i_b(1) and  carry(1));
	carry(3) <= (i_a(2) and i_b(2)) or (i_a(2) and carry(2)) or (i_b(2) and  carry(2));
	carry(4) <= (i_a(3) and i_b(3)) or (i_a(3) and carry(3)) or (i_b(3) and  carry(3));
	carry(5) <= (i_a(4) and i_b(4)) or (i_a(4) and carry(4)) or (i_b(4) and  carry(4));
	carry(6) <= (i_a(5) and i_b(5)) or (i_a(5) and carry(5)) or (i_b(5) and  carry(5));
	carry(7) <= (i_a(6) and i_b(6)) or (i_a(6) and carry(6)) or (i_b(6) and  carry(6));
	
	o_cout <= carry(7);
end rtl;