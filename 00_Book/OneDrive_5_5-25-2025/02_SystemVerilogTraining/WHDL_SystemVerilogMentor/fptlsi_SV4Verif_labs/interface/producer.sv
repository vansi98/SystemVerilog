module producer(link_if l);
import types::*;  // import types

initial
  begin
    @(start);
    for(int i = 0; i < $size(text,1); i++)
      begin
        l.write(text[i]);
      end    
  end
endmodule
