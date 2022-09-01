module cpu_top(
    input wire clk,
    input wire rst_n,

    input wire [31:0] rData,
    output wire [31:0] display,
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

// assign display = {31'b0,stall_PC_con};
assign display = inst;

wire [31:0] npc;
wire npc_op;
wire [31:0] pc_4;
wire [31:0] inst;
wire [31:0] pc;
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

assign alu_a = (Asel_EX_con==1)?rD1_EX_con:pc_EX_con;
assign alu_b = (Bsel_EX_con==1)?ext_EX_con:rD2_EX_con;
assign regData_wb = (WBsel_MEM_con==0)?pc4_MEM_con:((WBsel_MEM_con==1)?c_MEM_con:dram_rd);

assign addr=c_MEM_con;
assign wData=rD2_MEM_con;
assign wen = Dram_we_MEM_con;
assign dram_rd=rData;

wire [31:0]inst_ID_con;
wire [31:0]pc_ID_con,pc_EX_con;
wire [31:0]pc4_ID_con,pc4_EX_con,pc4_MEM_con;
wire [31:0]rD1_EX_con,rD2_EX_con,rD2_MEM_con;
wire [31:0]ext_EX_con;
wire [4:0]wR_EX_con,wR_MEM_con,wR_WB_con;
wire Asel_EX_con,Bsel_EX_con;
wire [3:0]Alu_op_EX_con;
wire RF_we_EX_con,RF_we_MEM_con,RF_we_WB_con;
wire Dram_we_EX_con,Dram_we_MEM_con;
wire [1:0]WBsel_EX_con,WBsel_MEM_con;
wire [31:0]c_MEM_con;
wire [31:0]RF_wd_WB_con;

//hazard
wire [31:0]rD1_fw_con,rD2_fw_con;
wire stall_PC_con,stall_IF_ID_con;
wire flush_IF_ID_con,flush_ID_EX_con;
wire rD1_fw_op_con,rD2_fw_op_con;
wire rR1_use_con,rR2_use_con;
wire npc_op_EX_con;

hazard_ctrl U_hazard_ctrl(
    .wR_EX(wR_EX_con),
    .wR_MEM(wR_MEM_con),
    .wR_WB(wR_WB_con),
    .rf_we_EX(RF_we_EX_con),
    .rf_we_MEM(RF_we_MEM_con),
    .rf_we_WB(RF_we_WB_con),
    .rR1_ID(inst_ID_con[19:15]),
    .rR2_ID(inst_ID_con[24:20]),
    .pc4_EX(pc4_EX_con),
    .c_EX(alu_c),
    .wD_MEM(regData_wb),
    .wD_WB(RF_wd_WB_con),
    .WBsel_EX(WBsel_EX_con),
    .npc_op_EX(npc_op_EX_con),
    .rR1_use(rR1_use_con),
    .rR2_use(rR2_use_con),

    .rD1_fw(rD1_fw_con),
    .rD2_fw(rD2_fw_con),
    .rD1_fw_op(rD1_fw_op_con),
    .rD2_fw_op(rD2_fw_op_con),
    .stall_PC(stall_PC_con),
    .stall_IF_ID(stall_IF_ID_con),
    .flush_IF_ID(flush_IF_ID_con),
    .flush_ID_EX(flush_ID_EX_con)
);

NPC npcImpl(
    .pc(pc),
    .c(alu_c),
    .npc_op(npc_op_EX_con),
    .pc_4(pc_4),
    .npc(npc)
);

PC pcImpl(
    .pc(pc),
    .clk(clk),
    .rst_n(rst_n),
    .stall_PC(stall_PC_con),
    .npc(npc)
);

prgrom iromImpl(
    .a(pc[15:2]),
    .spo(inst)
); 

Reg_IF_ID U_Reg_IF_ID(
    .clk(clk),
    .rst_n(rst_n),
    .inst_IF(inst),
    .pc_IF(pc),
    .pc4_IF(pc_4),
    .stall_IF_ID(stall_IF_ID_con),
    .flush_IF_ID(flush_IF_ID_con),
    .inst_ID(inst_ID_con),
    .pc_ID(pc_ID_con),
    .pc4_ID(pc4_ID_con)
);

RF rfImpl(
    .wD(RF_wd_WB_con),
    .wR(wR_WB_con),
    .rR1(inst_ID_con[19:15]),
    .rR2(inst_ID_con[24:20]),
    .we(RF_we_WB_con),
    .clk(rf_clk),
    .rst_n(rst_n),
    .rD1(regData_1),
    .rD2(regData_2),

    .rdata_19(rdata_19_out)
);

SEXT sextImpl(
    .din(inst_ID_con[31:7]),
    .sext_op(sext_op),
    .ext(ext)
);

Reg_ID_EX U_Reg_ID_EX(
    .clk(clk),
    .rst_n(rst_n),

    .pc_ID(pc_ID_con),
    .pc4_ID(pc4_ID_con),
    .rD1_ID(regData_1),
    .rD2_ID(regData_2),
    .ext_ID(ext),
    .wR_ID(inst_ID_con[11:7]),
    .Bsel_ID(bsel),
    .Asel_ID(asel),
    .Alu_op_ID(alu_op),
    .RF_we_ID(rf_we),
    .Dram_we_ID(dram_we),
    .WBsel_ID(wbsel),
    .npc_op_ID(npc_op),

    .flush_ID_EX(flush_ID_EX_con),

    .rD1_fw(rD1_fw_con),
    .rD2_fw(rD2_fw_con),
    .rD1_fw_op(rD1_fw_op_con),
    .rD2_fw_op(rD2_fw_op_con),

    .npc_op_EX(npc_op_EX_con),
    .pc_EX(pc_EX_con),
    .pc4_EX(pc4_EX_con),
    .rD1_EX(rD1_EX_con),
    .rD2_EX(rD2_EX_con),
    .ext_EX(ext_EX_con),
    .wR_EX(wR_EX_con),
    .Bsel_EX(Bsel_EX_con),
    .Asel_EX(Asel_EX_con),
    .Alu_op_EX(Alu_op_EX_con),
    .RF_we_EX(RF_we_EX_con),
    .Dram_we_EX(Dram_we_EX_con),
    .WBsel_EX(WBsel_EX_con)
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
    .op(Alu_op_EX_con),
    .c(alu_c)
);

Reg_EX_MEM U_Reg_EX_MEM(
    .clk(clk),
    .rst_n(rst_n),

    .pc4_EX(pc4_EX_con),
    .c_EX(alu_c),
    .rD2_EX(rD2_EX_con),
    .wR_EX(wR_EX_con),
    .RF_we_EX(RF_we_EX_con),
    .Dram_we_EX(Dram_we_EX_con),
    .WBsel_EX(WBsel_EX_con),

    .pc4_MEM(pc4_MEM_con),
    .c_MEM(c_MEM_con),
    .rD2_MEM(rD2_MEM_con),
    .wR_MEM(wR_MEM_con),
    .RF_we_MEM(RF_we_MEM_con),
    .Dram_we_MEM(Dram_we_MEM_con),
    .WBsel_MEM(WBsel_MEM_con)
);

Reg_MEM_WB U_Reg_MEM_WB(
    .clk(clk),
    .rst_n(rst_n),

    .RF_wd_MEM(regData_wb),
    .wR_MEM(wR_MEM_con),
    .RF_we_MEM(RF_we_MEM_con),

    .RF_wd_WB(RF_wd_WB_con),
    .wR_WB(wR_WB_con),
    .RF_we_WB(RF_we_WB_con)
);

Control controlImpl(
    .inst(inst_ID_con),
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
    .sext_op(sext_op),

    .rR1_use(rR1_use_con),
    .rR2_use(rR2_use_con)
);

endmodule