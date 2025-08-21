// module test;
//     initial begin
//         $display("Hello word");
//     end
    
// endmodule
module top;
logic [7:0] r1;
logic signed [7:0] sr1;
initial begin
r1 = -2;
$display($stime,,,"r1=%d",r1);
sr1 = -2;
$display($stime,,,"sr1=%d",sr1);
r1 = r1+1;
$display($stime,,,"r1=%d",r1);
sr1 = sr1+1;
$display($stime,,,"sr1=%d",sr1);
end
endmodule