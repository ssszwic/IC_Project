module Ctrl(
    // system signal
    input                   sys_clk         ,
    input                   sys_rst_n       ,
    // dataflow
    input           [31:0]  data1_in        ,   // input data1
    input           [31:0]  data2_in        ,   // input data2
    input           [31:0]  plus_result_in  ,   // the calculate result from Plus module
    input           [31:0]  multi_result_in ,   // the calculate result from Multi module
    input           [31:0]  div_result_in   ,   // the calculate result from Div module
    output  reg     [31:0]  data1_out       ,   // the input data calaulate module require
    output  reg     [31:0]  data2_out       ,   // the input data calaulate module require
    output  reg     [31:0]  result_out      ,   // final result
    // control
    input           [1:0]   opcode          ,   // 00:+  01:-  10:*  11:/
    input                   trig            ,
    input                   plus_vld_in     ,   // the calsulate result is vilid
    input                   multi_vld_in    ,
    input                   div_vld_in      ,
    output  reg             multi_unit_sel  ,   // decide who use mulitplication unit (multi or div) 0:multi  1:div
    output  reg             sel_plus        ,   // decide which module works
    output  reg             sel_multi       ,   
    output  reg             sel_div         ,
    output  reg             op_plus         ,   // Plus module opcode
    output  reg             work            ,   //  work status. When work is '1', module doesn't acciept external data.
    output  reg             result_vld          // final result vld
);

// state machine
localparam          IDLE    =   4'b0001,
                    PLUS    =   4'b0010,
                    MULTI   =   4'b0100,
                    DIV     =   4'b1000;

reg             [3:0]       next_state;
reg             [3:0]       state;

////////////////////////////////////////////////////////////
// Define state machine
////////////////////////////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        state   <=  4'b0;
    end
    else begin
        state   <=  next_state;
    end
end

always@(*) begin
    case(state)
        IDLE: begin
            if(trig) begin
                case(opcode)
                    2'b00:  next_state  =   PLUS;
                    2'b01:  next_state  =   PLUS;
                    2'b10:  next_state  =   MULTI;
                    2'b11:  next_state  =   DIV;
                    default:next_state  =   IDLE;       
                endcase
            end
            else begin
                next_state  =   IDLE;
            end
        end
        PLUS:   next_state  =   (plus_vld_in)   ?   IDLE    :   PLUS;  
        MULTI:  next_state  =   (multi_vld_in)  ?   IDLE    :   MULTI;  
        DIV:    next_state  =   (div_vld_in)    ?   IDLE    :   DIV;
        default:next_state  =   IDLE;
    endcase
end

////////////////////////////////////////////////////////////
// Output signal of calculate moduele
////////////////////////////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sel_plus    <=  1'b0;
        sel_multi   <=  1'b0;
        sel_div     <=  1'b0;
        op_plus     <=  1'b0;
        data1_out   <=  32'b0;
        data2_out   <=  32'b0;
    end
    else if(state == IDLE && trig) begin
        data1_out   <=  data1_in;
        data2_out   <=  data2_in;
        op_plus     <=  opcode[0];
        
        case(opcode)
            2'b00:  {sel_plus, sel_multi, sel_div}  <=  3'b100;
            2'b01:  {sel_plus, sel_multi, sel_div}  <=  3'b100;
            2'b10:  {sel_plus, sel_multi, sel_div}  <=  3'b010;
            2'b11:  {sel_plus, sel_multi, sel_div}  <=  3'b001;
            default:{sel_plus, sel_multi, sel_div}  <=  3'b000;
        endcase
    end
    else begin
        sel_plus    <=  1'b0;
        sel_multi   <=  1'b0;
        sel_div     <=  1'b0;
        op_plus     <=  1'b0;
        data1_out   <=  32'b0;
        data2_out   <=  32'b0;
    end
end

////////////////////////////////////////////////////////////
// Read calculate result from calculate module.
////////////////////////////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        result_out  <=  32'b0;      
    end
    else begin
        if(state != IDLE) begin
            if(plus_vld_in) begin
                result_out  <=  plus_result_in; 
            end
            else if(multi_vld_in) begin
                result_out  <=  multi_result_in;
            end
            else if(div_vld_in) begin
                result_out  <=  div_result_in;
            end
            else begin
                result_out  <=  result_out;
            end
        end
        else begin
            result_out  <=  result_out;
        end
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        result_vld  <=  1'b0;       
    end
    else if(state != IDLE) begin
        result_vld  <=  plus_vld_in | multi_vld_in | div_vld_in;
    end
    else begin
        result_vld  <=  1'b0;
    end
end

////////////////////////////////////////////////////////////
// 'work' and 'multi_unit_sel'
////////////////////////////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        work            <=  1'b0;
        multi_unit_sel  <=  1'b0;
    end
    else if(state == IDLE && trig) begin
        work            <=  1'b1;
        multi_unit_sel  <=  opcode[0];
    end
    else if(state != IDLE && (plus_vld_in | multi_vld_in | div_vld_in)) begin
        work            <=  1'b0;
        multi_unit_sel  <=  1'b0;
    end
    else begin
        work            <=  work;
        multi_unit_sel  <=  multi_unit_sel;
    end
end

endmodule
