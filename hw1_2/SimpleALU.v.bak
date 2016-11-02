`define STO 4'b0001
`define ADD 4'b0010
`define SUB 4'b0011
`define MUL 4'b0100
`define DIV 4'b0101

module SimpleALU(
	input wire[16:0] command
);

reg[8:0] registers[16:0];
reg[3:0] opcode, dest, op1, op2;
reg[4:0] i;

initial begin
	i = 0;
	repeat(16) begin
		registers[i] = 16'd0;
		i = i + 1;
	end
end

always @(command) begin
	{opcode, dest, op1, op2} = command;
	case (opcode)
	`STO: registers[dest] = op1;
	`ADD: registers[dest] = registers[op1] + registers[op2];
	`SUB: registers[dest] = registers[op1] - registers[op2];
	`MUL: registers[dest] = registers[op1] * registers[op2];
	`DIV: registers[dest] = registers[op1] / registers[op2];
	endcase
end

endmodule