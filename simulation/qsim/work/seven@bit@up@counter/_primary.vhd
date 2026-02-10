library verilog;
use verilog.vl_types.all;
entity sevenBitUpCounter is
    port(
        i_value         : in     vl_logic_vector(6 downto 0);
        i_resetBar      : in     vl_logic;
        i_enable        : in     vl_logic;
        i_load          : in     vl_logic;
        i_clock         : in     vl_logic;
        o_zero          : out    vl_logic;
        o_Z             : out    vl_logic_vector(6 downto 0)
    );
end sevenBitUpCounter;
