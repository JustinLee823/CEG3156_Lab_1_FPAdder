library ieee;
use ieee.std_logic_1164.all;

entity nineBitShiftRegister is
port(
	i_reset, i_clock, i_shiftRight, i_load, i_clear : in std_logic;
	i_value : in std_logic_vector(8 downto 0);
	o_value : out std_logic_vector(8 downto 0));
end nineBitShiftRegister;

architecture rtl of nineBitShiftRegister is

	component enardFF_2
	port(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
	end component;
	
	component mux2to1_1bit
	PORT(
        i_0  : IN  STD_LOGIC;
        i_1  : IN  STD_LOGIC;
        i_sel : IN  STD_LOGIC;
        o_y  : OUT STD_LOGIC);
	end component;
	
	signal int_d, int_q : std_logic_vector(8 downto 0);

begin
	
	mux2to1_8 : mux2to1_1bit
	port map(
		i_0 => '1', --Hold
		i_1 => '0', --right shift in 0
		i_sel => i_shiftRight,
		o_y => int_d(8));
	dFF8 : enardFF_2
	port map(
		i_resetBar => i_reset and i_clear,
		i_d => int_d(8),
		i_enable => i_load or i_shiftRight,
		i_clock => i_clock,
		o_q => int_q(8),
		o_qBar => open);
	
	mux2to1_7 : mux2to1_1bit
	port map(
		i_0 => i_value(7), --Hold
		i_1 => int_q(8), --right shift 1
		i_sel => i_shiftRight,
		o_y => int_d(7));
	dFF7 : enardFF_2
	port map(
		i_resetBar => i_reset and i_clear,
		i_d => int_d(7),
		i_enable => i_load or i_shiftRight,
		i_clock => i_clock,
		o_q => int_q(7),
		o_qBar => open);
	
	mux2to1_6 : mux2to1_1bit
	port map(
		i_0 => i_value(6), --Hold 0
		i_1 => int_q(7), --right shift 1
		i_sel => i_shiftRight,
		o_y => int_d(6));
	dFF6 : enardFF_2
	port map(
		i_resetBar => i_reset and i_clear,
		i_d => int_d(6),
		i_enable => i_load or i_shiftRight,
		i_clock => i_clock,
		o_q => int_q(6),
		o_qBar => open);
	
	mux2to1_5 : mux2to1_1bit
	port map(
		i_0 => i_value(5), --Hold 0
		i_1 => int_q(6), --right shift 1
		i_sel => i_shiftRight,
		o_y => int_d(5));
	dFF5 : enardFF_2
	port map(
		i_resetBar => i_reset and i_clear,
		i_d => int_d(5),
		i_enable => i_load or i_shiftRight,
		i_clock => i_clock,
		o_q => int_q(5),
		o_qBar => open);
	
	mux2to1_4 : mux2to1_1bit
	port map(
		i_0 => i_value(4), --Hold 0
		i_1 => int_q(5), --right shift 1
		i_sel => i_shiftRight,
		o_y => int_d(4));
	dFF4 : enardFF_2
	port map(
		i_resetBar => i_reset and i_clear,
		i_d => int_d(4),
		i_enable => i_load or i_shiftRight,
		i_clock => i_clock,
		o_q => int_q(4),
		o_qBar => open);
	
	mux2to1_3 : mux2to1_1bit
	port map(
		i_0 => i_value(3), --Hold 0
		i_1 => int_q(4), --right shift 1
		i_sel => i_shiftRight,
		o_y => int_d(3));
	dFF3 : enardFF_2
	port map(
		i_resetBar => i_reset and i_clear,
		i_d => int_d(3),
		i_enable => i_load or i_shiftRight,
		i_clock => i_clock,
		o_q => int_q(3),
		o_qBar => open);
	
	mux2to1_2 : mux2to1_1bit
	port map(
		i_0 => i_value(2), --Hold 0
		i_1 => int_q(3), --right shift 1
		i_sel => i_shiftRight,
		o_y => int_d(2));
	dFF2 : enardFF_2
	port map(
		i_resetBar => i_reset and i_clear,
		i_d => int_d(2),
		i_enable => i_load or i_shiftRight,
		i_clock => i_clock,
		o_q => int_q(2),
		o_qBar => open);
	
	mux2to1_1 : mux2to1_1bit
	port map(
		i_0 => i_value(1), --Hold 0
		i_1 => int_q(2), --right shift 1
		i_sel => i_shiftRight,
		o_y => int_d(1));
	dFF1 : enardFF_2
	port map(
		i_resetBar => i_reset and i_clear,
		i_d => int_d(1),
		i_enable => i_load or i_shiftRight,
		i_clock => i_clock,
		o_q => int_q(1),
		o_qBar => open);
	
	mux2to1_0 : mux2to1_1bit
	port map(
		i_0 => i_value(0), --Hold 0
		i_1 => int_q(1), --right shift 1
		i_sel => i_shiftRight,
		o_y => int_d(0));
	dFF0 : enardFF_2
	port map(
		i_resetBar => i_reset and i_clear,
		i_d => int_d(0),
		i_enable => i_load or i_shiftRight,
		i_clock => i_clock,
		o_q => int_q(0),
		o_qBar => open);
		
	o_value <= int_q;
end rtl;