module MultiUnit(
    input                       sys_clk         ,
    input                       sys_rst_n       ,
    // dataflow
    input           [31:0]      data1_in        ,
    input           [31:0]      data2_in        .
    output  reg     [31:0]      data_out        ,
    // control
    input                       trig            ,
    output  reg                 vld
);

always@(*) begin
    data_out = 31'b0;
    vld = 1'b0;
end

endmodule
