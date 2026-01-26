library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_Nbit is
	generic(WIDTH : integer := 8);
	port(
		i_0, i_1 : in std_logic_vector(WIDTH-1 downto 0);
		i_sel : in std_logic;
		o_y : out std_logic_vector(WIDTH-1 downto 0));
end entity;

architecture rtl of mux2to1_Nbit is
	COMPONENT mux2to1_1bit 
        PORT(
            i_0   : IN  STD_LOGIC;
            i_1   : IN  STD_LOGIC;
            i_sel : IN  STD_LOGIC;
            o_y   : OUT STD_LOGIC
        );
    END COMPONENT;
begin
	gen_bits : for i in 0 to WIDTH-1 generate
	n_mux : mux2to1_1bit
		port map(
			i_0 => i_0(i),
			i_1 => i_1(i),
			i_sel => i_sel,
			o_y => o_y(i));
	end generate;
end rtl; 