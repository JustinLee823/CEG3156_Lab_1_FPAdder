library ieee;
use ieee.std_logic_1164.all;

entity FPAdder_Data is
port(SignA, SignB : in std_logic;
	ExponentA, ExponentB : in std_logic_vector(6 downto 0);
	MantissaA, MantissaB : in std_logic_vector(7 downto 0);
	o_test : out std_logic_vector(6 downto 0);
	o_temp : out std_logic);
end entity;

architecture rtl of FPAdder_Data is

signal i_flag, cin : std_logic;
signal i_expoDiff : std_logic_vector(6 downto 0); --difference between exponents A and B
signal i_expoA, i_expoB, i_expoB2Comp : std_logic_vector(6 downto 0);
signal i_mantA, i_mantB : std_logic_vector(7 downto 0);

component eightBitAdder
port(i_a, i_b : in std_logic_vector(7 downto 0);
		i_cin : in std_logic;
		o_cout : out std_logic;
		o_Value : out std_logic_vector(7 downto 0));
end component;

component sevenBitAdder
port(i_a, i_b : in std_logic_vector(6 downto 0);
		i_cin : in std_logic;
		o_cout : out std_logic;
		o_Value : out std_logic_vector(6 downto 0));
end component;

component twosComp8Bit
port(i_Value : in std_logic_vector(7 downto 0);
		o_Value : out std_logic_vector(7 downto 0));
end component;

component twosComp7Bit
port(i_Value : in std_logic_vector(6 downto 0);
		o_Value : out std_logic_vector(6 downto 0));
end component;

component onebitcomparator
port(i_GTPrevious, i_LTPrevious	: IN	STD_LOGIC;
		i_Ai, i_Bi			: IN	STD_LOGIC;
		o_GT, o_LT			: OUT	STD_LOGIC);
end component;
		
begin

	i_expoA <= ExponentA;
	i_expoB <= ExponentB;
	
	i_mantA <= MantissaA;
	i_mantB <= MantissaB;
	
	--FLAG <= 0;
	
	twosCompExpoB : twosComp7Bit
	port map(i_Value => i_expoB,
		o_Value => i_expoB2Comp);
	
	findExpoDiff : sevenBitAdder
	port map(i_a => i_expoA,
		i_b => i_expoB2Comp,
		i_cin => cin,
		o_cout => open,
		o_Value => i_expoDiff);
	
	
	isExpoLess0 : onebitcomparator
	port map(i_GTPrevious => '0',
		i_LTPrevious => '0',
		i_Ai => i_expoDiff(6),
		i_Bi => '0',
		o_GT => i_flag,
		o_LT => open);
	
	
	o_temp <= i_flag;
	o_test <= i_expoB2Comp;

end rtl;