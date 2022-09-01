module Control(
    input [31:0]inst,
    input breq,
    input brlt,
    output npc_op,
    output rf_we,
    output brun,
    output asel,
    output bsel,
    output [1:0]wbsel,
    output dram_we,
    output [3:0]alu_op,
    output [2:0]sext_op,

    output reg rR1_use,
    output reg rR2_use
);

wire [10:0] op;
reg npc_op_reg;
reg rf_we_reg;
reg asel_reg;
reg bsel_reg;
reg [1:0]wbsel_reg;
reg dram_we_reg;
reg [3:0]alu_op_reg;
reg [2:0]sext_op_reg;

assign npc_op=npc_op_reg;
assign rf_we=rf_we_reg;
assign asel=asel_reg;
assign bsel=bsel_reg;
assign wbsel=wbsel_reg;
assign dram_we=dram_we_reg;
assign alu_op=alu_op_reg;
assign sext_op=sext_op_reg;

assign op = {inst[30],inst[14:12],inst[6:0]};

//branch\npc_op
always@(*)
begin
    case (op)
        //jalr
        11'b00001100111:
        begin
            npc_op_reg=1;
        end
        11'b10001100111:
        begin
            npc_op_reg=1;
        end
        //beq
        11'b00001100011:
        begin
            if (breq==1) 
            begin
                npc_op_reg=1;    
            end
            else
            begin
                npc_op_reg=0;
            end
        end
        11'b10001100011:
        begin
            if (breq==1) 
            begin
                npc_op_reg=1;    
            end
            else
            begin
                npc_op_reg=0;
            end
        end
        //bne
        11'b00011100011:
        begin
            if (breq==1) 
            begin
                npc_op_reg=0;    
            end
            else
            begin
                npc_op_reg=1;
            end
        end
        11'b10011100011:
        begin
            if (breq==1) 
            begin
                npc_op_reg=0;    
            end
            else
            begin
                npc_op_reg=1;
            end
        end
        //blt
        11'b01001100011:
        begin
            if (brlt==1) 
            begin
                npc_op_reg=1;    
            end
            else
            begin
                npc_op_reg=0;
            end
        end
        11'b11001100011:
        begin
            if (brlt==1) 
            begin
                npc_op_reg=1;    
            end
            else
            begin
                npc_op_reg=0;
            end
        end
        //bge-add
        11'b01011100011:
        begin
            if (brlt==1) 
            begin
                npc_op_reg=0;    
            end
            else
            begin
                npc_op_reg=1;
            end
        end
        11'b11011100011:
        begin
            if (brlt==1) 
            begin
                npc_op_reg=0;    
            end
            else
            begin
                npc_op_reg=1;
            end
        end
        default:
        begin
            case (op[6:0])
                //jal
                7'b1101111: 
                begin
                    npc_op_reg=1;
                end
                default: npc_op_reg=0;
            endcase
        end
    endcase
end

//alu_op\sext_op\rf_we\asel\bsel\dram_we\wbsel
//rR1_use\rR2_use
always@(*)
begin
    case(op)
        //add-add
        11'b00000110011:
        begin
            alu_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=0;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        //sub-sub
        11'b10000110011:
        begin
            alu_op_reg=1;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=0;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        //and-and
        11'b01110110011:
        begin
            alu_op_reg=2;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=0;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        //or-or
        11'b01100110011:
        begin
            alu_op_reg=3;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=0;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        //xor-xor
        11'b01000110011:
        begin
            alu_op_reg=4;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=0;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        //sll-sll
        11'b00010110011:
        begin
            alu_op_reg=5;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=0;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        //srl-srl
        11'b01010110011:
        begin
            alu_op_reg=6;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=0;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        //sra-sra
        11'b11010110011:
        begin
            alu_op_reg=7;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=0;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        //addi-add
        11'b00000010011:
        begin
            alu_op_reg=0;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=0;
        end
        11'b10000010011:
        begin
            alu_op_reg=0;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=0;
        end
        //andi-and
        11'b01110010011:
        begin
            alu_op_reg=2;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=0;
        end
        11'b11110010011:
        begin
            alu_op_reg=2;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=0;
        end
        //ori-or
        11'b01100010011:
        begin
            alu_op_reg=3;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=0;
        end
        11'b11100010011:
        begin
            alu_op_reg=3;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=0;
        end
        //xori-xor
        11'b01000010011:
        begin
            alu_op_reg=4;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=0;
        end
        11'b11000010011:
        begin
            alu_op_reg=4;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=0;
        end
        //slli-sll
        11'b00010010011:
        begin
            alu_op_reg=5;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=0;
        end
        //srli-srl
        11'b01010010011:
        begin
            alu_op_reg=6;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=0;
        end
        //srai-sra
        11'b11010010011:
        begin
            alu_op_reg=7;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=0;
        end
        //lw-add
        11'b00100000011:
        begin
            alu_op_reg=0;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=2;
            rR1_use=1;
            rR2_use=0;
        end
        11'b10100000011:
        begin
            alu_op_reg=0;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=2;
            rR1_use=1;
            rR2_use=0;
        end
        //jalr-add
        11'b00001100111:
        begin
            alu_op_reg=0;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=0;
            rR1_use=1;
            rR2_use=0;
        end
        11'b10001100111:
        begin
            alu_op_reg=0;
            sext_op_reg=0;
            rf_we_reg=1;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=0;
            rR1_use=1;
            rR2_use=0;
        end
        //sw-add
        11'b00100100011:
        begin
            alu_op_reg=0;
            sext_op_reg=1;
            rf_we_reg=0;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=1;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        11'b10100100011:
        begin
            alu_op_reg=0;
            sext_op_reg=1;
            rf_we_reg=0;
            asel_reg=1;
            bsel_reg=1;
            dram_we_reg=1;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        //beq-add
        11'b00001100011:
        begin
            alu_op_reg=0;
            sext_op_reg=4;
            rf_we_reg=0;
            asel_reg=0;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        11'b10001100011:
        begin
            alu_op_reg=0;
            sext_op_reg=4;
            rf_we_reg=0;
            asel_reg=0;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        //bne-add
        11'b00011100011:
        begin
            alu_op_reg=0;
            sext_op_reg=4;
            rf_we_reg=0;
            asel_reg=0;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        11'b10011100011:
        begin
            alu_op_reg=0;
            sext_op_reg=4;
            rf_we_reg=0;
            asel_reg=0;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        //blt-add
        11'b01001100011:
        begin
            alu_op_reg=0;
            sext_op_reg=4;
            rf_we_reg=0;
            asel_reg=0;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        11'b11001100011:
        begin
            alu_op_reg=0;
            sext_op_reg=4;
            rf_we_reg=0;
            asel_reg=0;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        //bge-add
        11'b01011100011:
        begin
            alu_op_reg=0;
            sext_op_reg=4;
            rf_we_reg=0;
            asel_reg=0;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        11'b11011100011:
        begin
            alu_op_reg=0;
            sext_op_reg=4;
            rf_we_reg=0;
            asel_reg=0;
            bsel_reg=1;
            dram_we_reg=0;
            wbsel_reg=1;
            rR1_use=1;
            rR2_use=1;
        end
        default:
        begin
            case (op[6:0])
                //lui-U
                7'b0110111: 
                begin
                    alu_op_reg=8;
                    sext_op_reg=2;
                    rf_we_reg=1;
                    asel_reg=0;
                    bsel_reg=1;
                    dram_we_reg=0;
                    wbsel_reg=1;
                    rR1_use=0;
                    rR2_use=0;
                end
                //jal-add
                7'b1101111: 
                begin
                    alu_op_reg=0;
                    sext_op_reg=3;
                    rf_we_reg=1;
                    asel_reg=0;
                    bsel_reg=1;
                    dram_we_reg=0;
                    wbsel_reg=0;
                    rR1_use=0;
                    rR2_use=0;
                end
                default:
                begin
                    alu_op_reg=15;
                    sext_op_reg=0;
                    rf_we_reg=0;
                    asel_reg=1;
                    bsel_reg=0;
                    dram_we_reg=0;
                    wbsel_reg=1;
                    rR1_use=0;
                    rR2_use=0;
                end
            endcase
        end
    endcase
end

endmodule