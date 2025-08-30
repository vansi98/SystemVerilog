module test;
  logic clk = 0;
  logic rst = 1;
  logic out;

  // clock
  always #5 clk = ~clk;

  // DUT đơn giản: lật bit out mỗi xung clock
  always_ff @(posedge clk or posedge rst) begin
    if (rst) out <= 0;
    else     out <= ~out;
  end

  initial begin
    $display("Start simulation: hello world");
    #12 rst = 0;
    #50 $finish;
  end
endmodule
