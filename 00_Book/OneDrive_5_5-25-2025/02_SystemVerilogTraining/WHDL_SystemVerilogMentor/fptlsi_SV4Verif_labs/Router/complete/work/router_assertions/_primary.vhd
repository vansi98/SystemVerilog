library verilog;
use verilog.vl_types.all;
entity router_assertions is
    port(
        clk             : in     vl_logic;
        valid           : in     vl_logic_vector(7 downto 0);
        stream          : in     vl_logic_vector(7 downto 0)
    );
end router_assertions;
