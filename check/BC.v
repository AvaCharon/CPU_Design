module BC(
    input [31:0]a,
    input [31:0]b,
    input BrUn,
    output BrEq,
    output BrLt
);

reg BrEq_reg;
reg BrLt_reg;

assign BrEq = BrEq_reg;
assign BrLt = BrLt_reg;

always@(*)
begin
    if(a==b)
    begin
        BrEq_reg = 1;
        BrLt_reg = 0;
    end
    else if($signed(a)<$signed(b))
    begin
        BrLt_reg = 1;
        BrEq_reg = 0;
    end
    else
    begin
        BrEq_reg = 0;
        BrLt_reg = 0;
    end
end

endmodule