library ieee;
use ieee.std_logic_1164.all;

entity sevenBitComparator is
	port(i_A, i_B : in std_logic_vector(6 downto 0);
		o_GT, o_LT, o_EQ : out std_logic);
end entity;

architecture rtl of sevenBitComparator is

	signal int_GT, int_LT : std_logic_vector(6 downto 0);
	signal gnd : std_logic;
	
	COMPONENT oneBitComparator
	PORT(
		i_GTPrevious, i_LTPrevious	: IN	STD_LOGIC;
		i_Ai, i_Bi			: IN	STD_LOGIC;
		o_GT, o_LT			: OUT	STD_LOGIC);
	END COMPONENT;
begin
	gnd <= '0';
	
	comp6 : oneBitComparator
	port map(i_GTPrevious => gnd,
		i_LTPrevious => gnd,
		i_Ai => i_A(6),
		i_Bi => i_B(6),
		o_GT => int_GT(6),
		o_LT => int_LT(6));
		
	comp5 : oneBitComparator
	port map(i_GTPrevious => int_GT(6),
		i_LTPrevious => int_LT(6),
		i_Ai => i_A(5),
		i_Bi => i_B(5),
		o_GT => int_GT(5),
		o_LT => int_LT(5));
	
	comp4 : oneBitComparator
	port map(i_GTPrevious => int_GT(5),
		i_LTPrevious => int_LT(5),
		i_Ai => i_A(4),
		i_Bi => i_B(4),
		o_GT => int_GT(4),
		o_LT => int_LT(4));
	
	comp3 : oneBitComparator
	port map(i_GTPrevious => int_GT(4),
		i_LTPrevious => int_LT(4),
		i_Ai => i_A(3),
		i_Bi => i_B(3),
		o_GT => int_GT(3),
		o_LT => int_LT(3));
	
	comp2 : oneBitComparator
	port map(i_GTPrevious => int_GT(3),
		i_LTPrevious => int_LT(3),
		i_Ai => i_A(2),
		i_Bi => i_B(2),
		o_GT => int_GT(2),
		o_LT => int_LT(2));
	
	comp1 : oneBitComparator
	port map(i_GTPrevious => int_GT(2),
		i_LTPrevious => int_LT(2),
		i_Ai => i_A(1),
		i_Bi => i_B(1),
		o_GT => int_GT(1),
		o_LT => int_LT(1));
		
	comp0 : oneBitComparator
	port map(i_GTPrevious => int_GT(1),
		i_LTPrevious => int_LT(1),
		i_Ai => i_A(0),
		i_Bi => i_B(0),
		o_GT => int_GT(0),
		o_LT => int_LT(0));
		
	o_GT <= int_GT(0);
	o_LT <= int_LT(0);
	o_EQ <= int_GT(0) nor int_LT(0);
end rtl;