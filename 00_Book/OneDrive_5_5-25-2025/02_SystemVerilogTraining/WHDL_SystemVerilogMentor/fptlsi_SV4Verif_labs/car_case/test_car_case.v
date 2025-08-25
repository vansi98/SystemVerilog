/*** Test fixture for driving problem ***/
module test_car_case;
`define OFF 0
`define ON 1
`define TRUE 1

reg new_block, red_light,green_light, yellow_light;
integer points;

/*** tasks for turning traffic lights on and off ****/
task yellow_to_red;  // turns red on
begin
  #1 yellow_light = `OFF;// turns yellow off
   red_light = `ON; // red on
   $display ("  red at time = %0d",$time);
end
endtask

task red_to_green;  // turn green on
begin
  #1 red_light = `OFF; // turns red off
   green_light = `ON; //green on
   $display ("  green at time = %0d",$time);
end
endtask

task green_to_yellow; // turns yellow on;
begin
  #1 yellow_light = `ON; // yellow on
   green_light = `OFF; // green off
   $display ("  yellow at time = %0d",$time);
end
endtask

task none_on; //turns all lights off
begin
  #1 green_light = `OFF; // green off
  yellow_light = `OFF;// turns yellow off
  red_light = `OFF; // turns red off
  $display ("  none on at time = %0d",$time);
end
endtask

task g_y; //turns yellow & green lights on  ( ERROR! )
begin
  #1 green_light = `ON; // green on
  yellow_light = `ON;// turns yellow on
  red_light = `OFF; // turns red off
  $display ("  yellow & green on at time = %0d",$time);
end
endtask

task g_r; //turns red & green lights on  ( ERROR! )
begin
  #1 green_light = `ON; // green on
  yellow_light = `OFF;// turns yellow off
  red_light = `ON; // turns red on
  $display ("  red & green on at time = %0d",$time);
end
endtask
initial // set initial values and create new_block edges
 begin
        new_block = 0;
        none_on; //init all the lights
        red_light = `ON; // red on
        #19 new_block = 1;  // 1st intersection
        forever #20 new_block = !new_block; // toggle new_block
 end

/**** instantiate module car ***/
car_case car (.red_light(red_light),      .green_light(green_light), 
            .yellow_light(yellow_light), .new_block(new_block),
            .gas(gas), .brakes(brakes) );

/*** traffic monitor ****/

always @ (posedge new_block)
begin
 #5 // wait for reaction time
 casez ({red_light,yellow_light,green_light,gas,brakes})
   5'b10010: 	begin
		$display ($time,,"You just ran a red light and hit an old grandma!");
		points = points -100;
		end
   5'b01010:    begin
		 $display ($time,,"You just sped through a yellow - TSK, TSK!");
		 points = points -10;
		end
   5'b0010?:	begin
		 $display ($time,,"The light is green but the gas is not on!");
		  points = points - 2;
		end
   5'b???00:	$display ($time,,"Both the gas and brakes are off - not good!");
   5'b00110:    $display ($time,,"Good driving");
   5'b10001:    $display ($time,,"Good driving");
   5'b01001:	$display ($time,,"Good driving");
   5'b10101: $display($time,,"Good driving");
   5'b1011?: begin
		$display($time,,"The light is broken you should have stopped");
    		points = points -10;
            end
   5'b10000:    $display ($time,,"With no brakes on and no gas I hope you are not coasting \n \t \t through this red light!");
   5'b0001?:	begin
		  $display ($time,,"The light is broken, you should have stopped! ");
		  points = points - 10;
		end
   5'b0111?:	begin
		  $display ($time,,"The light is broken, you should have stopped! ");
		  points = points - 10;
		end
   5'b0110?:	$display ($time,,"Good driving");
   5'b00001:	$display ($time,,"Good driving");
 endcase

end


/*********  The test sequence ******/
initial
 begin
	points = 100;        
	@ (negedge new_block) red_to_green; //go
        @ (negedge new_block) green_to_yellow; //caution
        @ (negedge new_block) yellow_to_red; //stop
        @ (negedge new_block) red_to_green; //go
        repeat (2) @ (negedge new_block); // keep going
        @ (negedge new_block) none_on; // none on light is broken
        @ (negedge new_block) red_to_green; //go
        repeat (4) @ (negedge new_block); // keep going
        @ (negedge new_block) green_to_yellow; //caution
        @ (negedge new_block) yellow_to_red; //stop
	  @(negedge new_block) g_r; // red & green on - broken
        @ (negedge new_block) red_to_green; //go
        repeat (4) @ (negedge new_block); // keep going
        @ (negedge new_block) g_y; // yellow & green on, light is broken
	#100 $display ("\nYour score is %0d out of a possible 100", points);
	if(points < 90)
		$display ("FAILED TEST");
	else
		$display ("\n  ##-- Congrats - You passed the test! --##\n");
        $stop;  // stop the program */
 end
endmodule





