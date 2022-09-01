module NPC(
    input [31:0]pc,
    input [31:0]c,
    input npc_op,
    output [31:0]pc_4,
    output [31:0]npc
);

reg [31:0]pc_4_reg;
reg [31:0]npc_reg;

assign pc_4=pc_4_reg;
assign npc=npc_reg;

always@(*)
begin
    pc_4_reg=pc+4;
end

always@(*)
begin
    case (npc_op)
        //pc+4
        1'b0:
        begin
            npc_reg=pc+4;
        end 
        //BrEq\BrLt\jal\jalr
        1'b1:
        begin
            npc_reg=c;
        end
        default: npc_reg=pc+4;
    endcase
end

endmodule