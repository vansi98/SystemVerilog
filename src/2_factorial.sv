task automatic factorial(input int n, output int result);
    if (n <= 1) begin
        result = 1;
    end else begin
        int temp;
        factorial(n - 1, temp);
        result = n * temp;
    end
    
endtask //automaticfactorial
module test_factorial;
    initial begin
        int res;
        factorial(5, res);
        $display("Factorial of 5 is %0d", res);
        #10 $finish;
    end
endmodulet