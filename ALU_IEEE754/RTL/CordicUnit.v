module CordicUnit(
    // system signal
    input                                   sys_clk         ,
    input                                   sys_rst_n       ,
    // data flow
    input                       [23:0]      mul_data1_in    ,
    input                       [23:0]      mul_data2_in    ,
    input                       [23:0]      div_data1_in    ,
    input                       [23:0]      div_data2_in    ,
    output      reg             [22:0]      data_out        , 
    output      reg             [1:0]       data_other      ,   // data_other[0]: exp_flag   data_other[1]: zero_flag
    // control
    input                                   mul_trig        , 
    input                                   div_trig        , 
    output      reg                         vld             
);

reg                 [4:0]       cnt     ;
reg                             op      ;

reg                 [47:0]      x_data  ;
reg     signed      [49:0]      y_data  ;
reg     signed      [25:0]      z_data  ;

reg                 [24:0]      tmp     ;
wire                [48:0]      res     ;


always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cnt <=  5'd0; 
    end
    else if(cnt == 5'd0 && (mul_trig || div_trig)) begin
        cnt <=  5'd1; 
    end
    else if(cnt == 5'd0 || cnt == 5'd26) begin
        cnt <=  5'd0; 
    end
    else begin
        cnt <=  cnt + 1; 
    end
end

///////////////////////////////////////////////////////////
// step1. Cordic iterative compute
///////////////////////////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        op      <=  1'b0;
        tmp     <=  25'b0;
        x_data  <=  48'b0;
        y_data  <=  50'b0;
        z_data  <=  26'b0;
    end
    else if(cnt == 5'd0 && (mul_trig || div_trig)) begin
        op      <=  div_trig;
        tmp     <=  {1'd1, 24'd0};
        x_data  <=  (mul_trig) ?    {mul_data1_in, 24'd0}       :   {div_data2_in, 24'd0}; 
        y_data  <=  (mul_trig) ?    50'd0                       :   {2'd0, div_data1_in, 24'd0};
        z_data  <=  (mul_trig) ?    {1'd0, mul_data2_in, 1'd0}  :   26'd0; 
    end
    else begin
        op      <=  op;
        tmp     <=  {1'b0, tmp[24:1]};
        x_data  <=  {1'b0, x_data[47:1]};   
        if( ((~op) & z_data[25]) || (op & (~y_data[49])) ) begin
            y_data  <=  y_data - x_data;
            z_data  <=  z_data + tmp;
        end
        else begin
            y_data  <=  y_data + x_data;
            z_data  <=  z_data - tmp;
        end
    end
end

///////////////////////////////////////////////////////////
// step2. truncation
///////////////////////////////////////////////////////////

assign res = (op) ? {z_data[24:0],24'd0} : y_data[48:0];

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        data_out    <=  23'd0;
        data_other  <=  2'd0;
    end
    else if(cnt == 5'd26) begin
        if(res[48]) begin
            data_out    <=  res[47:25];
            data_other  <=  (op)? 2'b00 : 2'b01;
        end 
        else if(res[47]) begin
            data_out    <=  res[46:24];
            data_other  <=  (op)? 2'b01 : 2'b00;
        end
        else begin
            data_out    <=  23'd0;
            data_other  <=  2'b10;
        end
    end
    else begin
        data_out    <=  data_out;
        data_other  <=  data_other;
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        vld <=  1'b0;
    end
    else if(cnt == 5'd26) begin
        vld <=  1'b1;
    end
    else begin
        vld <=  1'b0; 
    end
end

endmodule
