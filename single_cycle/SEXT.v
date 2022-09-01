module SEXT(
    input [24:0]din,
    input [2:0]sext_op,
    output [31:0]ext
);

reg [31:0] ext_reg;
assign ext=ext_reg;

always@(*)
begin
    case (sext_op)
        //I
        3'b000: 
        begin
            ext_reg={{20{din[24]}},din[24:13]};
        end
        //S
        3'b001: 
        begin
            ext_reg={{20{din[24]}},din[24:18],din[4:0]};
        end
        //U
        3'b010: 
        begin
            ext_reg={din[24:5],{12{1'b0}}};
        end
        //UJ
        3'b011: 
        begin
            ext_reg={{12{din[24]}},din[12:5],din[13],din[23:14],1'b0};
        end
        //B
        3'b100:
        begin
            ext_reg={{20{din[24]}},din[0],din[23:18],din[4:1],1'b0};
        end
        default: 
            ext_reg={{7{1'b0}},din[24:0]};
    endcase
end

endmodule