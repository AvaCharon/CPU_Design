module Reg_ID_EX(
    input   clk,
    input   rst_n,

    input   [31:0]pc_ID,
    input   [31:0]pc4_ID,
    input   [31:0]rD1_ID,
    input   [31:0]rD2_ID,
    input   [31:0]ext_ID,
    input   [4:0]wR_ID,
    input   Bsel_ID,
    input   Asel_ID,
    input   [3:0]Alu_op_ID,
    input   RF_we_ID,
    input   Dram_we_ID,
    input   [1:0]WBsel_ID,
    input   npc_op_ID,

    input   flush_ID_EX,

    input   [31:0]rD1_fw,
    input   [31:0]rD2_fw,
    input   rD1_fw_op,
    input   rD2_fw_op,

    output  reg [31:0]pc_EX,
    output  reg [31:0]pc4_EX,
    output  reg [31:0]rD1_EX,
    output  reg [31:0]rD2_EX,
    output  reg [31:0]ext_EX,
    output  reg [4:0]wR_EX,
    output  reg Bsel_EX,
    output  reg Asel_EX,
    output  reg [3:0]Alu_op_EX,
    output  reg RF_we_EX,
    output  reg Dram_we_EX,
    output  reg [1:0]WBsel_EX,
    output  reg npc_op_EX
);

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        npc_op_EX<=0;
    end
    else
    begin
        npc_op_EX<=npc_op_ID;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        WBsel_EX<=0;
    end
    else if(flush_ID_EX)
    begin
        WBsel_EX<=0;
    end
    else
    begin
        WBsel_EX<=WBsel_ID;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        Dram_we_EX<=0;
    end
    else if(flush_ID_EX)
    begin
        Dram_we_EX<=0;
    end
    else
    begin
        Dram_we_EX<=Dram_we_ID;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        RF_we_EX<=0;
    end
    else if(flush_ID_EX)
    begin
        RF_we_EX<=0;
    end
    else
    begin
        RF_we_EX<=RF_we_ID;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        Alu_op_EX<=0;
    end
    else if(flush_ID_EX)
    begin
        Alu_op_EX<=0;
    end
    else
    begin
        Alu_op_EX<=Alu_op_ID;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        Asel_EX<=0;
    end
    else
    begin
        Asel_EX<=Asel_ID;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        Bsel_EX<=0;
    end
    else
    begin
        Bsel_EX<=Bsel_ID;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        wR_EX<=0;
    end
    else
    begin
        wR_EX<=wR_ID;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        pc_EX<=0;
    end
    else
    begin
        pc_EX<=pc_ID;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        pc4_EX<=0;
    end
    else
    begin
        pc4_EX<=pc4_ID;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        rD1_EX<=0;
    end
    else if(rD1_fw_op)
    begin
        rD1_EX<=rD1_fw;
    end
    else
    begin
        rD1_EX<=rD1_ID;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        rD2_EX<=0;
    end
    else if(rD2_fw_op)
    begin
        rD2_EX<=rD2_fw;
    end
    else
    begin
        rD2_EX<=rD2_ID;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        ext_EX<=0;
    end
    else
    begin
        ext_EX<=ext_ID;
    end
end


endmodule