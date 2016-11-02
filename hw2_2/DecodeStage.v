`include "instructions.v"

module DecodeStage(
	// from global
	input clk,

	// from FetchStage
	input[31:0] InstrIn,

	// read from RegBank
	output reg[3:0] address1_ds,
	output reg[3:0] address2_ds,
	input[31:0] regval1_ds,
	input[31:0] regval2_ds,

	// write to RegBank
	output reg rw_ds,  // 0 for read, 1 for write
	output reg[31:0] regstore_ds,
	output reg[3:0] addr_wr_ds,

	// to ExecuteStage
	output reg[3:0] opcode_out,
	output reg[3:0] out_Rd,
	output reg[31:0] src1,
	output reg[31:0] src2
);

reg[5:0] opcode;
reg[4:0] rs, rt, rd;
reg[15:0] immediate;
reg[10:0] padding;


initial begin
	rw_ds = 0;
end


always @(negedge clk) begin
	if (InstrIn[31] == 1) begin  // immediate
		{opcode, rs, rd, immediate} = InstrIn;
		address2_ds = rs[3:0];
		src1 = {16'b0, immediate};
	end
	else begin
		{opcode, rs, rt, rd, padding} = InstrIn;
		address1_ds = rs[3:0];
		address2_ds = rt[3:0];
	end
	opcode_out = opcode[3:0];
	out_Rd = rd[3:0];

end

always @(regval1_ds) begin
	src1 <= regval1_ds;
end

always @(regval2_ds) begin
	src2 <= regval2_ds;
end

always @(src1) begin
	if (opcode == `MOV || opcode == `MOVI) begin
		#1
		addr_wr_ds <= out_Rd;
		regstore_ds <= src1;
		// toggle rw_ds to write value
		rw_ds <= 1;
		#1 rw_ds <= 0;
	end
end


endmodule
