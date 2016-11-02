`include "instructions.v"

module FetchStage (
	input clk,
	output reg[31:0] InstrOut
);

reg[31:0] ROM [0:127];
reg[7:0] i;

initial begin
        for(i = 0; i < 128; i=i+1)
        begin
            ROM[i] = 32'b0;
        end
	i = 0;
	// r0 loads first operand
	// r1 holds product of operands
	// r2 holds accumulation of products
	// v1: [1,2,3,4,5,6,7,8,9,10]
	// v2: [4,5,6,4,5,6,4,5,6,4]
	// v1[0] * v2[0] -- > 1 * 4
	ROM[0] = {`MOVI, 5'd0, 5'd0, 16'd1};
	ROM[1] = {`MULI, 5'd0, 5'd1, 16'd4};
	ROM[2] = {`ADD, 5'd1, 5'd2, 5'd2, 11'd0};
	// v1[1] * v2[1] -- > 2 * 5
	ROM[3] = {`MOVI, 5'd0, 5'd0, 16'd2};
	ROM[4] = {`MULI, 5'd0, 5'd1, 16'd5};
	ROM[5] = {`ADD, 5'd1, 5'd2, 5'd2, 11'd0};
	// v1[2] * v2[2] -- > 3 * 6
	ROM[6] = {`MOVI, 5'd0, 5'd0, 16'd3};
	ROM[7] = {`MULI, 5'd0, 5'd1, 16'd6};
	ROM[8] = {`ADD, 5'd1, 5'd2, 5'd2, 11'd0};
	// v1[3] * v2[3] -- > 4 * 4
	ROM[9] = {`MOVI, 5'd0, 5'd0, 16'd4};
	ROM[10] = {`MULI, 5'd0, 5'd1, 16'd4};
	ROM[11] = {`ADD, 5'd1, 5'd2, 5'd2, 11'd0};
	// v1[4] * v2[4] -- > 5 * 5
	ROM[12] = {`MOVI, 5'd0, 5'd0, 16'd5};
	ROM[13] = {`MULI, 5'd0, 5'd1, 16'd5};
	ROM[14] = {`ADD, 5'd1, 5'd2, 5'd2, 11'd0};
	// v1[5] * v2[5] -- > 6 * 6
	ROM[15] = {`MOVI, 5'd0, 5'd0, 16'd6};
	ROM[16] = {`MULI, 5'd0, 5'd1, 16'd6};
	ROM[17] = {`ADD, 5'd1, 5'd2, 5'd2, 11'd0};
	// v1[6] * v2[6] -- > 7 * 4
	ROM[18] = {`MOVI, 5'd0, 5'd0, 16'd7};
	ROM[19] = {`MULI, 5'd0, 5'd1, 16'd4};
	ROM[20] = {`ADD, 5'd1, 5'd2, 5'd2, 11'd0};
	// v1[7] * v2[7] -- > 8 * 5
	ROM[21] = {`MOVI, 5'd0, 5'd0, 16'd8};
	ROM[22] = {`MULI, 5'd0, 5'd1, 16'd5};
	ROM[23] = {`ADD, 5'd1, 5'd2, 5'd2, 11'd0};
	// v1[8] * v2[8] -- > 9 * 6
	ROM[24] = {`MOVI, 5'd0, 5'd0, 16'd9};
	ROM[25] = {`MULI, 5'd0, 5'd1, 16'd6};
	ROM[26] = {`ADD, 5'd1, 5'd2, 5'd2, 11'd0};
	// v1[9] * v2[9] -- > 10 * 4
	ROM[27] = {`MOVI, 5'd0, 5'd0, 16'd10};
	ROM[28] = {`MULI, 5'd0, 5'd1, 16'd4};
	ROM[29] = {`ADD, 5'd1, 5'd2, 5'd2, 11'd0};
	ROM[30] = 32'd0;

end


always @(posedge clk) begin
	InstrOut <= ROM[i];
	#1 i = i + 1;
end

endmodule
