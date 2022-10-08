//! {signal: [
//!      ['input',
//!       {name: 'sys_clk', 			wave: 'p......................'},
//!       {name: 'sys_rst_n', 			wave: '01.....................'},
//!       {name: 'len[31:0]', 			wave: 'x..4x..................'},
//!       {name: 'trig', 				wave: '0..10..................'},
//!       {name: 'a',					wave: 'x..4444444|44x.........', data: 'a0 a1 a2 a3 a4 a5 a6 len-2 len-1'},
//!      ],
//!       {name: 'cnt_max[32:0]',		wave: 'x...5................x.', data: 'l+32'},
//!       {name: 'cnt[32:0]',			wave: 'x.5.555555|4444444|444.', data: '0 1 2 3 4 5 6 l-2 l-1 l l+1 l+2 l+3 l+4 l+30 l+31 0'},
//!       {name: 'fb',					wave: 'x5.5.........5.........', data: '0 a^a_r31 0'},
//!       {name: 'a_r[31:0]',			wave: '5...5.........5......5.', data: '0xffffffff plus shift 0xffffffff'},
//!      ['output',
//!       {name: 'b',					wave: 'x...8.........8888|888x', data: 'data C31 C30 C29 C28 C2 C1 C0'},
//!       {name: 'vld',					wave: '0...1.................0'},
//!      ]
//! ]}
module Top(
    input                                   sys_clk         ,
    input                                   sys_rst_n       ,
    input                   [31:0]          len             ,   //! length of data
    input                                   trig            ,
    input                                   a               ,   //! valid data
    output      reg                         b               ,   //! data include CRC
    output      reg                         vld
);

reg         [32:0]      len_r       ;
reg         [32:0]      cnt         ;
reg         [31:0]      a_r         ;
reg                     fb          ;

// cnt
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cnt <=  33'b0; 
    end
    else if(trig) begin
        cnt <=  33'd1;
    end
    else if(cnt == (len_r + 33'd31)) begin
        cnt <=  33'd0;
    end
    else begin
        cnt <=  cnt + 1; 
    end
end

// len_r
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        len_r <=  33'b0; 
    end
    else if(trig) begin
        len_r <=  len;
    end
    else begin
        len_r <=  len_r; 
    end
end

// fb
always@(*) begin
    if(trig || (cnt > 33'd0 && cnt < len_r)) begin
        fb  =   a ^ a_r[31]; 
    end
    else begin
        fb  =   0;
    end
end

// a_r
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        a_r <=  32'hffff_ffff; 
    end
    else if(trig || cnt < (len_r + 33'd31)) begin
        a_r[0]  <=  fb          ;
        a_r[1]  <=  a_r[0] ^ fb ;
        a_r[2]  <=  a_r[1] ^ fb ;
        a_r[3]  <=  a_r[2]      ;
        a_r[4]  <=  a_r[3] ^ fb ;
        a_r[5]  <=  a_r[4] ^ fb ;
        a_r[6]  <=  a_r[5]      ;
        a_r[7]  <=  a_r[6] ^ fb ;
        a_r[8]  <=  a_r[7] ^ fb ;
        a_r[9]  <=  a_r[8]      ;
        a_r[10] <=  a_r[9] ^ fb ;
        a_r[11] <=  a_r[10] ^ fb;
        a_r[12] <=  a_r[11] ^ fb;
        a_r[13] <=  a_r[12]     ;
        a_r[14] <=  a_r[13]     ;
        a_r[15] <=  a_r[14]     ;
        a_r[16] <=  a_r[15] ^ fb;
        a_r[17] <=  a_r[16]     ;
        a_r[18] <=  a_r[17]     ;
        a_r[19] <=  a_r[18]     ;
        a_r[20] <=  a_r[19]     ;
        a_r[21] <=  a_r[20]     ;
        a_r[22] <=  a_r[21] ^ fb;
        a_r[23] <=  a_r[22] ^ fb;
        a_r[24] <=  a_r[23]     ;
        a_r[25] <=  a_r[24]     ;
        a_r[26] <=  a_r[25] ^ fb;
        a_r[27] <=  a_r[26]     ;
        a_r[28] <=  a_r[27]     ;
        a_r[29] <=  a_r[28]     ;
        a_r[30] <=  a_r[29]     ;
        a_r[31] <=  a_r[30]     ;
    end
    else begin
        a_r <=  32'hffff_ffff; 
    end
end

// vld
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        vld <=  1'b0; 
    end
    else if(trig || cnt > 33'd0) begin
        vld <=  1'b1;
    end
    else begin
        vld <=  1'b0; 
    end
end

// output b
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        b   <=  1'b0; 
    end
    else if(trig || (cnt > 33'd0 && cnt < len_r)) begin
        b   <=  a;
    end
    else if(cnt >= len_r) begin
        b   <=  ~a_r[31];
    end
    else begin
        b   <=  1'b0; 
    end
end

endmodule
