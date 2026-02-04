library ieee;
use ieee.std_logic_1164.all;

entity FPAdder_Control is
port(GClock, GReset : in std_logic;
	Sign1, Sign2, Zero, notless9, CoutFZ : in std_logic; --signals from Data Path
	Load1, Load2, Load3, Load4, Load5, Load6, Load7, On2, Flag_O, On1, Flag_1, Clear3, Shift3, CountD, Clear4, Shift4, Shift5, CountU, Done : out std_logic ); --signals to Data Path
end entity;

architecture rtl of FPAdder_Control is
	
	signal qS0, qS1, qS2, qS3, qS4, qS5, qS6, qS7, qS8, qS9 : std_logic;
	signal dS0, dS1, dS2, dS3, dS4, dS5, dS6, dS7, dS8, dS9 : std_logic;
	
	component enardFF_2
	PORT(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
	end component;
	
begin
	
	--Flip flops
	dS0 <= '1';
	dS1 <= '1';
	dS2 <= Sign1 and qS1;
	dS3 <= notless9 and qS2;
	dS4 <= ((qS2 and not notless9 and not Zero) or (qS4 and not Zero));
	dS5 <= (not Sign1 and notless9 and qS1);
	dS6 <= ((qS1 and not Sign1 and not notless9 and not Zero) or (qS6 and not Zero));
	dS7 <= (qS3 or (qS2 and not notless9 and Zero) or (qS4 and Zero) or qS5 or (qS1 and not Sign2 and not notless9 and Zero) or (qS6 and Zero));
	dS8 <= (CoutFZ and qS7);
	dS9 <= ((qS7 and not CoutFZ) or qS8 or qS9);
	
	Load1 <= qS0;
	Load2 <= qS0;
	Load3 <= qS0;
	Load4 <= qS0;
	
	On2 <= qS1;
	Flag_O <= qS1;
	
	On1 <= qS2;
	Flag_1 <= qS2;
	
	Clear3 <= qS3;
	
	Shift3 <= qS4;
	CountD <= qS4;
	
	Clear4 <= qS5;
	
	Shift4 <= qS6;
	
	Load5 <= qS7;
	Load7 <= qS7;
	
	Shift5 <= qS8;
	CountU <= qS8;
	
	Done <= qS9;
	
	dFF0 : enardFF_2
		port map(i_resetBar => GReset,
			i_d => dS0,
			i_enable => '1',
			i_clock => GClock,
			o_q => qS0);
	
	dFF1 : enardFF_2
		port map(i_resetBar => GReset,
			i_d => dS1,
			i_enable => '1',
			i_clock => GClock,
			o_q => qS1);
	
	dFF2 : enardFF_2
		port map(i_resetBar => GReset,
			i_d => dS2,
			i_enable => '1',
			i_clock => GClock,
			o_q => qS2);
	
	dFF3 : enardFF_2
		port map(i_resetBar => GReset,
			i_d => dS3,
			i_enable => '1',
			i_clock => GClock,
			o_q => qS3);
			
	dFF4 : enardFF_2
		port map(i_resetBar => GReset,
			i_d => dS4,
			i_enable => '1',
			i_clock => GClock,
			o_q => qS4);
			
	dFF5 : enardFF_2
		port map(i_resetBar => GReset,
			i_d => dS5,
			i_enable => '1',
			i_clock => GClock,
			o_q => qS5);		
	
	dFF6 : enardFF_2
		port map(i_resetBar => GReset,
			i_d => dS6,
			i_enable => '1',
			i_clock => GClock,
			o_q => qS6);
			
	dFF7 : enardFF_2
		port map(i_resetBar => GReset,
			i_d => dS7,
			i_enable => '1',
			i_clock => GClock,
			o_q => qS7);
			
	dFF8 : enardFF_2
		port map(i_resetBar => GReset,
			i_d => dS8,
			i_enable => '1',
			i_clock => GClock,
			o_q => qS8);
	
	dFF9 : enardFF_2
		port map(i_resetBar => GReset,
			i_d => dS9,
			i_enable => '1',
			i_clock => GClock,
			o_q => qS9);
			
	
end rtl;