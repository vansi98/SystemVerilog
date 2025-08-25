module pipe(
        input wire [7:0] d_in,
        output reg [7:0] d_out,
        input wire clk
        );

reg [7:0] d_1, d_2, d_3;

always @ (posedge clk)
 begin  // doesn't matter what order reg's are in
        d_1<= #5 d_in;
        d_2 <= #5 d_1;
        d_3 <= #5 d_2;
        d_out<= #5 d_3;
 end
endmodule


