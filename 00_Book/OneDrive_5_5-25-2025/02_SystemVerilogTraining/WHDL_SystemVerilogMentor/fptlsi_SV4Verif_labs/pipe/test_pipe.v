`timescale 1ns/10ps

/** file test_pipe_oper.v  for use with operators exercise  **/
module test_pipe;

reg clk;
reg [7:0] d_in;
wire [7:0] d_out;
integer i;

initial
 begin
        clk = 0;  // init clk
        d_in = 0;  // init d_in
        forever #20 clk = ~clk;  // 40 time step clock
 end

task single;  // send a single word through the pipe
input [7:0] data;
 begin
        d_in = data;
        @ (negedge clk) d_in = 0; // clear the pipe
 end
endtask


task burst; // send n words through the pipe
input[31:0] n;
begin
        for (i=1; i< n+1; i=i+1)
                @ (negedge clk) d_in = i;
        @ (negedge clk) d_in = 0; // clear the pipe
 end
endtask


initial
 begin  
        #10  // get clear of time=0
        @ (negedge clk) single(4); // send one word through
        repeat (4) @ (negedge clk);  // wait to clear
        burst(10); // send through 10
        repeat (4) @ (negedge clk);  // wait to clear
        burst (3); // send through a partial burst
        repeat (4) @ (negedge clk);  // wait to clear
        for (i=1; i<9; i=i+1)
                @ (negedge clk) // skip one clock
                single (i); //send a word
        #500 $stop;  // wait to clear then stop
 end
// mimic the pipe
reg [7:0] d_1_p,d_2_p,d_3_p,d_out_p,temp;
always @ (posedge clk)
begin
        d_1_p<= #5 d_in;
        d_2_p <= #5 d_1_p;
        d_3_p <= #5 d_2_p;
        d_out_p<= #3 d_3_p;
end

function correct_output;
input[7:0]  d_out, d_out_p;
reg [7:0] temp;
begin
  if (d_out === d_out_p) 
   correct_output = 1;
  else
   correct_output = 0;
end
endfunction

always @ (posedge clk)
   #6 if (correct_output(d_out,d_out_p))
    $display ("at time = %0d, d_out = %h which is correct",$time,d_out);
   else
    begin
     $display("***ERROR at time =%0d, d_out = %h should have been %h",$time,d_out,d_out_p);
    end

/*** module instantiation ***/
pipe pipe_1 ( .d_in(d_in), .d_out(d_out), .clk(clk));
endmodule

