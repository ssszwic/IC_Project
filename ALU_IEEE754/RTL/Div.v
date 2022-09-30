module Div(
    // system signal                            
    input                       sys_clk             ,           
    input                       sys_rst_n           ,           
    // dataflow                                 
    input           [31:0]      data1_in            ,           
    input           [31:0]      data2_in            ,           
    output  reg     [31:0]      data_out            ,           
    // control                                  
    input                       trig                ,               
    output  reg                 vld                 ,               
    // cordic unit data flow                       
    input           [22:0]      cordic_result_in    ,
    input           [1:0]       cordic_other_in     ,
    output  reg     [23:0]      cordic_data1_out    ,
    output  reg     [23:0]      cordic_data2_out    ,
    // MultiUnit control
    input                       cordic_result_vld   ,
    output  reg                 cordic_trig_out
);

localparam          IDLE    =   4'b0001,
                    PRE     =   4'b0010,
                    WAIT    =   4'b0100,
                    OVER    =   4'b1000;

reg                 [3:0]       state           ;
reg                 [3:0]       next_state      ;

reg                 [7:0]       exp1            ;
reg                 [7:0]       exp2            ;
reg                 [22:0]      dec1            ;
reg                 [22:0]      dec2            ;
reg                             sign1           ;
reg                             sign2           ;

reg     signed      [9:0]       c_exp           ;
reg                 [22:0]      c_dec           ;
reg                             c_sign          ;

///////////////////////////////////////////////////////////
// state machine
///////////////////////////////////////////////////////////
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        state   <=  IDLE; 
    end
    else begin
        state    <=  next_state; 
    end
end

always@(*) begin
    case(state)
        IDLE:   next_state  =   (trig)              ?   PRE     :   IDLE    ;
        PRE:    next_state  =   WAIT                                        ;
        WAIT:   next_state  =   (cordic_result_vld) ?   OVER    :   WAIT    ;
        OVER:   next_state  =   IDLE                                        ;
        default:next_state  =   IDLE                                        ;
    endcase
end

///////////////////////////////////////////////////////////
// step1 sparate exponent, decimal and sign
///////////////////////////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sign1   <=  1'b0    ;
        sign2   <=  1'b0    ;
        exp1    <=  8'b0    ;
        exp2    <=  8'b0    ;
        dec1    <=  23'b0   ;
        dec2    <=  23'b0   ;
    end
    else if(state == IDLE && trig) begin
        sign1   <=  data1_in[31]    ;
        sign2   <=  data2_in[31]    ;
        exp1    <=  data1_in[30:23] ;
        exp2    <=  data2_in[30:23] ;
        dec1    <=  data1_in[22:0]  ;
        dec2    <=  data2_in[22:0]  ;
    end
    else begin
        sign1   <=  sign1   ;
        sign2   <=  sign2   ;
        exp1    <=  exp1    ;
        exp2    <=  exp2    ;
        dec1    <=  dec1    ;
        dec2    <=  dec2    ;
    end
end

///////////////////////////////////////////////////////////
// step2 add hidden '1' on the decimal
///////////////////////////////////////////////////////////
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cordic_data1_out    <=  24'b0;
        cordic_data2_out    <=  24'b0;
    end
    else if(state == PRE) begin
        cordic_data1_out    <=  (exp1 == 8'd0) ? 24'b0 : {1'b1, dec1}; 
        cordic_data2_out    <=  (exp2 == 8'd0) ? 24'b0 : {1'b1, dec2}; 
    end
    else begin
        cordic_data1_out    <=  cordic_data1_out; 
        cordic_data2_out    <=  cordic_data2_out; 
    end
end

// set cordic unit start signal
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cordic_trig_out <=  1'b0; 
    end
    else if(state == PRE) begin
        cordic_trig_out <=  1'b1; 
    end
    else begin
        cordic_trig_out <=  1'b0; 
    end
end

///////////////////////////////////////////////////////////
// step3 compute exp and sign
///////////////////////////////////////////////////////////
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        c_sign  <=  1'b0;
    end
    else if(state == PRE) begin
        c_sign  <=  sign1 ^ sign2;             
    end 
    else begin
        c_sign  <=  c_sign; 
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        c_exp   <=  10'd0; 
    end
    else if(state == PRE) begin
        c_exp   <=  exp1 - exp2 + 127; 
    end
    else if(state == WAIT && cordic_result_vld) begin
        if(cordic_other_in[1]) begin
            c_exp   <=  0;
        end
        else if(cordic_other_in[0]) begin
            c_exp   <=  c_exp - 1;
        end
        else begin
            c_exp   <=  c_exp; 
        end
    end
    else begin
        c_exp   <=  c_exp; 
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        c_dec   <=  23'b0; 
    end
    else if(state == WAIT && cordic_result_vld) begin
        c_dec   <=  cordic_result_in; 
    end
    else begin
        c_dec   <=  c_dec; 
    end
end

///////////////////////////////////////////////////////////
// step4 error check up
///////////////////////////////////////////////////////////
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        data_out    <=  32'b0; 
    end
    else if(state == OVER) begin
        if((exp1 == 8'd255 && dec1 != 23'd0) || (exp2 == 8'd255 && dec2 != 23'd0)) begin
            // input1: NaN or input2: NaN
            data_out    <=  {32{1'b1}};
        end
        else if(exp1 == 8'd255 && dec1 == 23'd0) begin
            // input1: infinity
            if(exp2 == 8'd255 && dec2 == 23'd0) begin
                // input2: infinity
                data_out    <=  {32{1'b1}};
            end
            else begin
                data_out    <=  {c_sign, 8'd255, 23'd0}; 
            end
        end
        else if(exp2 == 8'd255 && dec2 == 23'd0) begin
            // input2: infinity
            data_out    <=  {c_sign, 8'd255, 23'd0}; 
        end
        else if(exp2 == 8'd0) begin
            // input2: 0
            if(exp1 == 8'd0) begin
                // inpu1: 0
                data_out    <=  {32{1'b1}};
            end
            else begin
                // inpu1: normal 
                data_out    <=  {c_sign, 8'd255, 23'd0};
            end
        end
        else begin
            // normal
            if(c_exp <= 0) begin
                data_out    <=  {c_sign, 8'd0, 23'd0};
            end
            else if(c_exp >= 255) begin
                data_out    <=  {c_sign, 8'd255, 23'd0};
            end
            else begin
                data_out    <=  {c_sign, c_exp[7:0], c_dec}; 
            end
        end
    end
end

// vld signal
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        vld <=  1'b0; 
    end
    else if(state == OVER) begin
        vld <=  1'b1;
    end
    else begin
        vld <=  1'b0; 
    end
end

endmodule

