LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY threeBitCounter IS
    PORT(
        i_value : in std_logic_vector(2 downto 0);
		  i_resetBar, i_enable, i_load : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
		  o_zero : out std_logic;
        o_Z : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END threeBitCounter;

ARCHITECTURE rtl OF threeBitCounter IS
	signal int_muxOut : std_logic_vector(2 downto 0);
    SIGNAL int_D : STD_LOGIC_VECTOR(2 DOWNTO 0); --flip flop inputs (D3-D0)
    SIGNAL int_Z : STD_LOGIC_VECTOR(2 DOWNTO 0); --flip flop outputs (Z3-Z0)

    COMPONENT enARdFF_2 -- Enabled Asynchronous Reset D Flip-Flop VHDL Model from lecture 5 notes, slide 15
        PORT(
            i_resetBar : IN STD_LOGIC;
            i_d        : IN STD_LOGIC;
            i_enable   : IN STD_LOGIC;
            i_clock    : IN STD_LOGIC;
            o_q, o_qBar: OUT STD_LOGIC
        );
    END COMPONENT;
	 
	 component mux2to1_1bit
		port(i_0  : IN  STD_LOGIC;
        i_1  : IN  STD_LOGIC;
        i_sel : IN  STD_LOGIC;
        o_y  : OUT STD_LOGIC);
	 end component;
BEGIN

    int_D(2) <= (not int_Z(2) and int_Z(1) and int_Z(0)) or (int_Z(2) and not int_Z(1)) or (int_Z(2) and not int_Z(0));
    int_D(1) <= (not int_Z(1) and int_Z(0)) or (int_Z(1) and not int_Z(0));
    int_D(0) <= (not int_Z(0));
    
	 mux2 : mux2to1_1bit
		port map(i_0 => int_D(2),
			i_1 => i_value(2),
			i_sel => i_load,
			o_y => int_muxOut(2));
    dff2: enARdFF_2
        PORT MAP (
            i_resetBar => i_resetBar,
            i_d        => int_muxOut(2),
            i_enable   => i_enable,
            i_clock    => i_clock,
            o_q        => int_Z(2),
            o_qBar     => open --not connected
        );
	
	 mux1 : mux2to1_1bit
		port map(i_0 => int_D(1),
			i_1 => i_value(1),
			i_sel => i_load,
			o_y => int_muxOut(1));
    dff1: enARdFF_2
        PORT MAP (
            i_resetBar => i_resetBar,
            i_d        => int_muxOut(1),
            i_enable   => i_enable,
            i_clock    => i_clock,
            o_q        => int_Z(1),
            o_qBar     => open --not connected
        );

	 mux0 : mux2to1_1bit
		port map(i_0 => int_D(0),
			i_1 => i_value(0),
			i_sel => i_load,
			o_y => int_muxOut(0));
    dff0: enARdFF_2
        PORT MAP (
            i_resetBar => i_resetBar,
            i_d        => int_muxOut(0),
            i_enable   => i_enable,
            i_clock    => i_clock,
            o_q        => int_Z(0),
            o_qBar     => open --not connected
        );
	
	o_zero <= (not int_Z(0) and not int_Z(1) and not int_Z(2));
    o_Z <= int_Z; --output

END rtl;
