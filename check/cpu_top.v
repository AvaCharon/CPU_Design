module cpu_top(
    input wire clk,
    input wire rst_n,

    input wire [31:0] rData,
    output wire [31:0] pc,
    output wire [31:0] addr,
    output wire [31:0] wData,
    output wire wen,

//    output wire [31:0] test_rdata_19
    output wire [31:0] rdata_19
);

wire rf_clk;
assign rf_clk = ~clk;

wire [31:0] rdata_19_out;
assign rdata_19 = rdata_19_out;
//test
//assign test_rdata_19=32'hfedcba98;

wire [31:0] npc;
wire npc_op;
wire [31:0] pc_4;
wire [31:0] inst;
wire [2:0] sext_op;
wire [31:0] ext;
wire rf_we;
wire [31:0] regData_1;
wire [31:0] regData_2;
wire [31:0] regData_wb;
wire brun;
wire breq;
wire brlt;
wire bsel;
wire asel;
wire [31:0] alu_a;
wire [31:0] alu_b;
wire [31:0] alu_c;
wire [3:0] alu_op;
wire dram_we;
wire [31:0] dram_rd;
wire [1:0] wbsel;

assign alu_a = (asel==1)?regData_1:pc;
assign alu_b = (bsel==1)?ext:regData_2;
assign regData_wb = (wbsel==0)?pc_4:((wbsel==1)?alu_c:dram_rd);

assign addr=alu_c;
assign wData=regData_2;
assign wen = dram_we;
assign dram_rd=rData;




NPC npcImpl(
    .pc(pc),
    .c(alu_c),
    .npc_op(npc_op),
    .pc_4(pc_4),
    .npc(npc)
);

PC pcImpl(
    .pc(pc),
    .clk(clk),
    .rst_n(rst_n),
    .npc(npc)
);

prgrom iromImpl(
    .a(pc[15:2]),
    .spo(inst)
); 

RF rfImpl(
    .wD(regData_wb),
    .wR(inst[11:7]),
    .rR1(inst[19:15]),
    .rR2(inst[24:20]),
    .we(rf_we),
    .clk(rf_clk),
    .rst_n(rst_n),
    .rD1(regData_1),
    .rD2(regData_2),

    .rdata_19(rdata_19_out)
);

SEXT sextImpl(
    .din(inst[31:7]),
    .sext_op(sext_op),
    .ext(ext)
);

BC bcImpl(
    .a(regData_1),
    .b(regData_2),
    .BrUn(brun),
    .BrEq(breq),
    .BrLt(brlt)
);

ALU aluImpl(
    .a(alu_a),
    .b(alu_b),
    .op(alu_op),
    .c(alu_c)
);

Control controlImpl(
    .inst(inst),
    .breq(breq),
    .brlt(brlt),
    .npc_op(npc_op),
    .rf_we(rf_we),
    .brun(brun),
    .asel(asel),
    .bsel(bsel),
    .wbsel(wbsel),
    .dram_we(dram_we),
    .alu_op(alu_op),
    .sext_op(sext_op)
);

endmodule