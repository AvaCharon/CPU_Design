module Reg_MEM_WB(
    input   clk,
    input   rst_n,

    input   [31:0]RF_wd_MEM,
    input   [4:0]wR_MEM,
    input   RF_we_MEM,
    
    output  reg [31:0] RF_wd_WB,
    output  reg [4:0] wR_WB,
    output  reg RF_we_WB
);

always@(posedge clk or negedge rst_n)
begin
    if(rst_n)
    begin
        RF_wd_WB<=0;
    end
    else
    begin
        RF_wd_WB<=RF_wd_MEM;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(rst_n)
    begin
        wR_WB<=0;
    end
    else
    begin
        wR_WB<=wR_MEM;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(rst_n)
    begin
        RF_we_WB<=0;
    end
    else
    begin
        RF_we_WB<=RF_we_MEM;
    end
end

endmodule