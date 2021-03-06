`include "instructions.v"


module ExecuteStage(
	// from global
	input clk,

	// from DecodeStage
	input[3:0] opcode, input[3:0] Rd,
	input[31:0] src1, input[31:0] src2,

	// to RegisterBank
	output reg[3:0] addr_wr_es,
	output reg rw_es, // 0 for read, 1 for write
	output reg[31:0] outval_es
);

reg[5:0] opcode_padded;

initial begin
	rw_es = 0;
end


always @(posedge clk) begin
	opcode_padded = {2'b0, opcode};

	case(opcode_padded)
	`ADD: outval_es = src1 + src2;
	`SUB: outval_es = src1 - src2;
	`MUL: outval_es = src1 * src2;
	`DIV: outval_es = src1 / src2;
	endcase

	if (opcode_padded != `MOV) begin  // these are dealt with in the DecodeStage
		addr_wr_es <= Rd;
		// toggle rw_es to write value
		rw_es <= 1;
		#1 rw_es <= 0;
	end
end


endmodule
