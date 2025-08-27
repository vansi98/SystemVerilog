static int n ;
module var1;
    int n;
    initial begin
        n = 2;
        $display("module level n = %0d",n);
    end

    initial begin: init2
        int n ;
        n = 3;
        $display("block level n = %0d",n);
        $unit::n = 4;
        $display("static n = %0d", $unit::n);
    end
    initial begin

        $display("init2. n %0d",init2.n);
        #10 $finish;
    end
endmodule

module next;
    initial begin
    $display("Statically declared 'n' in module 'next' = %0d",$unit::n);
    $display("Statically declared 'n' in module 'next' = %0d",$unit::n);
end
endmodule