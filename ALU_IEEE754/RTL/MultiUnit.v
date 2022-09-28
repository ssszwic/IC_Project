module MultiUnit(
    input                       sys_clk         ,
    input                       sys_rst_n       ,
    // dataflow
    input           [31:0]      data1_in        ,
    input           [31:0]      data2_in        ,
    output  reg     [31:0]      data_out        ,
    // control
    input                       trig            ,
    output  reg                 vld
);

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        data_out <= 0;
        vld <= 0;
    end
    else begin
        data_out <= 0;
        vld <= 0;
    end
end






endmodule
