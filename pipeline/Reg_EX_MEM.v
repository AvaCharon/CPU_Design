module Reg_EX_MEM(
    input   clk,
    input   rst_n,

    input   [31:0]pc4_EX,
    input   [31:0]c_EX,
    input   [31:0]rD2_EX,
    input   [4:0]wR_EX,
    input   RF_we_EX,
    input   Dram_we_EX,
    input   [1:0]WBsel_EX,
    
    output  reg [31:0] pc4_MEM,
    output  reg [31:0] c_MEM,
    output  reg [31:0] rD2_MEM,
    output  reg [4:0] wR_MEM,
    output  reg RF_we_MEM,
    output  reg Dram_we_MEM,
    output  reg [1:0] WBsel_MEM
);

always@(posedge clk or negedge rst_n)
begin
    if(rst_n)
    begin
        rD2_MEM<=0;
    end
    else
    begin
        rD2_MEM<=rD2_EX;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(rst_n)
    begin
        pc4_MEM<=0;
    end
    else
    begin
        pc4_MEM<=pc4_EX;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(rst_n)
    begin
        c_MEM<=0;
    end
    else
    begin
        c_MEM<=c_EX;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(rst_n)
    begin
        wR_MEM<=0;
    end
    else
    begin
        wR_MEM<=wR_EX;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(rst_n)
    begin
        RF_we_MEM<=0;
    end
    else
    begin
        RF_we_MEM<=RF_we_EX;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(rst_n)
    begin
        Dram_we_MEM<=0;
    end
    else
    begin
        Dram_we_MEM<=Dram_we_EX;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(rst_n)
    begin
        WBsel_MEM<=0;
    end
    else
    begin
        WBsel_MEM<=WBsel_EX;
    end
end

endmodule