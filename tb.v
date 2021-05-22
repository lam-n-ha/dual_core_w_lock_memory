`timescale 1 ps / 1 ps

module tb;
	
	parameter simdelay = 20; // guaranteed 2 clocks
	parameter clock_delay = 5;
	parameter fullclk = 11;
		
	reg clk; 
	reg rst; 
	reg start;
	wire [1:0]done;
	wire [1:0]lock;
	wire [3:0]S0;
	wire [3:0]S1;
	wire [3:0]NS0;
	wire [3:0]NS1;
	wire [31:0]r10;
	wire [31:0]r20;
	wire [31:0]r11;
	wire [31:0]r21;
	wire [31:0]result0;
	wire [31:0]result1;
	wire [6:0]opcode0;
	wire [6:0]opcode1;
	wire [7:0]PC0;
	wire [7:0]PC1;
	wire [5:0]address_a;
	wire [5:0]address_b;
	wire [31:0] data_a;
	wire [31:0] data_b;
	wire wren_a;
	wire wren_b;
	wire [31:0] q_a;
	wire [31:0] q_b;
	wire whose_turn;
	wire finished_storing;
	wire [1:0] need_lock;
	
	dual_core_w_lock_memory DUT(clk,
										rst,
										start,
										done,
										lock,
										S0,
										S1,
										NS0,
										NS1,
										r10,
										r20,
										r11,
										r21,
										result0,
										result1,
										opcode0,
										opcode1,
										PC0,
										PC1,
										address_a,
										address_b,
										data_a,
										data_b,
										wren_a,
										wren_b,
										q_a,
										q_b,
										whose_turn,
										finished_storing,
										need_lock
										);
	
	initial
	begin
		
		/* start clk and reset */
		#(simdelay) rst = 1'b0; clk = 1'b0;
		#(simdelay) rst = 1'b1; /* go into normal circuit operation */ 
		#(simdelay) start = 1'b1;
		#100; // let simulation finish
	
	end
	
		// this generates a clock
	always
	begin
		#(clock_delay) clk = !clk;
	end
	
	//initial
		//#1000 $stop; // This stops the simulation ... May need to be greater or less depending on your program
	/* this checks done every clock and when it goes high ends the simulation */
	always @(clk)
	begin
		if (done == 2'd3)
		begin
			$write("DONE:"); 
			$stop;
		end
	end
endmodule
