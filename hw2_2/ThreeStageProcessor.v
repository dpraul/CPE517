`include "instructions.v"

module ThreeStageProcessor(
	input clk
);

wire[31:0] instruction;

FetchStage fs (.clk(clk),
	// to DecodeStage
	.InstrOut(instruction)
);


wire[3:0] addr1, addr2, addr_wr_ds, opcode, rd;
wire[31:0] regval1, regval2, regstore_ds_rb, src1, src2;
wire rw_ds;

DecodeStage ds (.clk(clk),
	// from DecodeStage
	.InstrIn(instruction),
	// to RegisterBank
	.address1_ds(addr1), .address2_ds(addr2),
	.regval1_ds(regval1), .regval2_ds(regval2),
	.rw_ds(rw_ds), .regstore_ds(regstore_ds_rb), .addr_wr_ds(addr_wr_ds),
	// to ExecuteStage
	.opcode_out(opcode), .out_Rd(rd), .src1(src1), .src2(src2)
);

wire[3:0] addr_wr_es;
wire[31:0] regstore_es_rb;
wire rw_es;


ExecuteStage es (.clk(clk),
	// from DecodeStage
	.opcode(opcode), .Rd(rd), .src1(src1), .src2(src2),
	// to RegisterBank
	.addr_wr_es(addr_wr_es), .outval_es(regstore_es_rb), .rw_es(rw_es)
);


RegisterBank rb (
	// from DecodeStage
	.address1_ds(addr1), .address2_ds(addr2),
	.outval1_ds(regval1), .outval2_ds(regval2),
	.rw_ds(rw_ds), .inval_ds(regstore_ds_rb), .addr_wr_ds(addr_wr_ds),
	// from ExecuteStage
	.rw_es(rw_es), .inval_es(regstore_es_rb), .addr_wr_es(addr_wr_es)
);


endmodule
