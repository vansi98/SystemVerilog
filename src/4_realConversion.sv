module change_type;
    real real1, real2, real3;
    integer i1;
    bit [63:0] bit1;
    initial begin
        real1 = 123.55;
        i1 = $rtoi(real1);
        real2 = $itor(i1);
        bit1 = $realtobits ( real1);
        real3 = $bitstoreal(bit1);
    end
    initial begin
        #1;
        $display("real1 = %f real2 = %f i1=%0d",real1,real2,i1);
        $display("bit1 = %b real3=%f",bit1,real3);
        #10 $finish;
    end
endmodule

