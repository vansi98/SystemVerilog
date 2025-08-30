module enum_method;
  typedef enum { RED, GREEN, BLUE } color_t;
  color_t c; 
  initial begin
    $display("Number of members in Colors = %0d", c.num);
    $display("First member in Colors = %0d", c.first);
    end
endmodule