library ieee;
use ieee.std_logic_1164.all;

entity FPAdder_Data is
port(SignA, SignB, GReset, GClock : in std_logic;
	loadExpoA, loadExpoB, loadMantA, loadMantB, loadSum, shiftMantissaA, shiftMantissaB, shiftMantSum, clearMantA, clearMantB, clearMantSum: in std_logic; --Control Signals
	load6, load7Up, on1, on2, CountD, CountU, Flag_0, Flag_1 : in std_logic;
	ExponentA, ExponentB : in std_logic_vector(6 downto 0);
	MantissaA, MantissaB : in std_logic_vector(8 downto 0);
	Zero, notless9, Sign2, Sign1, countFz : out std_logic;
	REz : out std_logic_vector(6 downto 0);
	RFz : out std_logic_vector(7 downto 0));
end entity;

architecture rtl of FPAdder_Data is

--------SIGNALS---------
signal i_flag, cin, overflowFlag: std_logic;
signal i_expoDiff : std_logic_vector(6 downto 0); --difference between exponents A and B
signal i_expoA, i_expoB, i_expoB2Comp : std_logic_vector(6 downto 0);
signal o_expoA, o_expoB : std_logic_vector(6 downto 0);

signal i_mantA, i_mantB : std_logic_vector(8 downto 0);
signal int_compMantA, int_compMantB : std_logic_vector(9 downto 0);
signal int_compExpoA, int_compExpoB, int_countUpVal, int_countDownVal : std_logic_vector(7 downto 0);
signal int_resultExpo, int_downCountOut, int_expoBottomMux : std_logic_vector(6 downto 0);
signal int_resultMant : std_logic_vector(8 downto 0);
signal int_mantSum : std_logic_vector(8 downto 0);


--------COMPONENTS--------
component nineBitShiftRegister
port(i_reset, i_clock, i_shiftRight, i_load, i_clear : in std_logic;
	i_value : in std_logic_vector(8 downto 0);
	o_value : out std_logic_vector(8 downto 0));
end component;

component tenBitAdder
port(i_a, i_b : in std_logic_vector(9 downto 0);
		i_cin : in std_logic;
		o_cout : out std_logic;
		o_overflow : out std_logic;
		o_Value : out std_logic_vector(8 downto 0));
end component;

component eightBitAdder
port(i_a, i_b : in std_logic_vector(7 downto 0);
		i_cin : in std_logic;
		o_cout : out std_logic;
		o_Value : out std_logic_vector(7 downto 0));
end component;

component sevenBitRegister
port(i_resetBar, i_load : IN STD_LOGIC;
      i_clock            : IN STD_LOGIC;
      i_Value            : IN STD_LOGIC_VECTOR(6 downto 0);
      o_Value            : OUT STD_LOGIC_VECTOR(6 downto 0));
end component;

component onebitcomparator
port(i_GTPrevious, i_LTPrevious	: IN	STD_LOGIC;
		i_Ai, i_Bi			: IN	STD_LOGIC;
		o_GT, o_LT			: OUT	STD_LOGIC);
end component;

component twosComp8Bit
port(i_enable : in std_logic;
		i_Value : in std_logic_vector(6 downto 0);
		o_Value : out std_logic_vector(7 downto 0));
end component;

component twosComp10bit_A
port(i_signA, i_signB : in std_logic;
		i_Value : in std_logic_vector(8 downto 0);
		o_Value : out std_logic_vector(9 downto 0));
end component;

component twosComp10bit_B
port(i_signA, i_signB : in std_logic;
		i_Value : in std_logic_vector(8 downto 0);
		o_Value : out std_logic_vector(9 downto 0));
end component;

component sevenBitUpCounter
port(i_value : in std_logic_vector(6 downto 0);
		i_resetBar, i_enable, i_load, i_clock : in std_logic;
		o_zero : out std_logic;
		o_Z : out std_logic_vector(6 downto 0));
end component;

component sevenBitDownCounter
port(i_value : in std_logic_vector(6 downto 0);
		i_resetBar, i_clock, i_load, i_enable : in std_logic;
		o_zero : out std_logic;
		o_Z : out std_logic_vector(6 downto 0));
end component;

component sevenBitComparator
port(i_A, i_B : in std_logic_vector(6 downto 0);
		o_GT, o_LT, o_EQ : out std_logic);
end component;

component mux2to1_7bit
PORT(i_0   : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
        i_1   : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
        i_sel : IN  STD_LOGIC;
        o_y   : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
end component;
begin	

	------EXPONENT------
	expoAReg : sevenBitRegister
	port map(i_resetBar => GReset, 
		i_load => loadExpoA,
      i_clock => GClock,
      i_Value => ExponentA,
      o_Value => i_expoA);
	
	expoBReg : sevenBitRegister
	port map(i_resetBar => GReset,
		i_load => loadExpoB,
		i_clock => GClock,
		i_Value => ExponentB,
		o_Value => i_expoB);
		
	expoAComp : twosComp8Bit
	port map(i_Value => i_expoA,
		i_enable => on1,
		o_Value => int_compExpoA);
	
	expoBComp : twosComp8Bit
	port map(i_Value => i_expoB,
		i_enable => on2,
		o_Value => int_compExpoB);
	
	expoAdder : eightBitAdder
	port map(i_a => int_compExpoA,
		i_b => int_compExpoB,
		i_cin => '0',
		o_cout => open,
		o_Value => int_countDownVal);
	
	sevenDownCount : sevenBitDownCounter
	port map(i_value => int_countDownVal(6 downto 0),
		i_resetBar => GReset,
		i_clock => GClock,
		i_enable => CountD,
		i_load => load6,
		o_zero => Zero,
		o_Z => int_downCountOut);
	
	notless9CMP : sevenBitComparator
	port map(i_A => int_downCountOut,
		i_B => "0001001",
		o_LT => notless9,
		o_GT => open,
		o_EQ => open);
	
	expoMux : mux2to1_7bit
	port map(i_0 => i_expoA,
		i_1 => i_expoB,
		i_sel => Flag_0,
		o_y => int_expoBottomMux);
	
	sevenUpCount : sevenBitUpCounter
	port map(i_value => int_expoBottomMux,
		i_resetBar => GReset,
		i_clock => GClock,
		i_enable => countU,
		i_load => load7Up,
		o_zero => open,
		o_Z => REz);
	
	------MANTISSA------
	mantAReg : nineBitShiftRegister
	port map(i_reset => GReset, 
		i_clear => clearMantA,
		i_clock => GClock,
		i_shiftRight => shiftMantissaA,
		i_load => loadMantA,
		i_value => MantissaA,
		o_value => i_mantA);
	
	mantBReg : nineBitShiftRegister
	port map(i_reset => GReset,
		i_clear => clearMantB,
		i_clock => GClock,
		i_shiftRight => shiftMantissaB,
		i_load => loadMantB,
		i_value => MantissaB,
		o_value => i_mantB);
		
	mantAComp : twosComp10bit_A
	port map(i_signA => SignA,
		i_signB => SignB,
		i_Value => i_mantA,
		o_Value => int_compMantA);
	
	mantBComp : twosComp10bit_B
	port map(i_signA => SignA,
		i_signB => SignB,
		i_Value => i_mantB,
		o_Value => int_compMantB);
		
	mantAdder : tenBitAdder
	port map(i_a => int_compMantA,
		i_b => int_compMantB,
		i_cin => '0', --change later
		o_cout => countFz,
		o_overflow => overflowFlag,
		o_Value => int_mantSum);
	
	mantSum : nineBitShiftRegister
	port map(i_reset => GReset,
		i_clear => clearMantSum,
		i_clock => GClock,
		i_shiftRight => shiftMantSum,
		i_load => loadSum,
		i_value => int_mantSum(8 downto 0),
		o_value => int_resultMant);
		
	Sign2 <= int_mantSum(8);
	Sign1 <= int_countDownVal(7);
	RFz <= int_resultMant(7 downto 0);
	
end rtl;