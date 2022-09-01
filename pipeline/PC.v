module PC(
    input [31:0]npc,
    input clk,
    input rst_n,
    input stall_PC,
    output [31:0]pc
);

reg rst_n_reg;
reg [31:0]pc_reg;

assign pc=pc_reg;

always@(posedge clk)
begin
    rst_n_reg<=rst_n;    
end

always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        pc_reg <= 0;
    end
    else if(~rst_n_reg)
    begin
        pc_reg <=0;
    end
    else if(stall_PC)
    begin
        pc_reg<=pc_reg;
    end
    else
    begin
        pc_reg <= npc;
    end
end

endmodule