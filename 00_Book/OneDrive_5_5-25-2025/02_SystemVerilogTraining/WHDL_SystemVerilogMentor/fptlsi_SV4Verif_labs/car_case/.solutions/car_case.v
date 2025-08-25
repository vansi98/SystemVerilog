module car_case (input red_light, green_light, yellow_light,new_block,
                  output reg gas,brakes);

always @ (posedge new_block)
case ({red_light, yellow_light, green_light})
 3'b001: // not red, not yellow and green - Go!
   begin
	#3 brakes = 0;
	gas = 1;
   end
 default: //everything else stop!
   begin
	#3 brakes = 1;
	gas = 0;
   end
endcase

endmodule
	

