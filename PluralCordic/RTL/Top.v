//! {signal: [
//!      ['input',
//!       {name: 'sys_clk', 			     wave: 'p................'},
//!       {name: 'sys_rst_n', 			wave: '01...............'},
//!       {name: 'trig', 				wave: '0..10............'},
//!       {name: 're_in[8:0]',			wave: 'x..4x............'},
//!       {name: 'im_in[8:0]', 			wave: 'x..4x............'},
//!      ],
//!       {name:	'cnt[]',			     wave: 'x.3.3333|33333...', data: '0 1 2 3 4 10 11 12 13 0'},
//!       {name: 'x_value[18:0]', 		wave: 'x...5555|55..x...', data: 'x0 y1 y2 y3 y9 y10'},
//!       {name: 'y_value[18:0]', 		wave: 'x...5555|55..x...', data: 'y0 y1 y2 y3 y9 y10'},
//!       {name: 'z_value[13:0]', 		wave: 'x...5555|55..x...', data: '0 z1 z2 z3 z9 z10'},
//!       {name: 'x_abs[17:0]',			wave: 'x..........6x....'},
//!       {name: 'ampli_km[25:0]',		wave: 'x...........6x...'},
//!      ['output',
//!       {name: 'ampli_out[8:0]',		wave: 'x............8...'},
//!       {name: 'theta_out[9:0]',		wave: 'x............8...'},
//!       {name: 'err',					wave: 'x............8...'},
//!       {name: 'vld',					wave: '0............10..'},
//!      ]
//! ]}

module Top(
    input                                   sys_clk         ,   //! system clock   
    input                                   sys_rst_n       ,   //! system reset
    // data flow
    input                       [8:0]       re_in           ,   //! real of plural 1+3+5           
    input                       [8:0]       im_in           ,   //! imaginary of plural 1+3+5
    output      reg             [8:0]       ampli_out       ,   //! amplitude of pluran 0+4+5
    output      reg             [9:0]       theta_out       ,   //! theta of pluran 0+4+5
    output      reg                         err             ,   //! calculate error when re_in=0 & im_in=0
    // control
    input                                   trig            ,   //! trig of input
    output      reg                         vld                 //! valid of output
);

reg                     [3:0]       cnt         ;

reg         signed      [18:0]      x_value     ;
reg         signed      [18:0]      y_value     ;
reg         signed      [13:0]      z_value     ;

reg         signed      [18:0]      tmp1        ;
reg         signed      [18:0]      tmp2        ;
reg                     [11:0]      z_add       ;

reg                     [17:0]      x_abs       ;
reg                     [25:0]      ampli_km    ;
wire                    [9:0]       ampli_round ;

wire                    [10:0]      theta_round ;


// cnt
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cnt <=  4'b0; 
    end
    else if(cnt == 4'd0 && trig) begin
        cnt <=  4'd1;
    end
    else if(cnt == 4'd13 || cnt == 4'd0) begin
        cnt <=  4'd0;
    end
    else begin
        cnt <=  cnt + 1; 
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        x_value <=  19'b0; 
        y_value <=  19'b0; 
        z_value <=  14'b0; 
    end
    else if(cnt == 4'd0 && trig) begin
        // initial when trig
        x_value <=  {{2{re_in[8]}}, re_in, 8'd0};
        y_value <=  {{2{im_in[8]}}, im_in, 8'd0};
        z_value <=  14'd0;
    end
    else begin
        // iteration
        if(x_value[18] ^ y_value[18]) begin
            x_value <=  x_value - tmp2;
            y_value <=  y_value + tmp1;
            z_value <=  z_value - z_add;
        end
        else begin
            x_value <=  x_value + tmp2;
            y_value <=  y_value - tmp1;
            z_value <=  z_value + z_add;
        end 
    end
end

always@(*) begin
    case (cnt)
        4'd1: begin
            tmp1    =   x_value >>> 0;
            tmp2    =   y_value >>> 0;
            z_add   =   2048;
        end
        4'd2: begin
            tmp1    =   x_value >>> 1;
            tmp2    =   y_value >>> 1;
            z_add   =   1209;
        end
        4'd3: begin
            tmp1    =   x_value >>> 2;
            tmp2    =   y_value >>> 2;
            z_add   =   639;
        end
        4'd4: begin
            tmp1    =   x_value >>> 3;
            tmp2    =   y_value >>> 3;
            z_add   =   324;
        end
        4'd5: begin
            tmp1    =   x_value >>> 4;
            tmp2    =   y_value >>> 4;
            z_add   =   163;
        end
        4'd6: begin
            tmp1    =   x_value >>> 5;
            tmp2    =   y_value >>> 5;
            z_add   =   81;
        end
        4'd7: begin
            tmp1    =   x_value >>> 6;
            tmp2    =   y_value >>> 6;
            z_add   =   41;
        end
        4'd8: begin
            tmp1    =   x_value >>> 7;
            tmp2    =   y_value >>> 7;
            z_add   =   20;
        end
        4'd9: begin
            tmp1    =   x_value >>> 8;
            tmp2    =   y_value >>> 8;
            z_add   =   10;
        end
        4'd10: begin
            tmp1    =   x_value >>> 9;
            tmp2    =   y_value >>> 9;
            z_add   =   5;
        end
        default: begin
            tmp1    =   19'd0;
            tmp2    =   19'd0;
            z_add   =   0;
        end
    endcase
end

// x_abs
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        x_abs   <=  18'b0; 
    end
    else begin
        if(x_value[18]) begin
            x_abs   <=  -x_value;
        end
        else begin
            x_abs   =   x_value; 
        end 
    end
end

// x_abs * km
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        ampli_km    <=  26'b0; 
    end
    else begin
        ampli_km    <=  x_abs * 311; 
    end 
end

// round
assign ampli_round  =   ampli_km[25:16] + 1;
assign theta_round  =   z_value[13:3] + 1;

// output
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        ampli_out   <=  9'b0;
        theta_out   <=  10'b0;
        err         <=  1'b0;
    end
    else if(cnt == 4'd13) begin
        ampli_out   <=  ampli_round[9:1];
        theta_out   <=  theta_round[10:1];
        err         <=  (x_value == 19'd0 && y_value == 19'd0) ? 1'b1 : 1'b0;
    end else begin
        ampli_out   <=  ampli_out;
        theta_out   <=  theta_out;
        err         <=  err;
    end
end

// vld
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        vld <=  1'b0;
    end
    else if(cnt == 4'd13) begin
        vld <=  1'b1;
    end
    else begin
        vld <=  1'b0; 
    end
end

endmodule
