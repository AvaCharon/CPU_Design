`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/06 21:23:32
// Design Name: 
// Module Name: clock_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

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
