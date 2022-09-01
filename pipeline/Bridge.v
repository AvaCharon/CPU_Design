module Bridge(
    input wire clk,
    input wire[31:0] addr,
    input wire wen,
    input wire [31:0] wdata,
    output reg [31:0] rdata,

    input  [23:0] device_sw,
    input  [4:0]  device_button,
    output reg [23:0] device_led,

    output  [31:0] led_data
);

wire dram_clk;
reg dram_we;
reg [1:0]sel_reg;
wire [31:0] dram_addr;
wire [31:0] dram_rd;

reg [31:0] led_data_reg;
assign led_data = led_data_reg;

assign dram_clk = ~clk;
assign dram_addr = addr - 16'h4000;

// always@(*)
// begin
//     rdata <= dram_rd;
//     dram_we <= wen;
// end

//数码管控制
always@(negedge clk)
begin
    if(addr == 32'hFFFFF000)
    begin
//        led_data <= {8'b0, device_sw[23:0]};
        led_data_reg <= wdata;
    end
end

//写外存
always @(*) 
begin
    if(addr == 32'hFFFFF000) 
    begin
        dram_we <= 1'b0;
    end
    else if(addr == 32'hFFFFF060) 
    begin
        dram_we <= 1'b0;
    end
    else if(addr == 32'hFFFFF062)
    begin
        dram_we <= 1'b0;
    end
    else 
    begin
        dram_we <= wen;
    end
end

//led灯
always @(*) 
begin
    device_led <= {device_sw[23:0]};
end

// always @(*) 
// begin
//     if(addr == 32'hFFFFF060 && wen) 
//     begin
//         device_led = {device_led[23:16], wdata[15:0]};
//     end
//     else if(addr == 32'hFFFFF062 && wen) 
//     begin
//         device_led = {wdata[7:0], device_led[15:0]};
//     end
//     else 
//     begin
//         device_led = device_led;
//     end
// end

//读
always @(*) 
begin
    if(addr == 32'hFFFFF070) 
    begin
        rdata <= {8'b0, device_sw[23:0]};
    end
    else 
    begin
        rdata <= dram_rd;
    end
end



dram dramImpl(
    .a(dram_addr[15:2]),
    .d(wdata),
    .clk(dram_clk),
    .we(dram_we),
    .spo(dram_rd)
); 

endmodule