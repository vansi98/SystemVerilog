module top;
    logic [7:0] r1;
    logic signed [7:0] sr1; 
    initial begin 
        r1 = -2; 
        $display ($stime,,, "r1 = %d", r1);
        end
    endmodule