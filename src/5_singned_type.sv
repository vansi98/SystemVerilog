module top;
    logic [7:0] r1;
    logic signed [7:0] sr1; 
    logic signed [3:0] sr2 = -1;
    bit [7:0] abit = 129;
    byte aByte = 129;
    initial begin 
        r1 = -2; 
        $display ($stime,,, "r1 = %d", r1);
        sr1 = -2;
        #10;
        $display ($stime,,, "sr1 = %d", sr1);
        r1 = sr1 + 1;
        #10;
        $display ($stime,,, "r1 = %d", r1);
        r1 = r1 + 1;
        #10;
        $display ($stime,,, "r1 = %d", r1);
        sr1 = sr1 -2;
        #10;
        $display ($stime,,, "sr1 = %d", sr1);


        $display ("abit = %d", abit);
        $display ("aByte = %d", aByte);

        end
endmodule
