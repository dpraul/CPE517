`include "instructions.v"

module ThreeStageProcessor_TB();


reg clk;

ThreeStageProcessor uut (
	.clk(clk)
);

initial begin
	clk = 0;
end


always begin
	#5 clk = ~clk;
end


endmodule
