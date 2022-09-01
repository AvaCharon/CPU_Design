module Reg_IF_ID(
    input   clk,
    input   rst_n,

    input   [31:0]inst_IF,
    input   [31:0]pc_IF,
    input   [31:0]pc4_IF,

    input   stall_IF_ID,
    input   flush_IF_ID,

    output  reg [31:0]inst_ID,
    output  reg [31:0]pc_ID,
    output  reg [31:0]pc4_ID
);

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        inst_ID<=0;
    end
    else if(flush_IF_ID)
    begin
        inst_ID<=0;
    end
    else if(stall_IF_ID)
    begin
        inst_ID<=inst_ID;
    end
    else
    begin
        inst_ID<=inst_IF;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        pc_ID<=0;
    end
    else if(flush_IF_ID)
    begin
        pc_ID<=0;
    end
    else if(stall_IF_ID)
    begin
        pc_ID<=pc_ID;
    end
    else
    begin
        pc_ID<=pc_IF;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        pc4_ID<=0;
    end
    else if(flush_IF_ID)
    begin
        pc4_ID<=0;
    end
    else if(stall_IF_ID)
    begin
        pc4_ID<=pc4_ID;
    end
    else
    begin
        pc4_ID<=pc4_IF;
    end
end



endmodule