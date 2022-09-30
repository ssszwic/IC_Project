module Plus(
    // system signal
    input                   sys_clk,
    input                   sys_rst_n,
    // dataflow
    input           [31:0]  data1_in,
    input           [31:0]  data2_in,
    output  reg     [31:0]  data_out,
    // control
    input                   op,
    input                   trig,
    output  reg             vld
);

reg             [3:0]       cnt             ;
reg                         op_reg          ;
reg                         sign1           ;
reg                         sign2           ;
reg             [7:0]       exp1            ;
reg             [7:0]       exp2            ;
reg             [22:0]      dec1            ;
reg             [22:0]      dec2            ;
reg             [23:0]      dec1_1          ;
reg             [23:0]      dec2_1          ;
reg             [7:0]       shift_bit       ;
reg             [7:0]       exp_both        ;

reg             [8:0]       shift_bit_comb  ;
reg                         shift_flag      ;   // 1:exp1 < exp2; 0:exp1 > exp2

wire            [23:0]      pre_dec         ;
reg             [26:0]      dec1_2          ;
reg             [26:0]      dec2_2          ;
reg             [25:0]      dec_tmp         ;
reg                         protect         ;

reg     signed  [27:0]      dec1_3          ;
reg     signed  [27:0]      dec2_3          ;

reg     signed  [28:0]      sum             ;
reg             [27:0]      sum_abs         ;

reg                         c_sign          ;
reg     signed  [8:0]       c_exp           ;
reg             [22:0]      c_dec           ;



always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        cnt <= 3'b0;
    end
    else if(cnt == 3'd0 && trig) begin
        cnt <= 3'd1;
    end
    else if(cnt == 3'd0 || cnt == 3'd7) begin
        cnt <= 3'd0;
    end
    else begin
        cnt <= cnt + 1;
    end
end

//////////////////////////////////////////////////////////////////
// step1: Separate exponent, decimal and sign
//////////////////////////////////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        op_reg <= 1'b0;
    end
    else if(cnt == 3'd0 && trig) begin
        op_reg <= op; 
    end
    else begin
        op_reg <= op_reg;
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sign1   <=  1'b0;
        sign2   <=  1'b0;
        exp1    <=  8'b0;
        exp2    <=  8'b0;
        dec1    <=  23'b0;  
        dec2    <=  23'b0;
    end
    else if(cnt == 3'd0 && trig) begin
        sign1   <=  data1_in[31];
        sign2   <=  data2_in[31];
        exp1    <=  data1_in[30:23];
        exp2    <=  data2_in[30:23];
        dec1    <=  data1_in[22:0];
        dec2    <=  data2_in[22:0];
    end
    else begin
        sign1   <=  sign1;
        sign2   <=  sign2;
        exp1    <=  exp1;
        exp2    <=  exp2;
        dec1    <=  dec1;
        dec2    <=  dec2;
    end
end

//////////////////////////////////////////////////////////////////
// step2: add the hidden '1'
//////////////////////////////////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        dec1_1 <= 24'b0;
        dec2_1 <= 24'b0;
    end
    else if(cnt == 3'd1) begin
        dec1_1 <= (exp1 == 8'd0) ? 24'd0 : {1'b1, dec1};
        dec2_1 <= (exp2 == 8'd0) ? 24'd0 : {1'b1, dec2};
    end
    else begin
        dec1_1 <= dec1_1;
        dec2_1 <= dec2_1;
    end
end

//////////////////////////////////////////////////////////////////
// step3: solve shift bit
//////////////////////////////////////////////////////////////////

assign shift_bit_comb = {1'b0, exp1} - {1'b0, exp2};

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        shift_bit   <= 8'b0;
        shift_flag  <= 1'b0; 
        exp_both    <= 8'b0;
    end
    else begin
        shift_flag <= shift_bit_comb[8];
        if(shift_bit_comb[8]) begin
            shift_bit   <=  ~shift_bit_comb + 1;
            exp_both    <=  exp2;
        end
        else begin
            shift_bit   <=  shift_bit_comb;
            exp_both    <=  exp1;
        end
    end
end

//////////////////////////////////////////////////////////////////
// step4: align decimal poins
//////////////////////////////////////////////////////////////////

assign pre_dec = (shift_flag) ? dec1_1 : dec2_1;

always@(*) begin
    case(shift_bit)
        8'd0: begin
            dec_tmp     =   {pre_dec, 2'd0};
            protect     =   1'b0;
        end
        8'd1: begin
            dec_tmp     =   {1'd0, pre_dec, 1'd0};  
            protect     =   1'b0;
        end
        8'd2: begin
            dec_tmp     =   {2'd0, pre_dec};
            protect     =   1'b0;
        end
        8'd3: begin
            dec_tmp     =   {3'd0, pre_dec[23:1]};
            protect     =   pre_dec[0];
        end
        8'd4: begin
            dec_tmp     =   {4'd0, pre_dec[23:2]};
            protect     =   (pre_dec[1:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd5: begin
            dec_tmp     =   {5'd0, pre_dec[23:3]};
            protect     =   (pre_dec[2:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd6: begin
            dec_tmp     =   {6'd0, pre_dec[23:4]};
            protect     =   (pre_dec[3:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd7: begin
            dec_tmp     =   {7'd0, pre_dec[23:5]};
            protect     =   (pre_dec[4:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd8: begin
            dec_tmp     =   {8'd0, pre_dec[23:6]};
            protect     =   (pre_dec[5:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd9: begin
            dec_tmp     =   {9'd0, pre_dec[23:7]};
            protect     =   (pre_dec[6:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd10: begin
            dec_tmp     =   {10'd0, pre_dec[23:8]};
            protect     =   (pre_dec[7:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd11: begin
            dec_tmp     =   {11'd0, pre_dec[23:9]};
            protect     =   (pre_dec[8:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd12: begin
            dec_tmp     =   {12'd0, pre_dec[23:10]};
            protect     =   (pre_dec[9:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd13: begin
            dec_tmp     =   {13'd0, pre_dec[23:11]};
            protect     =   (pre_dec[10:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd14: begin
            dec_tmp     =   {14'd0, pre_dec[23:12]};
            protect     =   (pre_dec[11:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd15: begin
            dec_tmp     =   {15'd0, pre_dec[23:13]};
            protect     =   (pre_dec[12:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd16: begin
            dec_tmp     =   {16'd0, pre_dec[23:14]};
            protect     =   (pre_dec[13:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd17: begin
            dec_tmp     =   {17'd0, pre_dec[23:15]};
            protect     =   (pre_dec[14:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd18: begin
            dec_tmp     =   {18'd0, pre_dec[23:16]};
            protect     =   (pre_dec[15:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd19: begin
            dec_tmp     =   {19'd0, pre_dec[23:17]};
            protect     =   (pre_dec[16:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd20: begin
            dec_tmp     =   {20'd0, pre_dec[23:18]};
            protect     =   (pre_dec[17:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd21: begin
            dec_tmp     =   {21'd0, pre_dec[23:19]};
            protect     =   (pre_dec[18:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd22: begin
            dec_tmp     =   {22'd0, pre_dec[23:20]};
            protect     =   (pre_dec[19:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd23: begin
            dec_tmp     =   {23'd0, pre_dec[23:21]};
            protect     =   (pre_dec[20:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd24: begin
            dec_tmp     =   {24'd0, pre_dec[23:22]};
            protect     =   (pre_dec[21:0] > 0) ? 1'b1 : 1'b0;
        end
        8'd25: begin
            dec_tmp     =   {25'd0, pre_dec[23]};
            protect     =   (pre_dec[22:0] > 0) ? 1'b1 : 1'b0;
        end
        default: begin
            dec_tmp     =   26'b0;
            protect     =   (pre_dec[23:0] > 0) ? 1'b1 : 1'b0;
        end
    endcase
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        dec1_2  <=  27'b0;
        dec2_2  <=  27'b0;
    end
    else begin
        if(shift_flag) begin
            dec1_2  <=  {dec_tmp, protect};
            dec2_2  <=  {dec2_1, 3'd0};
        end
        else begin
            dec1_2  <=  {dec1_1, 3'd0};
            dec2_2  <=  {dec_tmp, protect};
        end
    end
end

//////////////////////////////////////////////////////////////////
// step5: add the sign to decimal acroding to opcode
//////////////////////////////////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        dec1_3 <= 28'b0;
        dec2_3 <= 28'b0;
    end
    else begin
        if(sign1) begin
            dec1_3 <= ~{1'b0, dec1_2} + 1;
        end
        else begin
            dec1_3 <= {1'b0, dec1_2};
        end

        if(sign2 ^ op_reg) begin
            dec2_3 = ~{1'b0, dec2_2} + 1;
        end
        else begin
            dec2_3 = {1'b0, dec2_2};
        end
    end
end

//////////////////////////////////////////////////////////////////
// step6: add
//////////////////////////////////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sum <= 29'b0;
    end
    else begin
        sum <= dec1_3 + dec2_3;
    end
end

//////////////////////////////////////////////////////////////////
// step7: get absolute value frmo sum
//////////////////////////////////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sum_abs <=  28'b0;
        c_sign  <=  1'b0;
    end
    else begin
        c_sign <= sum[28];
        if(sum[28]) begin   
            sum_abs <= ~sum + 1;
        end
        else begin
            sum_abs <= sum;
        end
    end
end

//////////////////////////////////////////////////////////////////
// step8: calculate sign, decimal, exponent
//////////////////////////////////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        c_exp   <=  9'b0;
        c_dec   <=  23'b0;
    end
    else begin
        if(sum_abs[27]) begin
            if((sum_abs[3:0] > 4'd8) || (sum_abs[3:0] == 4'd8 && sum_abs[4])) begin
                c_dec <= sum_abs[26:4] + 1;
            end
            else begin
                c_dec <= sum_abs[26:4];
            end
            c_exp <= exp_both + 1;
        end
        else if(sum_abs[26]) begin
            if((sum_abs[2:0] > 3'd4) || (sum_abs[2:0] == 3'd4 && sum_abs[3])) begin
                c_dec <= sum_abs[25:3] + 1;
            end
            else begin
                c_dec <= sum_abs[25:3];
            end
            c_exp <= exp_both;
        end
        else if(sum_abs[25]) begin
            if(sum_abs[1:0] > 2'd2 || (sum_abs[1:0] == 2'd2 && sum_abs[2])) begin
                c_dec <= sum_abs[24:2] + 1;
            end
            else begin
                c_dec <= sum_abs[24:2];
            end
            c_exp <= exp_both - 1;
        end
        else if(sum_abs[24]) begin
            if(sum_abs[0] && sum_abs[1]) begin
                c_dec <= sum_abs[23:1] + 1;
            end
            else begin
                c_dec <= sum_abs[23:1];
            end
            c_exp <= exp_both - 2;
        end
        else if(sum_abs[23]) begin
            c_dec <= sum_abs[22:0];
            c_exp <= exp_both - 3;
        end
        else if(sum_abs[22]) begin
            c_dec <= {sum_abs[21:0], 1'd0};
            c_exp <= exp_both - 4;
        end
        else if(sum_abs[21]) begin
            c_dec <= {sum_abs[20:0], 2'd0};
            c_exp <= exp_both - 5;
        end
        else if(sum_abs[20]) begin
            c_dec <= {sum_abs[19:0], 3'd0};
            c_exp <= exp_both - 6;
        end
        else if(sum_abs[19]) begin
            c_dec <= {sum_abs[18:0], 4'd0};
            c_exp <= exp_both - 7;
        end
        else if(sum_abs[18]) begin
            c_dec <= {sum_abs[17:0], 5'd0};
            c_exp <= exp_both - 8;
        end
        else if(sum_abs[17]) begin
            c_dec <= {sum_abs[16:0], 6'd0};
            c_exp <= exp_both - 9;
        end
        else if(sum_abs[16]) begin
            c_dec <= {sum_abs[15:0], 7'd0};
            c_exp <= exp_both - 10;
        end
        else if(sum_abs[15]) begin
            c_dec <= {sum_abs[14:0], 8'd0};
            c_exp <= exp_both - 11;
        end
        else if(sum_abs[14]) begin
            c_dec <= {sum_abs[13:0], 9'd0};
            c_exp <= exp_both - 12;
        end
        else if(sum_abs[13]) begin
            c_dec <= {sum_abs[12:0], 10'd0};
            c_exp <= exp_both - 13;
        end
        else if(sum_abs[12]) begin
            c_dec <= {sum_abs[11:0], 11'd0};
            c_exp <= exp_both - 14;
        end
        else if(sum_abs[11]) begin
            c_dec <= {sum_abs[10:0], 12'd0};
            c_exp <= exp_both - 15;
        end
        else if(sum_abs[10]) begin
            c_dec <= {sum_abs[9:0], 13'd0};
            c_exp <= exp_both - 16;
        end
        else if(sum_abs[9]) begin
            c_dec <= {sum_abs[8:0], 14'd0};
            c_exp <= exp_both - 17;
        end
        else if(sum_abs[8]) begin
            c_dec <= {sum_abs[7:0], 15'd0};
            c_exp <= exp_both - 18;
        end
        else if(sum_abs[7]) begin
            c_dec <= {sum_abs[6:0], 16'd0};
            c_exp <= exp_both - 19;
        end
        else if(sum_abs[6]) begin
            c_dec <= {sum_abs[5:0], 17'd0};
            c_exp <= exp_both - 20;
        end
        else if(sum_abs[5]) begin
            c_dec <= {sum_abs[4:0], 18'd0};
            c_exp <= exp_both - 21;
        end
        else if(sum_abs[4]) begin
            c_dec <= {sum_abs[3:0], 19'd0};
            c_exp <= exp_both - 22;
        end
        else if(sum_abs[3]) begin
            c_dec <= {sum_abs[2:0], 20'd0};
            c_exp <= exp_both - 23;
        end
        else if(sum_abs[2]) begin
            c_dec <= {sum_abs[1:0], 21'd0};
            c_exp <= exp_both - 24;
        end
        else if(sum_abs[1]) begin
            c_dec <= {sum_abs[0], 22'd0};
            c_exp <= exp_both - 25;
        end
        else if(sum_abs[0]) begin
            c_dec <= 23'd0;
            c_exp <= exp_both - 26;
        end
        else begin
            c_dec <= 23'd0;
            c_exp <= 0;
        end
    end
end

//////////////////////////////////////////////////////////////////
// step9: consider abnormal situation, include NaN, infinity,
//          then get the fniall result.
//////////////////////////////////////////////////////////////////

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        data_out <= 32'b0;
    end
    else if(cnt == 3'd7) begin
        // one of data1_in and data2_in is NaN
        if((exp1 == 8'd255 && dec1 != 23'd0) || (exp2 == 8'd255 && dec2 != 23'd0)) begin
            data_out <= {1'b1, 8'd255, {23{1'b1}}};
        end
        // data1_in is infinity
        else if(exp1 == 8'd255 && dec1 == 23'd0) begin
            // data2_in is infinity and the sign is oppsite 
            if((exp2 == 8'd255 && dec2 == 23'd0) && (sign1 ^ (op_reg ^ sign2))) begin
                data_out <= {1'b1, 8'd255, {23{1'b1}}};
            end
            else begin
                data_out <= {sign1, exp1, dec1};
            end
        end
        // data2_in is infinity
        else if(exp2 == 8'd255 && dec2 == 23'd0) begin
            data_out <= {sign1 ^ (op_reg ^ sign2), exp2, dec2};
        end
        // input normal
        // result is 0
        else if(c_exp <= 0) begin
            data_out <= {c_sign, 31'd0};
        end
        // result is infinity
        else if(c_exp == 255) begin
            data_out <= {c_sign, 8'd255, 23'd0};
        end
        else begin
            data_out <= {c_sign, c_exp[7:0], c_dec};
        end
    end
    else begin
        data_out <= data_out;
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        vld <= 1'b0;
    end
    else if(cnt == 3'd7) begin
        vld <= 1'b1;
    end
    else begin
        vld <= 1'b0;
    end
end

endmodule
