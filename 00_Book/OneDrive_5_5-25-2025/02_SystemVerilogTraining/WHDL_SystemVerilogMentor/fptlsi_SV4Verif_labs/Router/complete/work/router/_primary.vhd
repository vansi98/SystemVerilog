library verilog;
use verilog.vl_types.all;
entity router is
    port(
        valid           : in     vl_logic_vector(7 downto 0);
        stream          : in     vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        busy            : out    vl_logic_vector(7 downto 0);
        valido          : out    vl_logic_vector(7 downto 0);
        streamo         : out    vl_logic_vector(7 downto 0)
    );
end router;
