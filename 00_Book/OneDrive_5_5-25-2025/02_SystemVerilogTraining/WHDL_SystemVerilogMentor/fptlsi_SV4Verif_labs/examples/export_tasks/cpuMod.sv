
module cpuMod(simple_bus b);
   enum {read, write} instr;
   logic [7:0] raddr, waddr;

   always @(posedge b.clk)
      if (instr == read)
         b.Read(raddr); // call the slave method via the interface
      else
         b.Write(waddr);
endmodule
