`timescale 1ns / 1ps
//in:10ns
//out:2ms

module clock_divider(
    input      clk,
    output reg out
    );
    reg [15:0] cnt = 0;
    reg tag = 1'b0;
    always @ (posedge clk) begin
        if(tag == 1'b0) begin
            out = 1'b0;
            tag = 1'b1;
        end
        else begin
            if(cnt == 20_000) begin
                out = ~out;
                cnt = 0;
            end
            else begin
                cnt = cnt+1'b1;
            end
        end
    end
endmodule
