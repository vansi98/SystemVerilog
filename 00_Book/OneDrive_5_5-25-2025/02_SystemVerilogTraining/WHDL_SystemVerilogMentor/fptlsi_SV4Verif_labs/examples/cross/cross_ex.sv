module cross_ex;
bit clk;

typedef enum {s1,s2,s3} sts;
typedef enum {a,b,c} mds;
sts state;
mds mode;

covergroup cga() @(posedge clk);
  cp_state: coverpoint state;
  cp_mode:  coverpoint mode;
  cs_modstat: cross cp_state, cp_mode;
  
endgroup

covergroup cgb() @(posedge clk);
  cp_state: coverpoint state{
           bins s1 = {s1};
           bins s2 = {s2};
           bins s3 = {s3};
  }
  cp_mode: coverpoint mode{
           bins a = {a};
           bins b = {b};
           bins c = {c};
  }
  cs_modstat: cross cp_state, cp_mode{
    bins band = binsof(cp_state.s3) && binsof(cp_mode.c);
//    bins bor  = binsof(cp_state.s2) || binsof(cp_mode.c);
    bins bint = binsof(cp_state) intersect {[s1:s2]};
    ignore_bins bout = binsof(cp_state.s2) && binsof(cp_mode.b);
  
  }
  
endgroup

initial
  repeat (4) begin
    @(posedge clk);
    state = s1;
    @(posedge clk);
    state = s2;
    @(posedge clk);
    state = s3; 
    #200 $stop;  
  end

initial
  begin
    mode = a;
    repeat (2)@(negedge clk);
    mode = b;
    repeat (2)@(negedge clk);
    mode = c;   
  end



initial
  begin
    cga cg1 = new();
    cgb cg2 = new();
    clk = 0;
    forever #20 clk = !clk;
  end  


endmodule
