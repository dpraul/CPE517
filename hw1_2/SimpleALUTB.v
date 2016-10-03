`define STO 4'b0001
`define ADD 4'b0010
`define SUB 4'b0011
`define MUL 4'b0100
`define DIV 4'b0101

module SimpleALUTB();
// Inputs
reg [16:0] command;

// Initialize Unit Under Test
SimpleALU uut (
	.command(command)
);

initial begin
	#10 command = {`STO, 4'd2, 4'd0, 4'd0};
	#20;

	#10 command = {`STO, 4'd0, 4'd5, 4'd0};
	#10 command = {`STO, 4'd1, 4'd4, 4'd0};
	#10 command = {`MUL, 4'd1, 4'd1, 4'd0};
	#10 command = {`ADD, 4'd2, 4'd2, 4'd1};
	#20;

	#10 command = {`STO, 4'd0, 4'd6, 4'd0};
	#10 command = {`STO, 4'd1, 4'd7, 4'd0};
	#10 command = {`MUL, 4'd1, 4'd1, 4'd0};
	#10 command = {`ADD, 4'd2, 4'd2, 4'd1};
	#20;

	#10 command = {`STO, 4'd0, 4'd2, 4'd0};
	#10 command = {`STO, 4'd1, 4'd1, 4'd0};
	#10 command = {`MUL, 4'd1, 4'd1, 4'd0};
	#10 command = {`ADD, 4'd2, 4'd2, 4'd1};
	#20;

end

endmodule
