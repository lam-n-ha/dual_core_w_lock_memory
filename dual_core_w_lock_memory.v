module dual_core_w_lock_memory(
	input clk, 
	input rst, 
	input start,
	output wire [1:0] done,
	output reg [1:0] lock,
	output wire [3:0] S0, S1, NS0, NS1,
	output wire [31:0] r10, r20, r11, r21,
	output wire [31:0] result0, result1,
	output wire [6:0] opcode0, opcode1,
	output wire [7:0] PC0, PC1,
	output wire [5:0] address_a, address_b,
	output wire [31:0] data_a, data_b,
	output wire wren_a, wren_b,
	output wire [31:0] q_a, q_b,
	output reg whose_turn,
	output reg finished_storing,
	output wire [1:0]need_lock
);
	
	tiny_risc_v core0(clk, rst, start, 1'b0, lock[0], q_a, done[0], S0, NS0, r10, r20, result0, opcode0, PC0,
							address_a,
							data_a,
							wren_a,
							need_lock[0]);
	tiny_risc_v core1(clk, rst, start, 1'b1, lock[1], q_b, done[1], S1, NS1, r11, r21, result1, opcode1, PC1,
							address_b,
							data_b,
							wren_b,
							need_lock[1]);
	two_port_lock_mem global_mem(address_a, address_b, clk, data_a, data_b, wren_a, wren_b, q_a, q_b);
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			whose_turn <= 1'b0;
			//finished_storing <= 1'b1;
			lock <= 2'b00;
		end
		else if ((need_lock[1] == 1'b1) & (need_lock[0] == 1'b1))
		begin
			whose_turn <= 1'b0;
			lock <= whose_turn + 2'b1;
			//finished_storing <= 1'b0;
		end
		else if (need_lock[0] == 1'b1)
		begin
			lock <= 2'b10; // lock core 1
			whose_turn <= 1'b1; // next time both ask for lock, lock core 0
			//finished_storing <= 1'b0;
		end
		else if (need_lock[1] == 1'b1)
		begin
			lock <= 2'b01; // lock core 0
			whose_turn <= 1'b0; // next time both ask for lock, lock core 1
			//finished_storing <= 1'b0;
		end
		else
		begin
			lock <= 2'b00;
		end
		/* else if((opcode0 == 7'b1111110) & (opcode1 == 7'b1111110) & (finished_storing == 1'b1))
		begin
			whose_turn <= whose_turn^1'b1; // next time both ask for lock, lock the other core
			lock <= whose_turn + 2'b1;
			finished_storing <= 1'b0;
		end
		else if ((opcode0 == 7'b1111110) & (finished_storing == 1'b1) & (opcode1 != 7'b1111111))
		begin
			lock <= 2'b10; // lock core 1
			whose_turn <= 1'b1; // next time both ask for lock, lock core 0
			finished_storing <= 1'b0;
		end
		else if ((opcode1 == 7'b1111110) & (finished_storing == 1'b1) & (opcode0 != 7'b1111111))
		begin
			lock <= 2'b01; // lock core 0
			whose_turn <= 1'b0; // next time both ask for lock, lock core 1
			finished_storing <= 1'b0;
		end
		else if ((opcode0 == 7'b1111111) | (opcode1 == 7'b1111111))
		begin
			finished_storing <= 1'b1;
		end
		*/
	end
endmodule
