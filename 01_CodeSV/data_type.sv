module dataType1;
    integer a;
    int b;
    shortint c;
    longint dataType1;
    logic [7:0] A1;
    logic signed [7:0] loglicSig;
    byte byte_variable;
    reg [7:0] r1;
    initial 
        begin
            a = 'h xxzz_ffff;
            b = -1;
            c = 'h fxfx;
        end
    initial
        begin #10;
        $display("a = %h b = %h c = %h", a, b, c);
        #10
        $finish(2);
        end
endmodule