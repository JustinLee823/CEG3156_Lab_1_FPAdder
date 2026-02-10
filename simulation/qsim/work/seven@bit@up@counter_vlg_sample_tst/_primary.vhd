library verilog;
use verilog.vl_types.all;
entity sevenBitUpCounter_vlg_sample_tst is
    port(
        i_clock         : in     vl_logic;
        i_enable        : in     vl_logic;
        i_load          : in     vl_logic;
        i_resetBar      : in     vl_logic;
        i_value         : in     vl_logic_vector(6 downto 0);
        sampler_tx      : out    vl_logic
    );
end sevenBitUpCounter_vlg_sample_tst;
