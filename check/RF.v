module RF(
    input [31:0]wD,
    input rst_n,
    input [4:0]wR,
    input [4:0]rR1,
    input [4:0]rR2,
    input we,
    input clk,
    output [31:0]rD1,
    output [31:0]rD2,

    output wire [31:0]rdata_19
);

reg [31:0]dataReg[31:0];

assign rD1 = (rR1 == 5'b0)?32'b0:dataReg[rR1];
assign rD2 = (rR2 == 5'b0)?32'b0:dataReg[rR2];

assign rdata_19 = dataReg[19];

always @(negedge clk or negedge rst_n) 
begin
    if(!rst_n)
    begin
        dataReg[0]  <= 32'b0;
        dataReg[1]  <= 32'b0;
        dataReg[2]  <= 32'b0;
        dataReg[3]  <= 32'b0;
        dataReg[4]  <= 32'b0;
        dataReg[5]  <= 32'b0;
        dataReg[6]  <= 32'b0;
        dataReg[7]  <= 32'b0;
        dataReg[8]  <= 32'b0;
        dataReg[9]  <= 32'b0;
        dataReg[10] <= 32'b0;
        dataReg[11] <= 32'b0;
        dataReg[12] <= 32'b0;
        dataReg[13] <= 32'b0;
        dataReg[14] <= 32'b0;
        dataReg[15] <= 32'b0;
        dataReg[16] <= 32'b0;
        dataReg[17] <= 32'b0;
        dataReg[18] <= 32'b0;
        dataReg[19] <= 32'b0;
        dataReg[20] <= 32'b0;
        dataReg[21] <= 32'b0;
        dataReg[22] <= 32'b0;
        dataReg[23] <= 32'b0;
        dataReg[24] <= 32'b0;
        dataReg[25] <= 32'b0;
        dataReg[26] <= 32'b0;
        dataReg[27] <= 32'b0;
        dataReg[28] <= 32'b0;
        dataReg[29] <= 32'b0;
        dataReg[30] <= 32'b0;
        dataReg[31] <= 32'b0;
    end
    else if(we && wR<32)
    begin
        dataReg[wR]<=wD;    
    end    
end


endmodule