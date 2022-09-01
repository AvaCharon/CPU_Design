module ALU(
    input [31:0]a,
    input [31:0]b,
    input [3:0]op,
    output [31:0]c
);

reg [31:0]c_reg;

wire [4:0] shift;

assign c=c_reg;
assign shift = b[4:0];

always@(*)
begin
    case(op)
        //add
        4'b0000:
        begin
            c_reg=a+b;
        end
        //sub
        4'b0001:
        begin
            c_reg=a-b;
        end
        //and
        4'b0010:
        begin
            c_reg=a&b;
        end
        //or
        4'b0011:
        begin
            c_reg=a|b;
        end
        //xor
        4'b0100:
        begin
            c_reg=a^b;
        end
        //sll
        4'b0101:
        begin
            case(shift)
                5'd00: c_reg = a;
                5'd01: c_reg = a << 01;
                5'd02: c_reg = a << 02;
                5'd03: c_reg = a << 03;
                5'd04: c_reg = a << 04;
                5'd05: c_reg = a << 05;
                5'd06: c_reg = a << 06;
                5'd07: c_reg = a << 07;
                5'd08: c_reg = a << 08;
                5'd09: c_reg = a << 09;
                5'd10: c_reg = a << 10;
                5'd11: c_reg = a << 11;
                5'd12: c_reg = a << 12;
                5'd13: c_reg = a << 13;
                5'd14: c_reg = a << 14;
                5'd15: c_reg = a << 15;
                5'd16: c_reg = a << 16;
                5'd17: c_reg = a << 17;
                5'd18: c_reg = a << 18;
                5'd19: c_reg = a << 19;
                5'd20: c_reg = a << 20;
                5'd21: c_reg = a << 21;
                5'd22: c_reg = a << 22;
                5'd23: c_reg = a << 23;
                5'd24: c_reg = a << 24;
                5'd25: c_reg = a << 25;
                5'd26: c_reg = a << 26;
                5'd27: c_reg = a << 27;
                5'd28: c_reg = a << 28;
                5'd29: c_reg = a << 29;
                5'd30: c_reg = a << 30;
                5'd31: c_reg = a << 31;
                default: c_reg = a;
            endcase
        end
        //srl
        4'b0110:
        begin
            case(shift)
                5'd00: c_reg = a;
                5'd01: c_reg = a >> 01;
                5'd02: c_reg = a >> 02;
                5'd03: c_reg = a >> 03;
                5'd04: c_reg = a >> 04;
                5'd05: c_reg = a >> 05;
                5'd06: c_reg = a >> 06;
                5'd07: c_reg = a >> 07;
                5'd08: c_reg = a >> 08;
                5'd09: c_reg = a >> 09;
                5'd10: c_reg = a >> 10;
                5'd11: c_reg = a >> 11;
                5'd12: c_reg = a >> 12;
                5'd13: c_reg = a >> 13;
                5'd14: c_reg = a >> 14;
                5'd15: c_reg = a >> 15;
                5'd16: c_reg = a >> 16;
                5'd17: c_reg = a >> 17;
                5'd18: c_reg = a >> 18;
                5'd19: c_reg = a >> 19;
                5'd20: c_reg = a >> 20;
                5'd21: c_reg = a >> 21;
                5'd22: c_reg = a >> 22;
                5'd23: c_reg = a >> 23;
                5'd24: c_reg = a >> 24;
                5'd25: c_reg = a >> 25;
                5'd26: c_reg = a >> 26;
                5'd27: c_reg = a >> 27;
                5'd28: c_reg = a >> 28;
                5'd29: c_reg = a >> 29;
                5'd30: c_reg = a >> 30;
                5'd31: c_reg = a >> 31;
                default: c_reg = a;
            endcase
        end
        //sra
        4'b0111:
        begin
            case(shift)
                5'd00: c_reg = a;
                5'd01: c_reg = $signed(a) >>> 01;
                5'd02: c_reg = $signed(a) >>> 02;
                5'd03: c_reg = $signed(a) >>> 03;
                5'd04: c_reg = $signed(a) >>> 04;
                5'd05: c_reg = $signed(a) >>> 05;
                5'd06: c_reg = $signed(a) >>> 06;
                5'd07: c_reg = $signed(a) >>> 07;
                5'd08: c_reg = $signed(a) >>> 08;
                5'd09: c_reg = $signed(a) >>> 09;
                5'd10: c_reg = $signed(a) >>> 10;
                5'd11: c_reg = $signed(a) >>> 11;
                5'd12: c_reg = $signed(a) >>> 12;
                5'd13: c_reg = $signed(a) >>> 13;
                5'd14: c_reg = $signed(a) >>> 14;
                5'd15: c_reg = $signed(a) >>> 15;
                5'd16: c_reg = $signed(a) >>> 16;
                5'd17: c_reg = $signed(a) >>> 17;
                5'd18: c_reg = $signed(a) >>> 18;
                5'd19: c_reg = $signed(a) >>> 19;
                5'd20: c_reg = $signed(a) >>> 20;
                5'd21: c_reg = $signed(a) >>> 21;
                5'd22: c_reg = $signed(a) >>> 22;
                5'd23: c_reg = $signed(a) >>> 23;
                5'd24: c_reg = $signed(a) >>> 24;
                5'd25: c_reg = $signed(a) >>> 25;
                5'd26: c_reg = $signed(a) >>> 26;
                5'd27: c_reg = $signed(a) >>> 27;
                5'd28: c_reg = $signed(a) >>> 28;
                5'd29: c_reg = $signed(a) >>> 29;
                5'd30: c_reg = $signed(a) >>> 30;
                5'd31: c_reg = $signed(a) >>> 31;
                default: c_reg = a;
            endcase
        end
        //U
        4'b1000:
        begin
            c_reg=b;
        end
        default:c_reg=a;
    endcase
end
endmodule