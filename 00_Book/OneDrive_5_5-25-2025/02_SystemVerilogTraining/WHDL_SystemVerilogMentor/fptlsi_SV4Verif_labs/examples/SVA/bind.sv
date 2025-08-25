module my_design (input clk,b, output c);
bit[2:0] d;
initial
  d=0;
always @ (posedge clk)
  d++;
endmodule

module bind_ex;
  wire b,c;
  reg clk;
  initial begin
    clk = 0;
    #20 clk = !clk;
  end
 my_design m1(clk,b,c);
 my_design m2(clk,b,c);
  bind  my_design my_svas MS (.*);
endmodule

module my_svas (input clk, b, c,
                input [2:0] d);
  property p1;
    @ (posedge clk)
      d==2 |-> ##1 d==3 ##1 d==4;
  endproperty
  a1: assert property(p1) $display ("%m p1 passed");
          else $display("%m p1 failed");
endmodule
