//! {signal: [
//!     ['input',
//!     {name: 'sys_clk',           wave: 'p..............'},
//!     {name: 'sys_rst_n',         wave: '01.............'},
//!     {name: 'trig',              wave: '0..10..........'},
//!     {name: 'data_in[9:0]',      wave: 'xxx5x..........'},
//!     ],
//!     {name:  'cnt[4:0]',         wave: 'x...3333|333...', data: '1 2 3 4 18 19 0'},
//!     {name: 'quadrand[1:0]',     wave: 'x...4......x...'},
//!     {name: 'x_value[21:0]',     wave: 'x...5555|55x...', data: 'km x1 x2 x3 x17 x18'},
//!     {name: 'y_value[21:0]',     wave: 'x...5555|55x...', data: '0 y1 y2 y3 y17 y18'},
//!     {name: 'z_value[22:0]',     wave: 'x...5555|55x...', data: 'theta z1 z2 z3 z17 z18'},
//!     ['output',
//!     {name: 'sin[12:0]',         wave: 'x..........8...', data: 'y18~'},
//!     {name: 'cos[12:0]',         wave: 'x..........8...', data: 'x18~'},
//!     {name: 'vld',               wave: 'x..........10..', data: 'x18~'},
//!     ]
//! ]}
module Top(
    input                           sys_clk     ,   //! clock
    input                           sys_rst_n   ,   //! system reset_n
    // control
    input                           trig        ,   //! input signal
    output  reg                     vld         ,   //! output result valid signal
    // data flow
    input                   [9:0]   data_in     ,   //! radian value: [0, 1024) as [0, 2*pi)
    output  reg     signed  [12:0]  sin_out     ,   //! sin result 1+1+11 = 13bit
    output  reg     signed  [12:0]  cos_out         //! sin result 1+1+11 = 13bit
);

reg                 [4:0]       cnt         ;
reg                 [1:0]       quadrand    ;
reg     signed      [21:0]      x_value     ;
reg     signed      [21:0]      y_value     ;
reg     signed      [22:0]      z_value     ;

// comb val
reg     signed      [21:0]      tmp1        ;
reg     signed      [21:0]      tmp2        ;
reg     signed      [22:0]      z_add       ;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cnt <=  5'b0; 
    end
    else if(cnt == 5'd0 && trig) begin
        cnt <=  5'd1;
    end
    else if(cnt == 5'd0 || cnt == 5'd19) begin
        cnt <=  5'd0;
    end
    else begin
        cnt <=  cnt + 1; 
    end
end

///////////////////////////////////////////////////////////
// step1: limit theta range [0, pi/2]
///////////////////////////////////////////////////////////
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        quadrand    <=  2'd0;
    end
    else if(cnt == 5'd0 && trig) begin
        if(data_in > 10'd768) begin
            quadrand    <=  2'd3;
        end
        else if(data_in > 10'd512) begin
            quadrand    <=  2'd2;
        end
        else if(data_in > 256) begin
            quadrand    <=  2'd1;
        end
        else begin
            quadrand    <=  2'd0;
        end
    end
    else begin
        quadrand    <=  quadrand; 
    end
end

///////////////////////////////////////////////////////////
// step2: itration
///////////////////////////////////////////////////////////
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        x_value     <=  22'b0;
        y_value     <=  22'b0;
        z_value     <=  23'b0; 
    end
    else if(cnt == 5'd0 && trig) begin
        // initial
        // x
        x_value     <=  22'd636751;
        // y
        y_value     <=  22'd0;
        // z    
        if(data_in > 10'd768) begin
            z_value[22]     <=  1'b0;
            z_value[21:12]  <=  1024 - data_in;
            z_value[11:0]   <=  12'd0;
        end
        else if(data_in > 10'd512) begin
            z_value[22]     <=  1'b0;
            z_value[21:12]  <=  data_in - 512;
            z_value[11:0]   <=  12'd0;
        end
        else if(data_in > 256) begin
            z_value[22]     <=  1'b0;
            z_value[21:12]  <=  512 - data_in;
            z_value[11:0]   <=  12'd0;
        end
        else begin
            z_value[22]     <=  1'b0;
            z_value[21:12]  <=  data_in;
            z_value[11:0]   <=  12'd0;
        end
    end
    else begin
        if(z_value[22]) begin
            // z < 0
            x_value     <=  x_value + tmp2;
            y_value     <=  y_value - tmp1;
            z_value     <=  z_value + z_add;
        end
        else begin
            // z >= 0
            x_value     <=  x_value - tmp2;
            y_value     <=  y_value + tmp1;
            z_value     <=  z_value - z_add;
        end
    end
end

// look up table
always@(*) begin
    case(cnt)
        5'd1:   z_add   =   524288  ;
        5'd2:   z_add   =   309505  ;
        5'd3:   z_add   =   163534  ;
        5'd4:   z_add   =   83012   ;
        5'd5:   z_add   =   41667   ;
        5'd6:   z_add   =   20854   ;
        5'd7:   z_add   =   10430   ;
        5'd8:   z_add   =   5215    ;
        5'd9:   z_add   =   2608    ;
        5'd10:  z_add   =   1304    ;
        5'd11:  z_add   =   652     ;
        5'd12:  z_add   =   326     ;
        5'd13:  z_add   =   163     ;
        5'd14:  z_add   =   81      ;
        5'd15:  z_add   =   41      ;
        5'd16:  z_add   =   20      ;
        5'd17:  z_add   =   10      ;
        5'd18:  z_add   =   5       ;
        default:z_add   =   0       ;
    endcase
end

// shift bit
always@(*) begin
    case(cnt)
        5'd1: begin
            tmp1    =   x_value;
            tmp2    =   y_value;
        end 
        5'd2: begin
            tmp1    =   x_value >>> 1;
            tmp2    =   y_value >>> 1;
        end
        5'd3: begin
            tmp1    =   x_value >>> 2;
            tmp2    =   y_value >>> 2;
        end
        5'd4: begin
            tmp1    =   x_value >>> 3;
            tmp2    =   y_value >>> 3;
        end
        5'd5: begin
            tmp1    =   x_value >>> 4;
            tmp2    =   y_value >>> 4;
        end
        5'd6: begin
            tmp1    =   x_value >>> 5;
            tmp2    =   y_value >>> 5;
        end
        5'd7: begin
            tmp1    =   x_value >>> 6;
            tmp2    =   y_value >>> 6;
        end
        5'd8: begin
            tmp1    =   x_value >>> 7;
            tmp2    =   y_value >>> 7;
        end
        5'd9: begin
            tmp1    =   x_value >>> 8;
            tmp2    =   y_value >>> 8;
        end
        5'd10: begin
            tmp1    =   x_value >>> 9;
            tmp2    =   y_value >>> 9;
        end
        5'd11: begin
            tmp1    =   x_value >>> 10;
            tmp2    =   y_value >>> 10;
        end
        5'd12: begin
            tmp1    =   x_value >>> 11;
            tmp2    =   y_value >>> 11;
        end
        5'd13: begin
            tmp1    =   x_value >>> 12;
            tmp2    =   y_value >>> 12;
        end
        5'd14: begin
            tmp1    =   x_value >>> 13;
            tmp2    =   y_value >>> 13;
        end
        5'd15: begin
            tmp1    =   x_value >>> 14;
            tmp2    =   y_value >>> 14;
        end
        5'd16: begin
            tmp1    =   x_value >>> 15;
            tmp2    =   y_value >>> 15;
        end
        5'd17: begin
            tmp1    =   x_value >>> 16;
            tmp2    =   y_value >>> 16;
        end
        5'd18: begin
            tmp1    =   x_value >>> 17;
            tmp2    =   y_value >>> 17;
        end
        default: begin
            tmp1    =   22'b0; 
            tmp2    =   22'b0; 
        end
    endcase
end

///////////////////////////////////////////////////////////
// step3: deduction quadrant 
///////////////////////////////////////////////////////////
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin_out <=  13'b0; 
        cos_out <=  13'b0; 
    end
    else if(cnt == 5'd19) begin
        case(quadrand) 
            2'd3: begin
                sin_out <=  -y_value[21:9];
                cos_out <=   x_value[21:9];
            end   
            2'd2: begin
                sin_out <=  -y_value[21:9];
                cos_out <=  -x_value[21:9];
            end
            2'd1: begin
                sin_out <=   y_value[21:9];
                cos_out <=  -x_value[21:9];
            end
            2'd0: begin
                sin_out <=   y_value[21:9];
                cos_out <=   x_value[21:9];
            end
            default: begin
                sin_out <=   13'd0;
                cos_out <=   13'd0;
            end
        endcase
    end
    else begin
        sin_out <=  sin_out;
        cos_out <=  cos_out;
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        vld <=  1'b0; 
    end
    else if(cnt == 5'd19) begin
        vld <=  1'b1;
    end
    else begin
        vld <=  1'b0; 
    end
end


endmodule
