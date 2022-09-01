module board(
    input  clk_i,
    input  rst_i,
    output led0_en,
    output led1_en,
    output led2_en,
    output led3_en,
    output led4_en,
    output led5_en,
    output led6_en,
    output led7_en,
    output led_ca ,
    output led_cb ,
    output led_cc ,
    output led_cd ,
    output led_ce ,
    output led_cf ,
    output led_cg ,
    output led_dp ,
    
    input  [23:0] device_sw,
    input  [4:0]  device_button,
    output [23:0] device_led
    );
    

    
    wire clk_g;
    wire locked = 1'b1;
    wire rst_n = !rst_i;
    wire busy = 1'b0;
    wire clk_display;
    wire [31:0] display_inst;
    wire [31:0] rdata_19_con;//控制led
    wire [31:0] led_data_con;//控制led
    wire [31:0] rData_con;
    wire [31:0] wData_con;
    wire wen_con;
    wire [31:0] addr_con;
    
    cpu_clk cpu_clk_u(
        .clk_out1(clk_g),
        .clk_in1(clk_i),
        .locked(locked)
    );
    
    cpu_top U_CPU(
        .clk  (clk_g),
        .rst_n  (rst_n),
        
        .rData      (rData_con),
        .addr       (addr_con),
        .wData      (wData_con),
        .wen        (wen_con),
        .display    (display_inst),

//        .test_rdata_19   (rdata_19_con)
        .rdata_19   (rdata_19_con)
    );

    Bridge U_Bridge(
        .clk        (clk_g),
        .addr       (addr_con),
        .wen        (wen_con),
        .wdata      (wData_con),
        .rdata      (rData_con),
        .device_button(device_button),
        .device_sw  (device_sw),
        .device_led (device_led),

        .led_data   (led_data_con)
    );
    
    clock_divider U_clock_divider(
        .clk        (clk_i),
        .out        (clk_led)
    );
    
    led_display_ctrl U_led_display(
        .clk_g      (clk_led),
        .rst_n      (rst_n),
        .busy       (busy),

        .led_data   (display_inst),
        
        .led0_en    (led0_en),
        .led1_en    (led1_en),
        .led2_en    (led2_en),
        .led3_en    (led3_en),
        .led4_en    (led4_en),
        .led5_en    (led5_en),
        .led6_en    (led6_en),
        .led7_en    (led7_en),
        .led_ca     (led_ca),
        .led_cb     (led_cb),
        .led_cc     (led_cc),
        .led_cd     (led_cd),
        .led_ce     (led_ce),
        .led_cf     (led_cf),
        .led_cg     (led_cg),
        .led_dp     (led_dp)
    );
    
endmodule