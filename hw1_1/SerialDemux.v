module SerialDemux(
	input wire clk, input wire NewPacket, input wire[7:0] DataIn,
	output reg[7:0] DataOut0, output reg[7:0] DataOut1, output reg[7:0] DataOut2, output reg[7:0] DataOut3,
	output reg[7:0] DataOut4, output reg[7:0] DataOut5, output reg[7:0] DataOut6, output reg[7:0] DataOut7
);

reg[3:0] counter, channel;


always @(posedge clk) begin
	DataOut0 = 8'h00; DataOut1 = 8'h00; DataOut2 = 8'h00; DataOut3 = 8'h00;
	DataOut4 = 8'h00; DataOut5 = 8'h00; DataOut6 = 8'h00; DataOut7 = 8'h00;
	if (NewPacket == 1) begin
		{channel, counter} = DataIn;
	end
	else begin
		if (channel == 8) begin
			channel = 0;
		end
		if (counter > 0) begin
			case (channel)
			0: DataOut0 = DataIn;
			1: DataOut1 = DataIn;
			2: DataOut2 = DataIn;
			3: DataOut3 = DataIn;
			4: DataOut4 = DataIn;
			5: DataOut5 = DataIn;
			6: DataOut6 = DataIn;
			7: DataOut7 = DataIn;	
			endcase
			
			counter = counter - 1;
			channel = channel + 1;
		end
		
	end

end

endmodule