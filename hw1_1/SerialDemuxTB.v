module SerialDemuxTB();

// Inputs
reg [7:0] DataIn;
reg NewPacket;
reg clk;

// Outputs
wire [7:0] DataOut0, DataOut1, DataOut2, DataOut3, 
	   DataOut4, DataOut5, DataOut6, DataOut7;

// Initialize Unit Under Test
SerialDemux uut (
	.DataIn(DataIn), .NewPacket(NewPacket), .clk(clk),
	.DataOut0(DataOut0), .DataOut1(DataOut1), .DataOut2(DataOut2),
	.DataOut3(DataOut3), .DataOut4(DataOut4), .DataOut5(DataOut5),
	.DataOut6(DataOut6), .DataOut7(DataOut7)
);

initial begin
	DataIn = 0;
	NewPacket = 0;
	clk = 0;

	#13; DataIn = {4'd7, 4'd3};
	NewPacket = 1;
	#10; DataIn = {4'd1, 4'd1};
	NewPacket = 0;
	#10; DataIn = {4'd2, 4'd2};
	NewPacket = 0;
	#10; DataIn = {4'd3, 4'd3};
	NewPacket = 0;
	#10; DataIn = {4'd4, 4'd4};
	NewPacket = 0;
	#10; DataIn = {4'd0, 4'd0};
	NewPacket = 0;
	#10; DataIn = {4'd0, 4'd2};
	NewPacket = 1;
	#10; DataIn = {4'd8, 4'd8};
	NewPacket = 0;
	#10; DataIn = {4'd9, 4'd9};
	NewPacket = 0;
end

always begin
	#5 clk = ~clk;
end

endmodule