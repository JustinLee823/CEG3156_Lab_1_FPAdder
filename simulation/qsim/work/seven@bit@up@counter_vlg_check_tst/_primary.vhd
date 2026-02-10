library verilog;
use verilog.vl_types.all;
entity sevenBitUpCounter_vlg_check_tst is
    port(
        o_Z             : in     vl_logic_vector(6 downto 0);
        o_zero          : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end sevenBitUpCounter_vlg_check_tst;
