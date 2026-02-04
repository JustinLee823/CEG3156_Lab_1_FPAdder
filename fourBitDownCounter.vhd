library ieee;
use ieee.std_logic_1164.all;

entity fourBitDownCounter is
	port(i_value : in std_logic_vector(3 downto 0);
		i_resetBar, i_enable, i_load, i_clock : in std_logic;
		o_zero : out std_logic;
		o_Z : out std_logic_vector(3 downto 0));
end entity;

architecture rtl of fourBitDownCounter is
	component enardFF_2
		port(i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
	end component;
	
	component mux2to1_1bit
		port(i_0  : IN  STD_LOGIC;
        i_1  : IN  STD_LOGIC;
        i_sel : IN  STD_LOGIC;
        o_y  : OUT STD_LOGIC);
	 end component;
	 
	signal y, yBar, int_next, int_Z, int_muxOut : std_logic_vector(3 downto 0);
	signal int_zero : std_logic;
begin
	
	mux3 : mux2to1_1bit
	port map(i_0 => int_next(3),
		i_1 => i_value(3),
		i_sel => i_load,
		o_y => int_muxOut(3));
	dFF3 : enardFF_2
	port map(i_resetBar => i_resetBar,
		i_d => int_muxOut(3),
		i_enable => i_enable,
		i_clock => i_clock,
		o_q => y(3),
		o_qBar => yBar(3));

	mux2 : mux2to1_1bit
	port map(i_0 => int_next(2),
		i_1 => i_value(2),
		i_sel => i_load,
		o_y => int_muxOut(2));
	dFF2 : enardFF_2
	port map(i_resetBar => i_resetBar,
		i_d => int_muxOut(2),
		i_enable => i_enable,
		i_clock => i_clock,
		o_q => y(2),
		o_qBar => yBar(2));
		
	mux1 : mux2to1_1bit
	port map(i_0 => int_next(1),
		i_1 => i_value(1),
		i_sel => i_load,
		o_y => int_muxOut(1));
	dFF1 : enardFF_2
	port map(i_resetBar => i_resetBar,
		i_d => int_muxOut(1),
		i_enable => i_enable,
		i_clock => i_clock,
		o_q => y(1),
		o_qBar => yBar(1));
		
	mux0 : mux2to1_1bit
	port map(i_0 => int_next(0),
		i_1 => i_value(0),
		i_sel => i_load,
		o_y => int_muxOut(0));
	dFF0 : enardFF_2
	port map(i_resetBar => i_resetBar,
		i_d => int_muxOut(0),
		i_enable => i_enable,
		i_clock => i_clock,
		o_q => y(0),
		o_qBar => yBar(0));
		
	o_zero <= (y(0) and not y(1) and not y(2) and not y(3));	
	int_next(3) <= ((yBar(3) and yBar(2) and yBar(1) and yBar(0)) or (y(3) and y(2)) or (y(3) and y(0)) or (y(3) and y(1)));
	int_next(2) <= ((yBar(2) and yBar(1) and yBar(0)) or (y(2) and y(0)) or (y(2) and y(1)));
	int_next(1) <= ((yBar(1) and yBar(0)) or (y(1) and y(0)));
	int_next(0) <= ((yBar(1) and yBar(0)) or (y(1) and yBar(0)));
	
	o_Z <= int_next;
	
end rtl;