LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux2to1_1bit IS
    PORT(
        i_0  : IN  STD_LOGIC;
        i_1  : IN  STD_LOGIC;
        i_sel : IN  STD_LOGIC;
        o_y  : OUT STD_LOGIC
    );
END mux2to1_1bit;

ARCHITECTURE rtl OF mux2to1_1bit IS
BEGIN

    o_y <= (i_0 AND (NOT i_sel)) OR (i_1 AND i_sel);

END rtl;