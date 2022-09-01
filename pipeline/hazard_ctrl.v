module hazard_ctrl(
    input   [4:0] wR_EX,
    input   [4:0] wR_MEM,
    input   [4:0] wR_WB,
    input   rf_we_EX,
    input   rf_we_MEM,
    input   rf_we_WB,
    input   [4:0] rR1_ID,
    input   [4:0] rR2_ID,
    input   rR1_use,
    input   rR2_use,
    input   [31:0] pc4_EX,
    input   [31:0] c_EX,
    input   [31:0] wD_MEM,
    input   [31:0] wD_WB,
    input   [1:0] WBsel_EX,
    input   npc_op_EX,

    //forward
    output  reg [31:0] rD1_fw,
    output  reg [31:0] rD2_fw,
    output  rD1_fw_op,
    output  rD2_fw_op,
    //stall
    output  reg stall_PC,
    output  reg stall_IF_ID,
    //flush
    output  reg flush_IF_ID,
    output  reg flush_ID_EX
);


//wb_hazard
wire [31:0] wD_EX = (WBsel_EX==0)?pc4_EX:c_EX;
wire r1_wb_hazard_EX,r1_wb_hazard_MEM,r1_wb_hazard_WB;
wire r2_wb_hazard_EX,r2_wb_hazard_MEM,r2_wb_hazard_WB;

assign rD1_fw_op=((r1_wb_hazard_EX&(WBsel_EX!=1))|r1_wb_hazard_MEM|r1_wb_hazard_WB);
assign rD2_fw_op=((r2_wb_hazard_EX&(WBsel_EX!=1))|r2_wb_hazard_MEM|r2_wb_hazard_WB);

assign r1_wb_hazard_EX = ((wR_EX==rR1_ID)&rf_we_EX&rR1_use&(wR_EX!=5'b0));
assign r1_wb_hazard_MEM= ((wR_MEM==rR1_ID)&rf_we_MEM&rR1_use&(wR_MEM!=5'b0));
assign r1_wb_hazard_WB = ((wR_WB==rR1_ID)&rf_we_WB&rR1_use&(wR_WB!=5'b0));

assign r2_wb_hazard_EX = ((wR_EX==rR2_ID)&rf_we_EX&rR2_use&(wR_EX!=5'b0));
assign r2_wb_hazard_MEM= ((wR_MEM==rR2_ID)&rf_we_MEM&rR2_use&(wR_MEM!=5'b0));
assign r2_wb_hazard_WB = ((wR_WB==rR2_ID)&rf_we_WB&rR2_use&(wR_WB!=5'b0));

// always@(*)
// begin
//     if((wR_EX==rR1_ID)&&rf_we_EX)   r1_wb_hazard_EX=1;
//     else if((wR_MEM==rR1_ID)&&rf_we_MEM)   r1_wb_hazard_MEM=1;
//     else if((wR_WB==rR1_ID)&&rf_we_WB)   r1_wb_hazard_WB=1;
//     else
//     begin
//         r1_wb_hazard_EX=0;
//         r1_wb_hazard_MEM=0;
//         r1_wb_hazard_WB=0;
//     end
// end

// always@(*)
// begin
//     if((wR_EX==rR2_ID)&&rf_we_EX)   r2_wb_hazard_EX=1;
//     else if((wR_MEM==rR2_ID)&&rf_we_MEM)   r2_wb_hazard_MEM=1;
//     else if((wR_WB==rR2_ID)&&rf_we_WB)   r2_wb_hazard_WB=1;
//     else
//     begin
//         r2_wb_hazard_EX=0;
//         r2_wb_hazard_MEM=0;
//         r2_wb_hazard_WB=0;
//     end
// end

always@(*)
begin
    if(r1_wb_hazard_EX) rD1_fw=wD_EX;
    else if(r1_wb_hazard_MEM) rD1_fw=wD_MEM;
    else if(r1_wb_hazard_WB) rD1_fw=wD_WB;
    else    rD1_fw=0;
end

always@(*)
begin
    if(r2_wb_hazard_EX) rD2_fw=wD_EX;
    else if(r2_wb_hazard_MEM) rD2_fw=wD_MEM;
    else if(r2_wb_hazard_WB) rD2_fw=wD_WB;
    else    rD2_fw=0;
end

//load_hazard
wire load_hazard = ((r1_wb_hazard_EX | r2_wb_hazard_EX)&(WBsel_EX==1));

always@(*)
begin
    if(load_hazard) stall_PC=1;
    else    stall_PC=0;
end

always@(*)
begin
    if(load_hazard) stall_IF_ID=1;
    else    stall_IF_ID=0;
end

//control_hazard
wire ctrl_hazard = npc_op_EX;

always@(*)
begin
    if(ctrl_hazard) flush_IF_ID=1;
    else    flush_IF_ID=0;
end

always@(*)
begin
    if(ctrl_hazard) flush_ID_EX=1;
    else if(load_hazard)    flush_ID_EX=1;
    else    flush_ID_EX=0;
end

endmodule