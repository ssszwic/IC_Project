module Top(
    input                                   sys_clk         ,
    input                                   sys_rst_n       ,
    // data flow
    input                       [9:0]       data_in         ,
    output  reg     signed      [12:0]      sin_out         ,
    output  reg     signed      [12:0]      cos_out         ,
    // control
    input                                   trig            ,
    output  reg                             vld             
);

reg                 [9:0]       data_in_reg ;  
reg                             trig_reg    ; 


reg     signed      [12:0]      sin0        ;
reg     signed      [12:0]      sin1        ;
reg     signed      [12:0]      sin2        ;
reg     signed      [12:0]      sin3        ;
reg     signed      [12:0]      sin4        ;
reg     signed      [12:0]      sin5        ;
reg     signed      [12:0]      sin6        ;
reg     signed      [12:0]      sin7        ;
reg     signed      [12:0]      sin8        ;
reg     signed      [12:0]      sin9        ;
reg     signed      [12:0]      sin10       ;
reg     signed      [12:0]      sin11       ;
reg     signed      [12:0]      sin12       ;
reg     signed      [12:0]      sin13       ;
reg     signed      [12:0]      sin14       ;
reg     signed      [12:0]      sin15       ;
reg     signed      [12:0]      sin16       ;
reg     signed      [12:0]      sin17       ;
reg     signed      [12:0]      sin18       ;
reg     signed      [12:0]      sin19       ;
reg     signed      [12:0]      sin20       ;
reg     signed      [12:0]      sin21       ;
reg     signed      [12:0]      sin22       ;
reg     signed      [12:0]      sin23       ;
reg     signed      [12:0]      sin24       ;
reg     signed      [12:0]      sin25       ;
reg     signed      [12:0]      sin26       ;
reg     signed      [12:0]      sin27       ;
reg     signed      [12:0]      sin28       ;
reg     signed      [12:0]      sin29       ;
reg     signed      [12:0]      sin30       ;
reg     signed      [12:0]      sin31       ;
reg     signed      [12:0]      cos0        ;
reg     signed      [12:0]      cos1        ;
reg     signed      [12:0]      cos2        ;
reg     signed      [12:0]      cos3        ;
reg     signed      [12:0]      cos4        ;
reg     signed      [12:0]      cos5        ;
reg     signed      [12:0]      cos6        ;
reg     signed      [12:0]      cos7        ;
reg     signed      [12:0]      cos8        ;
reg     signed      [12:0]      cos9        ;
reg     signed      [12:0]      cos10       ;
reg     signed      [12:0]      cos11       ;
reg     signed      [12:0]      cos12       ;
reg     signed      [12:0]      cos13       ;
reg     signed      [12:0]      cos14       ;
reg     signed      [12:0]      cos15       ;
reg     signed      [12:0]      cos16       ;
reg     signed      [12:0]      cos17       ;
reg     signed      [12:0]      cos18       ;
reg     signed      [12:0]      cos19       ;
reg     signed      [12:0]      cos20       ;
reg     signed      [12:0]      cos21       ;
reg     signed      [12:0]      cos22       ;
reg     signed      [12:0]      cos23       ;
reg     signed      [12:0]      cos24       ;
reg     signed      [12:0]      cos25       ;
reg     signed      [12:0]      cos26       ;
reg     signed      [12:0]      cos27       ;
reg     signed      [12:0]      cos28       ;
reg     signed      [12:0]      cos29       ;
reg     signed      [12:0]      cos30       ;
reg     signed      [12:0]      cos31       ;

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        data_in_reg <=  10'b0; 
    end
    else begin
        data_in_reg <=  data_in; 
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        trig_reg    <=  1'b0; 
    end
    else begin
        trig_reg    <=  trig; 
    end
end

always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        vld <=  1'b0;   
    end
    else begin
        vld <=  trig_reg;  
    end
end

// Mux32_1: 0
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin0    <=  13'b0;
        cos0    <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin0    <=  13'b0000000000000;
                cos0    <=  13'b0100000000000;
            end
            5'd1: begin
                sin0    <=  13'b0000000001101;
                cos0    <=  13'b0100000000000;
            end
            5'd2: begin
                sin0    <=  13'b0000000011001;
                cos0    <=  13'b0100000000000;
            end
            5'd3: begin
                sin0    <=  13'b0000000100110;
                cos0    <=  13'b0100000000000;
            end
            5'd4: begin
                sin0    <=  13'b0000000110010;
                cos0    <=  13'b0011111111111;
            end
            5'd5: begin
                sin0    <=  13'b0000000111111;
                cos0    <=  13'b0011111111111;
            end
            5'd6: begin
                sin0    <=  13'b0000001001011;
                cos0    <=  13'b0011111111111;
            end
            5'd7: begin
                sin0    <=  13'b0000001011000;
                cos0    <=  13'b0011111111110;
            end
            5'd8: begin
                sin0    <=  13'b0000001100100;
                cos0    <=  13'b0011111111110;
            end
            5'd9: begin
                sin0    <=  13'b0000001110001;
                cos0    <=  13'b0011111111101;
            end
            5'd10: begin
                sin0    <=  13'b0000001111110;
                cos0    <=  13'b0011111111100;
            end
            5'd11: begin
                sin0    <=  13'b0000010001010;
                cos0    <=  13'b0011111111011;
            end
            5'd12: begin
                sin0    <=  13'b0000010010111;
                cos0    <=  13'b0011111111010;
            end
            5'd13: begin
                sin0    <=  13'b0000010100011;
                cos0    <=  13'b0011111111001;
            end
            5'd14: begin
                sin0    <=  13'b0000010110000;
                cos0    <=  13'b0011111111000;
            end
            5'd15: begin
                sin0    <=  13'b0000010111100;
                cos0    <=  13'b0011111110111;
            end
            5'd16: begin
                sin0    <=  13'b0000011001001;
                cos0    <=  13'b0011111110110;
            end
            5'd17: begin
                sin0    <=  13'b0000011010101;
                cos0    <=  13'b0011111110101;
            end
            5'd18: begin
                sin0    <=  13'b0000011100010;
                cos0    <=  13'b0011111110100;
            end
            5'd19: begin
                sin0    <=  13'b0000011101110;
                cos0    <=  13'b0011111110010;
            end
            5'd20: begin
                sin0    <=  13'b0000011111011;
                cos0    <=  13'b0011111110001;
            end
            5'd21: begin
                sin0    <=  13'b0000100000111;
                cos0    <=  13'b0011111101111;
            end
            5'd22: begin
                sin0    <=  13'b0000100010100;
                cos0    <=  13'b0011111101101;
            end
            5'd23: begin
                sin0    <=  13'b0000100100000;
                cos0    <=  13'b0011111101100;
            end
            5'd24: begin
                sin0    <=  13'b0000100101101;
                cos0    <=  13'b0011111101010;
            end
            5'd25: begin
                sin0    <=  13'b0000100111001;
                cos0    <=  13'b0011111101000;
            end
            5'd26: begin
                sin0    <=  13'b0000101000101;
                cos0    <=  13'b0011111100110;
            end
            5'd27: begin
                sin0    <=  13'b0000101010010;
                cos0    <=  13'b0011111100100;
            end
            5'd28: begin
                sin0    <=  13'b0000101011110;
                cos0    <=  13'b0011111100010;
            end
            5'd29: begin
                sin0    <=  13'b0000101101011;
                cos0    <=  13'b0011111100000;
            end
            5'd30: begin
                sin0    <=  13'b0000101110111;
                cos0    <=  13'b0011111011101;
            end
            5'd31: begin
                sin0    <=  13'b0000110000011;
                cos0    <=  13'b0011111011011;
            end
            default: begin
                sin0    <=  13'd0;
                cos0    <=  13'd0;
            end
        endcase
    end
    else begin
        sin0    <=  sin0;
        cos0    <=  cos0;
    end
end

// Mux32_1: 1
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin1    <=  13'b0;
        cos1    <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin1    <=  13'b0000110010000;
                cos1    <=  13'b0011111011001;
            end
            5'd1: begin
                sin1    <=  13'b0000110011100;
                cos1    <=  13'b0011111010110;
            end
            5'd2: begin
                sin1    <=  13'b0000110101000;
                cos1    <=  13'b0011111010100;
            end
            5'd3: begin
                sin1    <=  13'b0000110110100;
                cos1    <=  13'b0011111010001;
            end
            5'd4: begin
                sin1    <=  13'b0000111000001;
                cos1    <=  13'b0011111001110;
            end
            5'd5: begin
                sin1    <=  13'b0000111001101;
                cos1    <=  13'b0011111001011;
            end
            5'd6: begin
                sin1    <=  13'b0000111011001;
                cos1    <=  13'b0011111001001;
            end
            5'd7: begin
                sin1    <=  13'b0000111100101;
                cos1    <=  13'b0011111000110;
            end
            5'd8: begin
                sin1    <=  13'b0000111110010;
                cos1    <=  13'b0011111000011;
            end
            5'd9: begin
                sin1    <=  13'b0000111111110;
                cos1    <=  13'b0011111000000;
            end
            5'd10: begin
                sin1    <=  13'b0001000001010;
                cos1    <=  13'b0011110111100;
            end
            5'd11: begin
                sin1    <=  13'b0001000010110;
                cos1    <=  13'b0011110111001;
            end
            5'd12: begin
                sin1    <=  13'b0001000100010;
                cos1    <=  13'b0011110110110;
            end
            5'd13: begin
                sin1    <=  13'b0001000101110;
                cos1    <=  13'b0011110110010;
            end
            5'd14: begin
                sin1    <=  13'b0001000111010;
                cos1    <=  13'b0011110101111;
            end
            5'd15: begin
                sin1    <=  13'b0001001000110;
                cos1    <=  13'b0011110101011;
            end
            5'd16: begin
                sin1    <=  13'b0001001010011;
                cos1    <=  13'b0011110101000;
            end
            5'd17: begin
                sin1    <=  13'b0001001011111;
                cos1    <=  13'b0011110100100;
            end
            5'd18: begin
                sin1    <=  13'b0001001101011;
                cos1    <=  13'b0011110100000;
            end
            5'd19: begin
                sin1    <=  13'b0001001110110;
                cos1    <=  13'b0011110011101;
            end
            5'd20: begin
                sin1    <=  13'b0001010000010;
                cos1    <=  13'b0011110011001;
            end
            5'd21: begin
                sin1    <=  13'b0001010001110;
                cos1    <=  13'b0011110010101;
            end
            5'd22: begin
                sin1    <=  13'b0001010011010;
                cos1    <=  13'b0011110010001;
            end
            5'd23: begin
                sin1    <=  13'b0001010100110;
                cos1    <=  13'b0011110001100;
            end
            5'd24: begin
                sin1    <=  13'b0001010110010;
                cos1    <=  13'b0011110001000;
            end
            5'd25: begin
                sin1    <=  13'b0001010111110;
                cos1    <=  13'b0011110000100;
            end
            5'd26: begin
                sin1    <=  13'b0001011001010;
                cos1    <=  13'b0011110000000;
            end
            5'd27: begin
                sin1    <=  13'b0001011010101;
                cos1    <=  13'b0011101111011;
            end
            5'd28: begin
                sin1    <=  13'b0001011100001;
                cos1    <=  13'b0011101110111;
            end
            5'd29: begin
                sin1    <=  13'b0001011101101;
                cos1    <=  13'b0011101110010;
            end
            5'd30: begin
                sin1    <=  13'b0001011111000;
                cos1    <=  13'b0011101101110;
            end
            5'd31: begin
                sin1    <=  13'b0001100000100;
                cos1    <=  13'b0011101101001;
            end
            default: begin
                sin1    <=  13'd0;
                cos1    <=  13'd0;
            end
        endcase
    end
    else begin
        sin1    <=  sin1;
        cos1    <=  cos1;
    end
end

// Mux32_1: 2
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin2    <=  13'b0;
        cos2    <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin2    <=  13'b0001100010000;
                cos2    <=  13'b0011101100100;
            end
            5'd1: begin
                sin2    <=  13'b0001100011011;
                cos2    <=  13'b0011101011111;
            end
            5'd2: begin
                sin2    <=  13'b0001100100111;
                cos2    <=  13'b0011101011010;
            end
            5'd3: begin
                sin2    <=  13'b0001100110010;
                cos2    <=  13'b0011101010101;
            end
            5'd4: begin
                sin2    <=  13'b0001100111110;
                cos2    <=  13'b0011101010000;
            end
            5'd5: begin
                sin2    <=  13'b0001101001001;
                cos2    <=  13'b0011101001011;
            end
            5'd6: begin
                sin2    <=  13'b0001101010101;
                cos2    <=  13'b0011101000110;
            end
            5'd7: begin
                sin2    <=  13'b0001101100000;
                cos2    <=  13'b0011101000001;
            end
            5'd8: begin
                sin2    <=  13'b0001101101100;
                cos2    <=  13'b0011100111011;
            end
            5'd9: begin
                sin2    <=  13'b0001101110111;
                cos2    <=  13'b0011100110110;
            end
            5'd10: begin
                sin2    <=  13'b0001110000010;
                cos2    <=  13'b0011100110000;
            end
            5'd11: begin
                sin2    <=  13'b0001110001110;
                cos2    <=  13'b0011100101011;
            end
            5'd12: begin
                sin2    <=  13'b0001110011001;
                cos2    <=  13'b0011100100101;
            end
            5'd13: begin
                sin2    <=  13'b0001110100100;
                cos2    <=  13'b0011100100000;
            end
            5'd14: begin
                sin2    <=  13'b0001110101111;
                cos2    <=  13'b0011100011010;
            end
            5'd15: begin
                sin2    <=  13'b0001110111010;
                cos2    <=  13'b0011100010100;
            end
            5'd16: begin
                sin2    <=  13'b0001111000101;
                cos2    <=  13'b0011100001110;
            end
            5'd17: begin
                sin2    <=  13'b0001111010000;
                cos2    <=  13'b0011100001000;
            end
            5'd18: begin
                sin2    <=  13'b0001111011100;
                cos2    <=  13'b0011100000010;
            end
            5'd19: begin
                sin2    <=  13'b0001111100111;
                cos2    <=  13'b0011011111100;
            end
            5'd20: begin
                sin2    <=  13'b0001111110001;
                cos2    <=  13'b0011011110110;
            end
            5'd21: begin
                sin2    <=  13'b0001111111100;
                cos2    <=  13'b0011011110000;
            end
            5'd22: begin
                sin2    <=  13'b0010000000111;
                cos2    <=  13'b0011011101001;
            end
            5'd23: begin
                sin2    <=  13'b0010000010010;
                cos2    <=  13'b0011011100011;
            end
            5'd24: begin
                sin2    <=  13'b0010000011101;
                cos2    <=  13'b0011011011101;
            end
            5'd25: begin
                sin2    <=  13'b0010000101000;
                cos2    <=  13'b0011011010110;
            end
            5'd26: begin
                sin2    <=  13'b0010000110010;
                cos2    <=  13'b0011011010000;
            end
            5'd27: begin
                sin2    <=  13'b0010000111101;
                cos2    <=  13'b0011011001001;
            end
            5'd28: begin
                sin2    <=  13'b0010001001000;
                cos2    <=  13'b0011011000010;
            end
            5'd29: begin
                sin2    <=  13'b0010001010010;
                cos2    <=  13'b0011010111100;
            end
            5'd30: begin
                sin2    <=  13'b0010001011101;
                cos2    <=  13'b0011010110101;
            end
            5'd31: begin
                sin2    <=  13'b0010001100111;
                cos2    <=  13'b0011010101110;
            end
            default: begin
                sin2    <=  13'd0;
                cos2    <=  13'd0;
            end
        endcase
    end
    else begin
        sin2    <=  sin2;
        cos2    <=  cos2;
    end
end

// Mux32_1: 3
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin3    <=  13'b0;
        cos3    <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin3    <=  13'b0010001110010;
                cos3    <=  13'b0011010100111;
            end
            5'd1: begin
                sin3    <=  13'b0010001111100;
                cos3    <=  13'b0011010100000;
            end
            5'd2: begin
                sin3    <=  13'b0010010000111;
                cos3    <=  13'b0011010011001;
            end
            5'd3: begin
                sin3    <=  13'b0010010010001;
                cos3    <=  13'b0011010010010;
            end
            5'd4: begin
                sin3    <=  13'b0010010011011;
                cos3    <=  13'b0011010001010;
            end
            5'd5: begin
                sin3    <=  13'b0010010100110;
                cos3    <=  13'b0011010000011;
            end
            5'd6: begin
                sin3    <=  13'b0010010110000;
                cos3    <=  13'b0011001111100;
            end
            5'd7: begin
                sin3    <=  13'b0010010111010;
                cos3    <=  13'b0011001110100;
            end
            5'd8: begin
                sin3    <=  13'b0010011000100;
                cos3    <=  13'b0011001101101;
            end
            5'd9: begin
                sin3    <=  13'b0010011001110;
                cos3    <=  13'b0011001100101;
            end
            5'd10: begin
                sin3    <=  13'b0010011011000;
                cos3    <=  13'b0011001011110;
            end
            5'd11: begin
                sin3    <=  13'b0010011100010;
                cos3    <=  13'b0011001010110;
            end
            5'd12: begin
                sin3    <=  13'b0010011101100;
                cos3    <=  13'b0011001001111;
            end
            5'd13: begin
                sin3    <=  13'b0010011110110;
                cos3    <=  13'b0011001000111;
            end
            5'd14: begin
                sin3    <=  13'b0010100000000;
                cos3    <=  13'b0011000111111;
            end
            5'd15: begin
                sin3    <=  13'b0010100001001;
                cos3    <=  13'b0011000110111;
            end
            5'd16: begin
                sin3    <=  13'b0010100010011;
                cos3    <=  13'b0011000101111;
            end
            5'd17: begin
                sin3    <=  13'b0010100011101;
                cos3    <=  13'b0011000100111;
            end
            5'd18: begin
                sin3    <=  13'b0010100100111;
                cos3    <=  13'b0011000011111;
            end
            5'd19: begin
                sin3    <=  13'b0010100110000;
                cos3    <=  13'b0011000010111;
            end
            5'd20: begin
                sin3    <=  13'b0010100111010;
                cos3    <=  13'b0011000001111;
            end
            5'd21: begin
                sin3    <=  13'b0010101000011;
                cos3    <=  13'b0011000000111;
            end
            5'd22: begin
                sin3    <=  13'b0010101001101;
                cos3    <=  13'b0010111111110;
            end
            5'd23: begin
                sin3    <=  13'b0010101010110;
                cos3    <=  13'b0010111110110;
            end
            5'd24: begin
                sin3    <=  13'b0010101011111;
                cos3    <=  13'b0010111101101;
            end
            5'd25: begin
                sin3    <=  13'b0010101101001;
                cos3    <=  13'b0010111100101;
            end
            5'd26: begin
                sin3    <=  13'b0010101110010;
                cos3    <=  13'b0010111011100;
            end
            5'd27: begin
                sin3    <=  13'b0010101111011;
                cos3    <=  13'b0010111010100;
            end
            5'd28: begin
                sin3    <=  13'b0010110000100;
                cos3    <=  13'b0010111001011;
            end
            5'd29: begin
                sin3    <=  13'b0010110001101;
                cos3    <=  13'b0010111000011;
            end
            5'd30: begin
                sin3    <=  13'b0010110010110;
                cos3    <=  13'b0010110111010;
            end
            5'd31: begin
                sin3    <=  13'b0010110011111;
                cos3    <=  13'b0010110110001;
            end
            default: begin
                sin3    <=  13'd0;
                cos3    <=  13'd0;
            end
        endcase
    end
    else begin
        sin3    <=  sin3;
        cos3    <=  cos3;
    end
end

// Mux32_1: 4
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin4    <=  13'b0;
        cos4    <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin4    <=  13'b0010110101000;
                cos4    <=  13'b0010110101000;
            end
            5'd1: begin
                sin4    <=  13'b0010110110001;
                cos4    <=  13'b0010110011111;
            end
            5'd2: begin
                sin4    <=  13'b0010110111010;
                cos4    <=  13'b0010110010110;
            end
            5'd3: begin
                sin4    <=  13'b0010111000011;
                cos4    <=  13'b0010110001101;
            end
            5'd4: begin
                sin4    <=  13'b0010111001011;
                cos4    <=  13'b0010110000100;
            end
            5'd5: begin
                sin4    <=  13'b0010111010100;
                cos4    <=  13'b0010101111011;
            end
            5'd6: begin
                sin4    <=  13'b0010111011100;
                cos4    <=  13'b0010101110010;
            end
            5'd7: begin
                sin4    <=  13'b0010111100101;
                cos4    <=  13'b0010101101001;
            end
            5'd8: begin
                sin4    <=  13'b0010111101101;
                cos4    <=  13'b0010101011111;
            end
            5'd9: begin
                sin4    <=  13'b0010111110110;
                cos4    <=  13'b0010101010110;
            end
            5'd10: begin
                sin4    <=  13'b0010111111110;
                cos4    <=  13'b0010101001101;
            end
            5'd11: begin
                sin4    <=  13'b0011000000111;
                cos4    <=  13'b0010101000011;
            end
            5'd12: begin
                sin4    <=  13'b0011000001111;
                cos4    <=  13'b0010100111010;
            end
            5'd13: begin
                sin4    <=  13'b0011000010111;
                cos4    <=  13'b0010100110000;
            end
            5'd14: begin
                sin4    <=  13'b0011000011111;
                cos4    <=  13'b0010100100111;
            end
            5'd15: begin
                sin4    <=  13'b0011000100111;
                cos4    <=  13'b0010100011101;
            end
            5'd16: begin
                sin4    <=  13'b0011000101111;
                cos4    <=  13'b0010100010011;
            end
            5'd17: begin
                sin4    <=  13'b0011000110111;
                cos4    <=  13'b0010100001001;
            end
            5'd18: begin
                sin4    <=  13'b0011000111111;
                cos4    <=  13'b0010100000000;
            end
            5'd19: begin
                sin4    <=  13'b0011001000111;
                cos4    <=  13'b0010011110110;
            end
            5'd20: begin
                sin4    <=  13'b0011001001111;
                cos4    <=  13'b0010011101100;
            end
            5'd21: begin
                sin4    <=  13'b0011001010110;
                cos4    <=  13'b0010011100010;
            end
            5'd22: begin
                sin4    <=  13'b0011001011110;
                cos4    <=  13'b0010011011000;
            end
            5'd23: begin
                sin4    <=  13'b0011001100101;
                cos4    <=  13'b0010011001110;
            end
            5'd24: begin
                sin4    <=  13'b0011001101101;
                cos4    <=  13'b0010011000100;
            end
            5'd25: begin
                sin4    <=  13'b0011001110100;
                cos4    <=  13'b0010010111010;
            end
            5'd26: begin
                sin4    <=  13'b0011001111100;
                cos4    <=  13'b0010010110000;
            end
            5'd27: begin
                sin4    <=  13'b0011010000011;
                cos4    <=  13'b0010010100110;
            end
            5'd28: begin
                sin4    <=  13'b0011010001010;
                cos4    <=  13'b0010010011011;
            end
            5'd29: begin
                sin4    <=  13'b0011010010010;
                cos4    <=  13'b0010010010001;
            end
            5'd30: begin
                sin4    <=  13'b0011010011001;
                cos4    <=  13'b0010010000111;
            end
            5'd31: begin
                sin4    <=  13'b0011010100000;
                cos4    <=  13'b0010001111100;
            end
            default: begin
                sin4    <=  13'd0;
                cos4    <=  13'd0;
            end
        endcase
    end
    else begin
        sin4    <=  sin4;
        cos4    <=  cos4;
    end
end

// Mux32_1: 5
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin5    <=  13'b0;
        cos5    <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin5    <=  13'b0011010100111;
                cos5    <=  13'b0010001110010;
            end
            5'd1: begin
                sin5    <=  13'b0011010101110;
                cos5    <=  13'b0010001100111;
            end
            5'd2: begin
                sin5    <=  13'b0011010110101;
                cos5    <=  13'b0010001011101;
            end
            5'd3: begin
                sin5    <=  13'b0011010111100;
                cos5    <=  13'b0010001010010;
            end
            5'd4: begin
                sin5    <=  13'b0011011000010;
                cos5    <=  13'b0010001001000;
            end
            5'd5: begin
                sin5    <=  13'b0011011001001;
                cos5    <=  13'b0010000111101;
            end
            5'd6: begin
                sin5    <=  13'b0011011010000;
                cos5    <=  13'b0010000110010;
            end
            5'd7: begin
                sin5    <=  13'b0011011010110;
                cos5    <=  13'b0010000101000;
            end
            5'd8: begin
                sin5    <=  13'b0011011011101;
                cos5    <=  13'b0010000011101;
            end
            5'd9: begin
                sin5    <=  13'b0011011100011;
                cos5    <=  13'b0010000010010;
            end
            5'd10: begin
                sin5    <=  13'b0011011101001;
                cos5    <=  13'b0010000000111;
            end
            5'd11: begin
                sin5    <=  13'b0011011110000;
                cos5    <=  13'b0001111111100;
            end
            5'd12: begin
                sin5    <=  13'b0011011110110;
                cos5    <=  13'b0001111110001;
            end
            5'd13: begin
                sin5    <=  13'b0011011111100;
                cos5    <=  13'b0001111100111;
            end
            5'd14: begin
                sin5    <=  13'b0011100000010;
                cos5    <=  13'b0001111011100;
            end
            5'd15: begin
                sin5    <=  13'b0011100001000;
                cos5    <=  13'b0001111010000;
            end
            5'd16: begin
                sin5    <=  13'b0011100001110;
                cos5    <=  13'b0001111000101;
            end
            5'd17: begin
                sin5    <=  13'b0011100010100;
                cos5    <=  13'b0001110111010;
            end
            5'd18: begin
                sin5    <=  13'b0011100011010;
                cos5    <=  13'b0001110101111;
            end
            5'd19: begin
                sin5    <=  13'b0011100100000;
                cos5    <=  13'b0001110100100;
            end
            5'd20: begin
                sin5    <=  13'b0011100100101;
                cos5    <=  13'b0001110011001;
            end
            5'd21: begin
                sin5    <=  13'b0011100101011;
                cos5    <=  13'b0001110001110;
            end
            5'd22: begin
                sin5    <=  13'b0011100110000;
                cos5    <=  13'b0001110000010;
            end
            5'd23: begin
                sin5    <=  13'b0011100110110;
                cos5    <=  13'b0001101110111;
            end
            5'd24: begin
                sin5    <=  13'b0011100111011;
                cos5    <=  13'b0001101101100;
            end
            5'd25: begin
                sin5    <=  13'b0011101000001;
                cos5    <=  13'b0001101100000;
            end
            5'd26: begin
                sin5    <=  13'b0011101000110;
                cos5    <=  13'b0001101010101;
            end
            5'd27: begin
                sin5    <=  13'b0011101001011;
                cos5    <=  13'b0001101001001;
            end
            5'd28: begin
                sin5    <=  13'b0011101010000;
                cos5    <=  13'b0001100111110;
            end
            5'd29: begin
                sin5    <=  13'b0011101010101;
                cos5    <=  13'b0001100110010;
            end
            5'd30: begin
                sin5    <=  13'b0011101011010;
                cos5    <=  13'b0001100100111;
            end
            5'd31: begin
                sin5    <=  13'b0011101011111;
                cos5    <=  13'b0001100011011;
            end
            default: begin
                sin5    <=  13'd0;
                cos5    <=  13'd0;
            end
        endcase
    end
    else begin
        sin5    <=  sin5;
        cos5    <=  cos5;
    end
end

// Mux32_1: 6
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin6    <=  13'b0;
        cos6    <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin6    <=  13'b0011101100100;
                cos6    <=  13'b0001100010000;
            end
            5'd1: begin
                sin6    <=  13'b0011101101001;
                cos6    <=  13'b0001100000100;
            end
            5'd2: begin
                sin6    <=  13'b0011101101110;
                cos6    <=  13'b0001011111000;
            end
            5'd3: begin
                sin6    <=  13'b0011101110010;
                cos6    <=  13'b0001011101101;
            end
            5'd4: begin
                sin6    <=  13'b0011101110111;
                cos6    <=  13'b0001011100001;
            end
            5'd5: begin
                sin6    <=  13'b0011101111011;
                cos6    <=  13'b0001011010101;
            end
            5'd6: begin
                sin6    <=  13'b0011110000000;
                cos6    <=  13'b0001011001010;
            end
            5'd7: begin
                sin6    <=  13'b0011110000100;
                cos6    <=  13'b0001010111110;
            end
            5'd8: begin
                sin6    <=  13'b0011110001000;
                cos6    <=  13'b0001010110010;
            end
            5'd9: begin
                sin6    <=  13'b0011110001100;
                cos6    <=  13'b0001010100110;
            end
            5'd10: begin
                sin6    <=  13'b0011110010001;
                cos6    <=  13'b0001010011010;
            end
            5'd11: begin
                sin6    <=  13'b0011110010101;
                cos6    <=  13'b0001010001110;
            end
            5'd12: begin
                sin6    <=  13'b0011110011001;
                cos6    <=  13'b0001010000010;
            end
            5'd13: begin
                sin6    <=  13'b0011110011101;
                cos6    <=  13'b0001001110110;
            end
            5'd14: begin
                sin6    <=  13'b0011110100000;
                cos6    <=  13'b0001001101011;
            end
            5'd15: begin
                sin6    <=  13'b0011110100100;
                cos6    <=  13'b0001001011111;
            end
            5'd16: begin
                sin6    <=  13'b0011110101000;
                cos6    <=  13'b0001001010011;
            end
            5'd17: begin
                sin6    <=  13'b0011110101011;
                cos6    <=  13'b0001001000110;
            end
            5'd18: begin
                sin6    <=  13'b0011110101111;
                cos6    <=  13'b0001000111010;
            end
            5'd19: begin
                sin6    <=  13'b0011110110010;
                cos6    <=  13'b0001000101110;
            end
            5'd20: begin
                sin6    <=  13'b0011110110110;
                cos6    <=  13'b0001000100010;
            end
            5'd21: begin
                sin6    <=  13'b0011110111001;
                cos6    <=  13'b0001000010110;
            end
            5'd22: begin
                sin6    <=  13'b0011110111100;
                cos6    <=  13'b0001000001010;
            end
            5'd23: begin
                sin6    <=  13'b0011111000000;
                cos6    <=  13'b0000111111110;
            end
            5'd24: begin
                sin6    <=  13'b0011111000011;
                cos6    <=  13'b0000111110010;
            end
            5'd25: begin
                sin6    <=  13'b0011111000110;
                cos6    <=  13'b0000111100101;
            end
            5'd26: begin
                sin6    <=  13'b0011111001001;
                cos6    <=  13'b0000111011001;
            end
            5'd27: begin
                sin6    <=  13'b0011111001011;
                cos6    <=  13'b0000111001101;
            end
            5'd28: begin
                sin6    <=  13'b0011111001110;
                cos6    <=  13'b0000111000001;
            end
            5'd29: begin
                sin6    <=  13'b0011111010001;
                cos6    <=  13'b0000110110100;
            end
            5'd30: begin
                sin6    <=  13'b0011111010100;
                cos6    <=  13'b0000110101000;
            end
            5'd31: begin
                sin6    <=  13'b0011111010110;
                cos6    <=  13'b0000110011100;
            end
            default: begin
                sin6    <=  13'd0;
                cos6    <=  13'd0;
            end
        endcase
    end
    else begin
        sin6    <=  sin6;
        cos6    <=  cos6;
    end
end

// Mux32_1: 7
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin7    <=  13'b0;
        cos7    <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin7    <=  13'b0011111011001;
                cos7    <=  13'b0000110010000;
            end
            5'd1: begin
                sin7    <=  13'b0011111011011;
                cos7    <=  13'b0000110000011;
            end
            5'd2: begin
                sin7    <=  13'b0011111011101;
                cos7    <=  13'b0000101110111;
            end
            5'd3: begin
                sin7    <=  13'b0011111100000;
                cos7    <=  13'b0000101101011;
            end
            5'd4: begin
                sin7    <=  13'b0011111100010;
                cos7    <=  13'b0000101011110;
            end
            5'd5: begin
                sin7    <=  13'b0011111100100;
                cos7    <=  13'b0000101010010;
            end
            5'd6: begin
                sin7    <=  13'b0011111100110;
                cos7    <=  13'b0000101000101;
            end
            5'd7: begin
                sin7    <=  13'b0011111101000;
                cos7    <=  13'b0000100111001;
            end
            5'd8: begin
                sin7    <=  13'b0011111101010;
                cos7    <=  13'b0000100101101;
            end
            5'd9: begin
                sin7    <=  13'b0011111101100;
                cos7    <=  13'b0000100100000;
            end
            5'd10: begin
                sin7    <=  13'b0011111101101;
                cos7    <=  13'b0000100010100;
            end
            5'd11: begin
                sin7    <=  13'b0011111101111;
                cos7    <=  13'b0000100000111;
            end
            5'd12: begin
                sin7    <=  13'b0011111110001;
                cos7    <=  13'b0000011111011;
            end
            5'd13: begin
                sin7    <=  13'b0011111110010;
                cos7    <=  13'b0000011101110;
            end
            5'd14: begin
                sin7    <=  13'b0011111110100;
                cos7    <=  13'b0000011100010;
            end
            5'd15: begin
                sin7    <=  13'b0011111110101;
                cos7    <=  13'b0000011010101;
            end
            5'd16: begin
                sin7    <=  13'b0011111110110;
                cos7    <=  13'b0000011001001;
            end
            5'd17: begin
                sin7    <=  13'b0011111110111;
                cos7    <=  13'b0000010111100;
            end
            5'd18: begin
                sin7    <=  13'b0011111111000;
                cos7    <=  13'b0000010110000;
            end
            5'd19: begin
                sin7    <=  13'b0011111111001;
                cos7    <=  13'b0000010100011;
            end
            5'd20: begin
                sin7    <=  13'b0011111111010;
                cos7    <=  13'b0000010010111;
            end
            5'd21: begin
                sin7    <=  13'b0011111111011;
                cos7    <=  13'b0000010001010;
            end
            5'd22: begin
                sin7    <=  13'b0011111111100;
                cos7    <=  13'b0000001111110;
            end
            5'd23: begin
                sin7    <=  13'b0011111111101;
                cos7    <=  13'b0000001110001;
            end
            5'd24: begin
                sin7    <=  13'b0011111111110;
                cos7    <=  13'b0000001100100;
            end
            5'd25: begin
                sin7    <=  13'b0011111111110;
                cos7    <=  13'b0000001011000;
            end
            5'd26: begin
                sin7    <=  13'b0011111111111;
                cos7    <=  13'b0000001001011;
            end
            5'd27: begin
                sin7    <=  13'b0011111111111;
                cos7    <=  13'b0000000111111;
            end
            5'd28: begin
                sin7    <=  13'b0011111111111;
                cos7    <=  13'b0000000110010;
            end
            5'd29: begin
                sin7    <=  13'b0100000000000;
                cos7    <=  13'b0000000100110;
            end
            5'd30: begin
                sin7    <=  13'b0100000000000;
                cos7    <=  13'b0000000011001;
            end
            5'd31: begin
                sin7    <=  13'b0100000000000;
                cos7    <=  13'b0000000001101;
            end
            default: begin
                sin7    <=  13'd0;
                cos7    <=  13'd0;
            end
        endcase
    end
    else begin
        sin7    <=  sin7;
        cos7    <=  cos7;
    end
end

// Mux32_1: 8
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin8    <=  13'b0;
        cos8    <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin8    <=  13'b0100000000000;
                cos8    <=  13'b0000000000000;
            end
            5'd1: begin
                sin8    <=  13'b0100000000000;
                cos8    <=  13'b1111111110011;
            end
            5'd2: begin
                sin8    <=  13'b0100000000000;
                cos8    <=  13'b1111111100111;
            end
            5'd3: begin
                sin8    <=  13'b0100000000000;
                cos8    <=  13'b1111111011010;
            end
            5'd4: begin
                sin8    <=  13'b0011111111111;
                cos8    <=  13'b1111111001110;
            end
            5'd5: begin
                sin8    <=  13'b0011111111111;
                cos8    <=  13'b1111111000001;
            end
            5'd6: begin
                sin8    <=  13'b0011111111111;
                cos8    <=  13'b1111110110101;
            end
            5'd7: begin
                sin8    <=  13'b0011111111110;
                cos8    <=  13'b1111110101000;
            end
            5'd8: begin
                sin8    <=  13'b0011111111110;
                cos8    <=  13'b1111110011100;
            end
            5'd9: begin
                sin8    <=  13'b0011111111101;
                cos8    <=  13'b1111110001111;
            end
            5'd10: begin
                sin8    <=  13'b0011111111100;
                cos8    <=  13'b1111110000010;
            end
            5'd11: begin
                sin8    <=  13'b0011111111011;
                cos8    <=  13'b1111101110110;
            end
            5'd12: begin
                sin8    <=  13'b0011111111010;
                cos8    <=  13'b1111101101001;
            end
            5'd13: begin
                sin8    <=  13'b0011111111001;
                cos8    <=  13'b1111101011101;
            end
            5'd14: begin
                sin8    <=  13'b0011111111000;
                cos8    <=  13'b1111101010000;
            end
            5'd15: begin
                sin8    <=  13'b0011111110111;
                cos8    <=  13'b1111101000100;
            end
            5'd16: begin
                sin8    <=  13'b0011111110110;
                cos8    <=  13'b1111100110111;
            end
            5'd17: begin
                sin8    <=  13'b0011111110101;
                cos8    <=  13'b1111100101011;
            end
            5'd18: begin
                sin8    <=  13'b0011111110100;
                cos8    <=  13'b1111100011110;
            end
            5'd19: begin
                sin8    <=  13'b0011111110010;
                cos8    <=  13'b1111100010010;
            end
            5'd20: begin
                sin8    <=  13'b0011111110001;
                cos8    <=  13'b1111100000101;
            end
            5'd21: begin
                sin8    <=  13'b0011111101111;
                cos8    <=  13'b1111011111001;
            end
            5'd22: begin
                sin8    <=  13'b0011111101101;
                cos8    <=  13'b1111011101100;
            end
            5'd23: begin
                sin8    <=  13'b0011111101100;
                cos8    <=  13'b1111011100000;
            end
            5'd24: begin
                sin8    <=  13'b0011111101010;
                cos8    <=  13'b1111011010011;
            end
            5'd25: begin
                sin8    <=  13'b0011111101000;
                cos8    <=  13'b1111011000111;
            end
            5'd26: begin
                sin8    <=  13'b0011111100110;
                cos8    <=  13'b1111010111011;
            end
            5'd27: begin
                sin8    <=  13'b0011111100100;
                cos8    <=  13'b1111010101110;
            end
            5'd28: begin
                sin8    <=  13'b0011111100010;
                cos8    <=  13'b1111010100010;
            end
            5'd29: begin
                sin8    <=  13'b0011111100000;
                cos8    <=  13'b1111010010101;
            end
            5'd30: begin
                sin8    <=  13'b0011111011101;
                cos8    <=  13'b1111010001001;
            end
            5'd31: begin
                sin8    <=  13'b0011111011011;
                cos8    <=  13'b1111001111101;
            end
            default: begin
                sin8    <=  13'd0;
                cos8    <=  13'd0;
            end
        endcase
    end
    else begin
        sin8    <=  sin8;
        cos8    <=  cos8;
    end
end

// Mux32_1: 9
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin9    <=  13'b0;
        cos9    <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin9    <=  13'b0011111011001;
                cos9    <=  13'b1111001110000;
            end
            5'd1: begin
                sin9    <=  13'b0011111010110;
                cos9    <=  13'b1111001100100;
            end
            5'd2: begin
                sin9    <=  13'b0011111010100;
                cos9    <=  13'b1111001011000;
            end
            5'd3: begin
                sin9    <=  13'b0011111010001;
                cos9    <=  13'b1111001001100;
            end
            5'd4: begin
                sin9    <=  13'b0011111001110;
                cos9    <=  13'b1111000111111;
            end
            5'd5: begin
                sin9    <=  13'b0011111001011;
                cos9    <=  13'b1111000110011;
            end
            5'd6: begin
                sin9    <=  13'b0011111001001;
                cos9    <=  13'b1111000100111;
            end
            5'd7: begin
                sin9    <=  13'b0011111000110;
                cos9    <=  13'b1111000011011;
            end
            5'd8: begin
                sin9    <=  13'b0011111000011;
                cos9    <=  13'b1111000001110;
            end
            5'd9: begin
                sin9    <=  13'b0011111000000;
                cos9    <=  13'b1111000000010;
            end
            5'd10: begin
                sin9    <=  13'b0011110111100;
                cos9    <=  13'b1110111110110;
            end
            5'd11: begin
                sin9    <=  13'b0011110111001;
                cos9    <=  13'b1110111101010;
            end
            5'd12: begin
                sin9    <=  13'b0011110110110;
                cos9    <=  13'b1110111011110;
            end
            5'd13: begin
                sin9    <=  13'b0011110110010;
                cos9    <=  13'b1110111010010;
            end
            5'd14: begin
                sin9    <=  13'b0011110101111;
                cos9    <=  13'b1110111000110;
            end
            5'd15: begin
                sin9    <=  13'b0011110101011;
                cos9    <=  13'b1110110111010;
            end
            5'd16: begin
                sin9    <=  13'b0011110101000;
                cos9    <=  13'b1110110101101;
            end
            5'd17: begin
                sin9    <=  13'b0011110100100;
                cos9    <=  13'b1110110100001;
            end
            5'd18: begin
                sin9    <=  13'b0011110100000;
                cos9    <=  13'b1110110010101;
            end
            5'd19: begin
                sin9    <=  13'b0011110011101;
                cos9    <=  13'b1110110001010;
            end
            5'd20: begin
                sin9    <=  13'b0011110011001;
                cos9    <=  13'b1110101111110;
            end
            5'd21: begin
                sin9    <=  13'b0011110010101;
                cos9    <=  13'b1110101110010;
            end
            5'd22: begin
                sin9    <=  13'b0011110010001;
                cos9    <=  13'b1110101100110;
            end
            5'd23: begin
                sin9    <=  13'b0011110001100;
                cos9    <=  13'b1110101011010;
            end
            5'd24: begin
                sin9    <=  13'b0011110001000;
                cos9    <=  13'b1110101001110;
            end
            5'd25: begin
                sin9    <=  13'b0011110000100;
                cos9    <=  13'b1110101000010;
            end
            5'd26: begin
                sin9    <=  13'b0011110000000;
                cos9    <=  13'b1110100110110;
            end
            5'd27: begin
                sin9    <=  13'b0011101111011;
                cos9    <=  13'b1110100101011;
            end
            5'd28: begin
                sin9    <=  13'b0011101110111;
                cos9    <=  13'b1110100011111;
            end
            5'd29: begin
                sin9    <=  13'b0011101110010;
                cos9    <=  13'b1110100010011;
            end
            5'd30: begin
                sin9    <=  13'b0011101101110;
                cos9    <=  13'b1110100001000;
            end
            5'd31: begin
                sin9    <=  13'b0011101101001;
                cos9    <=  13'b1110011111100;
            end
            default: begin
                sin9    <=  13'd0;
                cos9    <=  13'd0;
            end
        endcase
    end
    else begin
        sin9    <=  sin9;
        cos9    <=  cos9;
    end
end

// Mux32_1: 10
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin10   <=  13'b0;
        cos10   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin10   <=  13'b0011101100100;
                cos10   <=  13'b1110011110000;
            end
            5'd1: begin
                sin10   <=  13'b0011101011111;
                cos10   <=  13'b1110011100101;
            end
            5'd2: begin
                sin10   <=  13'b0011101011010;
                cos10   <=  13'b1110011011001;
            end
            5'd3: begin
                sin10   <=  13'b0011101010101;
                cos10   <=  13'b1110011001110;
            end
            5'd4: begin
                sin10   <=  13'b0011101010000;
                cos10   <=  13'b1110011000010;
            end
            5'd5: begin
                sin10   <=  13'b0011101001011;
                cos10   <=  13'b1110010110111;
            end
            5'd6: begin
                sin10   <=  13'b0011101000110;
                cos10   <=  13'b1110010101011;
            end
            5'd7: begin
                sin10   <=  13'b0011101000001;
                cos10   <=  13'b1110010100000;
            end
            5'd8: begin
                sin10   <=  13'b0011100111011;
                cos10   <=  13'b1110010010100;
            end
            5'd9: begin
                sin10   <=  13'b0011100110110;
                cos10   <=  13'b1110010001001;
            end
            5'd10: begin
                sin10   <=  13'b0011100110000;
                cos10   <=  13'b1110001111110;
            end
            5'd11: begin
                sin10   <=  13'b0011100101011;
                cos10   <=  13'b1110001110010;
            end
            5'd12: begin
                sin10   <=  13'b0011100100101;
                cos10   <=  13'b1110001100111;
            end
            5'd13: begin
                sin10   <=  13'b0011100100000;
                cos10   <=  13'b1110001011100;
            end
            5'd14: begin
                sin10   <=  13'b0011100011010;
                cos10   <=  13'b1110001010001;
            end
            5'd15: begin
                sin10   <=  13'b0011100010100;
                cos10   <=  13'b1110001000110;
            end
            5'd16: begin
                sin10   <=  13'b0011100001110;
                cos10   <=  13'b1110000111011;
            end
            5'd17: begin
                sin10   <=  13'b0011100001000;
                cos10   <=  13'b1110000110000;
            end
            5'd18: begin
                sin10   <=  13'b0011100000010;
                cos10   <=  13'b1110000100100;
            end
            5'd19: begin
                sin10   <=  13'b0011011111100;
                cos10   <=  13'b1110000011001;
            end
            5'd20: begin
                sin10   <=  13'b0011011110110;
                cos10   <=  13'b1110000001111;
            end
            5'd21: begin
                sin10   <=  13'b0011011110000;
                cos10   <=  13'b1110000000100;
            end
            5'd22: begin
                sin10   <=  13'b0011011101001;
                cos10   <=  13'b1101111111001;
            end
            5'd23: begin
                sin10   <=  13'b0011011100011;
                cos10   <=  13'b1101111101110;
            end
            5'd24: begin
                sin10   <=  13'b0011011011101;
                cos10   <=  13'b1101111100011;
            end
            5'd25: begin
                sin10   <=  13'b0011011010110;
                cos10   <=  13'b1101111011000;
            end
            5'd26: begin
                sin10   <=  13'b0011011010000;
                cos10   <=  13'b1101111001110;
            end
            5'd27: begin
                sin10   <=  13'b0011011001001;
                cos10   <=  13'b1101111000011;
            end
            5'd28: begin
                sin10   <=  13'b0011011000010;
                cos10   <=  13'b1101110111000;
            end
            5'd29: begin
                sin10   <=  13'b0011010111100;
                cos10   <=  13'b1101110101110;
            end
            5'd30: begin
                sin10   <=  13'b0011010110101;
                cos10   <=  13'b1101110100011;
            end
            5'd31: begin
                sin10   <=  13'b0011010101110;
                cos10   <=  13'b1101110011001;
            end
            default: begin
                sin10   <=  13'd0;
                cos10   <=  13'd0;
            end
        endcase
    end
    else begin
        sin10   <=  sin10;
        cos10   <=  cos10;
    end
end

// Mux32_1: 11
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin11   <=  13'b0;
        cos11   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin11   <=  13'b0011010100111;
                cos11   <=  13'b1101110001110;
            end
            5'd1: begin
                sin11   <=  13'b0011010100000;
                cos11   <=  13'b1101110000100;
            end
            5'd2: begin
                sin11   <=  13'b0011010011001;
                cos11   <=  13'b1101101111001;
            end
            5'd3: begin
                sin11   <=  13'b0011010010010;
                cos11   <=  13'b1101101101111;
            end
            5'd4: begin
                sin11   <=  13'b0011010001010;
                cos11   <=  13'b1101101100101;
            end
            5'd5: begin
                sin11   <=  13'b0011010000011;
                cos11   <=  13'b1101101011010;
            end
            5'd6: begin
                sin11   <=  13'b0011001111100;
                cos11   <=  13'b1101101010000;
            end
            5'd7: begin
                sin11   <=  13'b0011001110100;
                cos11   <=  13'b1101101000110;
            end
            5'd8: begin
                sin11   <=  13'b0011001101101;
                cos11   <=  13'b1101100111100;
            end
            5'd9: begin
                sin11   <=  13'b0011001100101;
                cos11   <=  13'b1101100110010;
            end
            5'd10: begin
                sin11   <=  13'b0011001011110;
                cos11   <=  13'b1101100101000;
            end
            5'd11: begin
                sin11   <=  13'b0011001010110;
                cos11   <=  13'b1101100011110;
            end
            5'd12: begin
                sin11   <=  13'b0011001001111;
                cos11   <=  13'b1101100010100;
            end
            5'd13: begin
                sin11   <=  13'b0011001000111;
                cos11   <=  13'b1101100001010;
            end
            5'd14: begin
                sin11   <=  13'b0011000111111;
                cos11   <=  13'b1101100000000;
            end
            5'd15: begin
                sin11   <=  13'b0011000110111;
                cos11   <=  13'b1101011110111;
            end
            5'd16: begin
                sin11   <=  13'b0011000101111;
                cos11   <=  13'b1101011101101;
            end
            5'd17: begin
                sin11   <=  13'b0011000100111;
                cos11   <=  13'b1101011100011;
            end
            5'd18: begin
                sin11   <=  13'b0011000011111;
                cos11   <=  13'b1101011011001;
            end
            5'd19: begin
                sin11   <=  13'b0011000010111;
                cos11   <=  13'b1101011010000;
            end
            5'd20: begin
                sin11   <=  13'b0011000001111;
                cos11   <=  13'b1101011000110;
            end
            5'd21: begin
                sin11   <=  13'b0011000000111;
                cos11   <=  13'b1101010111101;
            end
            5'd22: begin
                sin11   <=  13'b0010111111110;
                cos11   <=  13'b1101010110011;
            end
            5'd23: begin
                sin11   <=  13'b0010111110110;
                cos11   <=  13'b1101010101010;
            end
            5'd24: begin
                sin11   <=  13'b0010111101101;
                cos11   <=  13'b1101010100001;
            end
            5'd25: begin
                sin11   <=  13'b0010111100101;
                cos11   <=  13'b1101010010111;
            end
            5'd26: begin
                sin11   <=  13'b0010111011100;
                cos11   <=  13'b1101010001110;
            end
            5'd27: begin
                sin11   <=  13'b0010111010100;
                cos11   <=  13'b1101010000101;
            end
            5'd28: begin
                sin11   <=  13'b0010111001011;
                cos11   <=  13'b1101001111100;
            end
            5'd29: begin
                sin11   <=  13'b0010111000011;
                cos11   <=  13'b1101001110011;
            end
            5'd30: begin
                sin11   <=  13'b0010110111010;
                cos11   <=  13'b1101001101010;
            end
            5'd31: begin
                sin11   <=  13'b0010110110001;
                cos11   <=  13'b1101001100001;
            end
            default: begin
                sin11   <=  13'd0;
                cos11   <=  13'd0;
            end
        endcase
    end
    else begin
        sin11   <=  sin11;
        cos11   <=  cos11;
    end
end

// Mux32_1: 12
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin12   <=  13'b0;
        cos12   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin12   <=  13'b0010110101000;
                cos12   <=  13'b1101001011000;
            end
            5'd1: begin
                sin12   <=  13'b0010110011111;
                cos12   <=  13'b1101001001111;
            end
            5'd2: begin
                sin12   <=  13'b0010110010110;
                cos12   <=  13'b1101001000110;
            end
            5'd3: begin
                sin12   <=  13'b0010110001101;
                cos12   <=  13'b1101000111101;
            end
            5'd4: begin
                sin12   <=  13'b0010110000100;
                cos12   <=  13'b1101000110101;
            end
            5'd5: begin
                sin12   <=  13'b0010101111011;
                cos12   <=  13'b1101000101100;
            end
            5'd6: begin
                sin12   <=  13'b0010101110010;
                cos12   <=  13'b1101000100100;
            end
            5'd7: begin
                sin12   <=  13'b0010101101001;
                cos12   <=  13'b1101000011011;
            end
            5'd8: begin
                sin12   <=  13'b0010101011111;
                cos12   <=  13'b1101000010011;
            end
            5'd9: begin
                sin12   <=  13'b0010101010110;
                cos12   <=  13'b1101000001010;
            end
            5'd10: begin
                sin12   <=  13'b0010101001101;
                cos12   <=  13'b1101000000010;
            end
            5'd11: begin
                sin12   <=  13'b0010101000011;
                cos12   <=  13'b1100111111001;
            end
            5'd12: begin
                sin12   <=  13'b0010100111010;
                cos12   <=  13'b1100111110001;
            end
            5'd13: begin
                sin12   <=  13'b0010100110000;
                cos12   <=  13'b1100111101001;
            end
            5'd14: begin
                sin12   <=  13'b0010100100111;
                cos12   <=  13'b1100111100001;
            end
            5'd15: begin
                sin12   <=  13'b0010100011101;
                cos12   <=  13'b1100111011001;
            end
            5'd16: begin
                sin12   <=  13'b0010100010011;
                cos12   <=  13'b1100111010001;
            end
            5'd17: begin
                sin12   <=  13'b0010100001001;
                cos12   <=  13'b1100111001001;
            end
            5'd18: begin
                sin12   <=  13'b0010100000000;
                cos12   <=  13'b1100111000001;
            end
            5'd19: begin
                sin12   <=  13'b0010011110110;
                cos12   <=  13'b1100110111001;
            end
            5'd20: begin
                sin12   <=  13'b0010011101100;
                cos12   <=  13'b1100110110001;
            end
            5'd21: begin
                sin12   <=  13'b0010011100010;
                cos12   <=  13'b1100110101010;
            end
            5'd22: begin
                sin12   <=  13'b0010011011000;
                cos12   <=  13'b1100110100010;
            end
            5'd23: begin
                sin12   <=  13'b0010011001110;
                cos12   <=  13'b1100110011011;
            end
            5'd24: begin
                sin12   <=  13'b0010011000100;
                cos12   <=  13'b1100110010011;
            end
            5'd25: begin
                sin12   <=  13'b0010010111010;
                cos12   <=  13'b1100110001100;
            end
            5'd26: begin
                sin12   <=  13'b0010010110000;
                cos12   <=  13'b1100110000100;
            end
            5'd27: begin
                sin12   <=  13'b0010010100110;
                cos12   <=  13'b1100101111101;
            end
            5'd28: begin
                sin12   <=  13'b0010010011011;
                cos12   <=  13'b1100101110110;
            end
            5'd29: begin
                sin12   <=  13'b0010010010001;
                cos12   <=  13'b1100101101110;
            end
            5'd30: begin
                sin12   <=  13'b0010010000111;
                cos12   <=  13'b1100101100111;
            end
            5'd31: begin
                sin12   <=  13'b0010001111100;
                cos12   <=  13'b1100101100000;
            end
            default: begin
                sin12   <=  13'd0;
                cos12   <=  13'd0;
            end
        endcase
    end
    else begin
        sin12   <=  sin12;
        cos12   <=  cos12;
    end
end

// Mux32_1: 13
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin13   <=  13'b0;
        cos13   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin13   <=  13'b0010001110010;
                cos13   <=  13'b1100101011001;
            end
            5'd1: begin
                sin13   <=  13'b0010001100111;
                cos13   <=  13'b1100101010010;
            end
            5'd2: begin
                sin13   <=  13'b0010001011101;
                cos13   <=  13'b1100101001011;
            end
            5'd3: begin
                sin13   <=  13'b0010001010010;
                cos13   <=  13'b1100101000100;
            end
            5'd4: begin
                sin13   <=  13'b0010001001000;
                cos13   <=  13'b1100100111110;
            end
            5'd5: begin
                sin13   <=  13'b0010000111101;
                cos13   <=  13'b1100100110111;
            end
            5'd6: begin
                sin13   <=  13'b0010000110010;
                cos13   <=  13'b1100100110000;
            end
            5'd7: begin
                sin13   <=  13'b0010000101000;
                cos13   <=  13'b1100100101010;
            end
            5'd8: begin
                sin13   <=  13'b0010000011101;
                cos13   <=  13'b1100100100011;
            end
            5'd9: begin
                sin13   <=  13'b0010000010010;
                cos13   <=  13'b1100100011101;
            end
            5'd10: begin
                sin13   <=  13'b0010000000111;
                cos13   <=  13'b1100100010111;
            end
            5'd11: begin
                sin13   <=  13'b0001111111100;
                cos13   <=  13'b1100100010000;
            end
            5'd12: begin
                sin13   <=  13'b0001111110001;
                cos13   <=  13'b1100100001010;
            end
            5'd13: begin
                sin13   <=  13'b0001111100111;
                cos13   <=  13'b1100100000100;
            end
            5'd14: begin
                sin13   <=  13'b0001111011100;
                cos13   <=  13'b1100011111110;
            end
            5'd15: begin
                sin13   <=  13'b0001111010000;
                cos13   <=  13'b1100011111000;
            end
            5'd16: begin
                sin13   <=  13'b0001111000101;
                cos13   <=  13'b1100011110010;
            end
            5'd17: begin
                sin13   <=  13'b0001110111010;
                cos13   <=  13'b1100011101100;
            end
            5'd18: begin
                sin13   <=  13'b0001110101111;
                cos13   <=  13'b1100011100110;
            end
            5'd19: begin
                sin13   <=  13'b0001110100100;
                cos13   <=  13'b1100011100000;
            end
            5'd20: begin
                sin13   <=  13'b0001110011001;
                cos13   <=  13'b1100011011011;
            end
            5'd21: begin
                sin13   <=  13'b0001110001110;
                cos13   <=  13'b1100011010101;
            end
            5'd22: begin
                sin13   <=  13'b0001110000010;
                cos13   <=  13'b1100011010000;
            end
            5'd23: begin
                sin13   <=  13'b0001101110111;
                cos13   <=  13'b1100011001010;
            end
            5'd24: begin
                sin13   <=  13'b0001101101100;
                cos13   <=  13'b1100011000101;
            end
            5'd25: begin
                sin13   <=  13'b0001101100000;
                cos13   <=  13'b1100010111111;
            end
            5'd26: begin
                sin13   <=  13'b0001101010101;
                cos13   <=  13'b1100010111010;
            end
            5'd27: begin
                sin13   <=  13'b0001101001001;
                cos13   <=  13'b1100010110101;
            end
            5'd28: begin
                sin13   <=  13'b0001100111110;
                cos13   <=  13'b1100010110000;
            end
            5'd29: begin
                sin13   <=  13'b0001100110010;
                cos13   <=  13'b1100010101011;
            end
            5'd30: begin
                sin13   <=  13'b0001100100111;
                cos13   <=  13'b1100010100110;
            end
            5'd31: begin
                sin13   <=  13'b0001100011011;
                cos13   <=  13'b1100010100001;
            end
            default: begin
                sin13   <=  13'd0;
                cos13   <=  13'd0;
            end
        endcase
    end
    else begin
        sin13   <=  sin13;
        cos13   <=  cos13;
    end
end

// Mux32_1: 14
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin14   <=  13'b0;
        cos14   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin14   <=  13'b0001100010000;
                cos14   <=  13'b1100010011100;
            end
            5'd1: begin
                sin14   <=  13'b0001100000100;
                cos14   <=  13'b1100010010111;
            end
            5'd2: begin
                sin14   <=  13'b0001011111000;
                cos14   <=  13'b1100010010010;
            end
            5'd3: begin
                sin14   <=  13'b0001011101101;
                cos14   <=  13'b1100010001110;
            end
            5'd4: begin
                sin14   <=  13'b0001011100001;
                cos14   <=  13'b1100010001001;
            end
            5'd5: begin
                sin14   <=  13'b0001011010101;
                cos14   <=  13'b1100010000101;
            end
            5'd6: begin
                sin14   <=  13'b0001011001010;
                cos14   <=  13'b1100010000000;
            end
            5'd7: begin
                sin14   <=  13'b0001010111110;
                cos14   <=  13'b1100001111100;
            end
            5'd8: begin
                sin14   <=  13'b0001010110010;
                cos14   <=  13'b1100001111000;
            end
            5'd9: begin
                sin14   <=  13'b0001010100110;
                cos14   <=  13'b1100001110100;
            end
            5'd10: begin
                sin14   <=  13'b0001010011010;
                cos14   <=  13'b1100001101111;
            end
            5'd11: begin
                sin14   <=  13'b0001010001110;
                cos14   <=  13'b1100001101011;
            end
            5'd12: begin
                sin14   <=  13'b0001010000010;
                cos14   <=  13'b1100001100111;
            end
            5'd13: begin
                sin14   <=  13'b0001001110110;
                cos14   <=  13'b1100001100011;
            end
            5'd14: begin
                sin14   <=  13'b0001001101011;
                cos14   <=  13'b1100001100000;
            end
            5'd15: begin
                sin14   <=  13'b0001001011111;
                cos14   <=  13'b1100001011100;
            end
            5'd16: begin
                sin14   <=  13'b0001001010011;
                cos14   <=  13'b1100001011000;
            end
            5'd17: begin
                sin14   <=  13'b0001001000110;
                cos14   <=  13'b1100001010101;
            end
            5'd18: begin
                sin14   <=  13'b0001000111010;
                cos14   <=  13'b1100001010001;
            end
            5'd19: begin
                sin14   <=  13'b0001000101110;
                cos14   <=  13'b1100001001110;
            end
            5'd20: begin
                sin14   <=  13'b0001000100010;
                cos14   <=  13'b1100001001010;
            end
            5'd21: begin
                sin14   <=  13'b0001000010110;
                cos14   <=  13'b1100001000111;
            end
            5'd22: begin
                sin14   <=  13'b0001000001010;
                cos14   <=  13'b1100001000100;
            end
            5'd23: begin
                sin14   <=  13'b0000111111110;
                cos14   <=  13'b1100001000000;
            end
            5'd24: begin
                sin14   <=  13'b0000111110010;
                cos14   <=  13'b1100000111101;
            end
            5'd25: begin
                sin14   <=  13'b0000111100101;
                cos14   <=  13'b1100000111010;
            end
            5'd26: begin
                sin14   <=  13'b0000111011001;
                cos14   <=  13'b1100000110111;
            end
            5'd27: begin
                sin14   <=  13'b0000111001101;
                cos14   <=  13'b1100000110101;
            end
            5'd28: begin
                sin14   <=  13'b0000111000001;
                cos14   <=  13'b1100000110010;
            end
            5'd29: begin
                sin14   <=  13'b0000110110100;
                cos14   <=  13'b1100000101111;
            end
            5'd30: begin
                sin14   <=  13'b0000110101000;
                cos14   <=  13'b1100000101100;
            end
            5'd31: begin
                sin14   <=  13'b0000110011100;
                cos14   <=  13'b1100000101010;
            end
            default: begin
                sin14   <=  13'd0;
                cos14   <=  13'd0;
            end
        endcase
    end
    else begin
        sin14   <=  sin14;
        cos14   <=  cos14;
    end
end

// Mux32_1: 15
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin15   <=  13'b0;
        cos15   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin15   <=  13'b0000110010000;
                cos15   <=  13'b1100000100111;
            end
            5'd1: begin
                sin15   <=  13'b0000110000011;
                cos15   <=  13'b1100000100101;
            end
            5'd2: begin
                sin15   <=  13'b0000101110111;
                cos15   <=  13'b1100000100011;
            end
            5'd3: begin
                sin15   <=  13'b0000101101011;
                cos15   <=  13'b1100000100000;
            end
            5'd4: begin
                sin15   <=  13'b0000101011110;
                cos15   <=  13'b1100000011110;
            end
            5'd5: begin
                sin15   <=  13'b0000101010010;
                cos15   <=  13'b1100000011100;
            end
            5'd6: begin
                sin15   <=  13'b0000101000101;
                cos15   <=  13'b1100000011010;
            end
            5'd7: begin
                sin15   <=  13'b0000100111001;
                cos15   <=  13'b1100000011000;
            end
            5'd8: begin
                sin15   <=  13'b0000100101101;
                cos15   <=  13'b1100000010110;
            end
            5'd9: begin
                sin15   <=  13'b0000100100000;
                cos15   <=  13'b1100000010100;
            end
            5'd10: begin
                sin15   <=  13'b0000100010100;
                cos15   <=  13'b1100000010011;
            end
            5'd11: begin
                sin15   <=  13'b0000100000111;
                cos15   <=  13'b1100000010001;
            end
            5'd12: begin
                sin15   <=  13'b0000011111011;
                cos15   <=  13'b1100000001111;
            end
            5'd13: begin
                sin15   <=  13'b0000011101110;
                cos15   <=  13'b1100000001110;
            end
            5'd14: begin
                sin15   <=  13'b0000011100010;
                cos15   <=  13'b1100000001100;
            end
            5'd15: begin
                sin15   <=  13'b0000011010101;
                cos15   <=  13'b1100000001011;
            end
            5'd16: begin
                sin15   <=  13'b0000011001001;
                cos15   <=  13'b1100000001010;
            end
            5'd17: begin
                sin15   <=  13'b0000010111100;
                cos15   <=  13'b1100000001001;
            end
            5'd18: begin
                sin15   <=  13'b0000010110000;
                cos15   <=  13'b1100000001000;
            end
            5'd19: begin
                sin15   <=  13'b0000010100011;
                cos15   <=  13'b1100000000111;
            end
            5'd20: begin
                sin15   <=  13'b0000010010111;
                cos15   <=  13'b1100000000110;
            end
            5'd21: begin
                sin15   <=  13'b0000010001010;
                cos15   <=  13'b1100000000101;
            end
            5'd22: begin
                sin15   <=  13'b0000001111110;
                cos15   <=  13'b1100000000100;
            end
            5'd23: begin
                sin15   <=  13'b0000001110001;
                cos15   <=  13'b1100000000011;
            end
            5'd24: begin
                sin15   <=  13'b0000001100100;
                cos15   <=  13'b1100000000010;
            end
            5'd25: begin
                sin15   <=  13'b0000001011000;
                cos15   <=  13'b1100000000010;
            end
            5'd26: begin
                sin15   <=  13'b0000001001011;
                cos15   <=  13'b1100000000001;
            end
            5'd27: begin
                sin15   <=  13'b0000000111111;
                cos15   <=  13'b1100000000001;
            end
            5'd28: begin
                sin15   <=  13'b0000000110010;
                cos15   <=  13'b1100000000001;
            end
            5'd29: begin
                sin15   <=  13'b0000000100110;
                cos15   <=  13'b1100000000000;
            end
            5'd30: begin
                sin15   <=  13'b0000000011001;
                cos15   <=  13'b1100000000000;
            end
            5'd31: begin
                sin15   <=  13'b0000000001101;
                cos15   <=  13'b1100000000000;
            end
            default: begin
                sin15   <=  13'd0;
                cos15   <=  13'd0;
            end
        endcase
    end
    else begin
        sin15   <=  sin15;
        cos15   <=  cos15;
    end
end

// Mux32_1: 16
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin16   <=  13'b0;
        cos16   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin16   <=  13'b0000000000000;
                cos16   <=  13'b1100000000000;
            end
            5'd1: begin
                sin16   <=  13'b1111111110011;
                cos16   <=  13'b1100000000000;
            end
            5'd2: begin
                sin16   <=  13'b1111111100111;
                cos16   <=  13'b1100000000000;
            end
            5'd3: begin
                sin16   <=  13'b1111111011010;
                cos16   <=  13'b1100000000000;
            end
            5'd4: begin
                sin16   <=  13'b1111111001110;
                cos16   <=  13'b1100000000001;
            end
            5'd5: begin
                sin16   <=  13'b1111111000001;
                cos16   <=  13'b1100000000001;
            end
            5'd6: begin
                sin16   <=  13'b1111110110101;
                cos16   <=  13'b1100000000001;
            end
            5'd7: begin
                sin16   <=  13'b1111110101000;
                cos16   <=  13'b1100000000010;
            end
            5'd8: begin
                sin16   <=  13'b1111110011100;
                cos16   <=  13'b1100000000010;
            end
            5'd9: begin
                sin16   <=  13'b1111110001111;
                cos16   <=  13'b1100000000011;
            end
            5'd10: begin
                sin16   <=  13'b1111110000010;
                cos16   <=  13'b1100000000100;
            end
            5'd11: begin
                sin16   <=  13'b1111101110110;
                cos16   <=  13'b1100000000101;
            end
            5'd12: begin
                sin16   <=  13'b1111101101001;
                cos16   <=  13'b1100000000110;
            end
            5'd13: begin
                sin16   <=  13'b1111101011101;
                cos16   <=  13'b1100000000111;
            end
            5'd14: begin
                sin16   <=  13'b1111101010000;
                cos16   <=  13'b1100000001000;
            end
            5'd15: begin
                sin16   <=  13'b1111101000100;
                cos16   <=  13'b1100000001001;
            end
            5'd16: begin
                sin16   <=  13'b1111100110111;
                cos16   <=  13'b1100000001010;
            end
            5'd17: begin
                sin16   <=  13'b1111100101011;
                cos16   <=  13'b1100000001011;
            end
            5'd18: begin
                sin16   <=  13'b1111100011110;
                cos16   <=  13'b1100000001100;
            end
            5'd19: begin
                sin16   <=  13'b1111100010010;
                cos16   <=  13'b1100000001110;
            end
            5'd20: begin
                sin16   <=  13'b1111100000101;
                cos16   <=  13'b1100000001111;
            end
            5'd21: begin
                sin16   <=  13'b1111011111001;
                cos16   <=  13'b1100000010001;
            end
            5'd22: begin
                sin16   <=  13'b1111011101100;
                cos16   <=  13'b1100000010011;
            end
            5'd23: begin
                sin16   <=  13'b1111011100000;
                cos16   <=  13'b1100000010100;
            end
            5'd24: begin
                sin16   <=  13'b1111011010011;
                cos16   <=  13'b1100000010110;
            end
            5'd25: begin
                sin16   <=  13'b1111011000111;
                cos16   <=  13'b1100000011000;
            end
            5'd26: begin
                sin16   <=  13'b1111010111011;
                cos16   <=  13'b1100000011010;
            end
            5'd27: begin
                sin16   <=  13'b1111010101110;
                cos16   <=  13'b1100000011100;
            end
            5'd28: begin
                sin16   <=  13'b1111010100010;
                cos16   <=  13'b1100000011110;
            end
            5'd29: begin
                sin16   <=  13'b1111010010101;
                cos16   <=  13'b1100000100000;
            end
            5'd30: begin
                sin16   <=  13'b1111010001001;
                cos16   <=  13'b1100000100011;
            end
            5'd31: begin
                sin16   <=  13'b1111001111101;
                cos16   <=  13'b1100000100101;
            end
            default: begin
                sin16   <=  13'd0;
                cos16   <=  13'd0;
            end
        endcase
    end
    else begin
        sin16   <=  sin16;
        cos16   <=  cos16;
    end
end

// Mux32_1: 17
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin17   <=  13'b0;
        cos17   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin17   <=  13'b1111001110000;
                cos17   <=  13'b1100000100111;
            end
            5'd1: begin
                sin17   <=  13'b1111001100100;
                cos17   <=  13'b1100000101010;
            end
            5'd2: begin
                sin17   <=  13'b1111001011000;
                cos17   <=  13'b1100000101100;
            end
            5'd3: begin
                sin17   <=  13'b1111001001100;
                cos17   <=  13'b1100000101111;
            end
            5'd4: begin
                sin17   <=  13'b1111000111111;
                cos17   <=  13'b1100000110010;
            end
            5'd5: begin
                sin17   <=  13'b1111000110011;
                cos17   <=  13'b1100000110101;
            end
            5'd6: begin
                sin17   <=  13'b1111000100111;
                cos17   <=  13'b1100000110111;
            end
            5'd7: begin
                sin17   <=  13'b1111000011011;
                cos17   <=  13'b1100000111010;
            end
            5'd8: begin
                sin17   <=  13'b1111000001110;
                cos17   <=  13'b1100000111101;
            end
            5'd9: begin
                sin17   <=  13'b1111000000010;
                cos17   <=  13'b1100001000000;
            end
            5'd10: begin
                sin17   <=  13'b1110111110110;
                cos17   <=  13'b1100001000100;
            end
            5'd11: begin
                sin17   <=  13'b1110111101010;
                cos17   <=  13'b1100001000111;
            end
            5'd12: begin
                sin17   <=  13'b1110111011110;
                cos17   <=  13'b1100001001010;
            end
            5'd13: begin
                sin17   <=  13'b1110111010010;
                cos17   <=  13'b1100001001110;
            end
            5'd14: begin
                sin17   <=  13'b1110111000110;
                cos17   <=  13'b1100001010001;
            end
            5'd15: begin
                sin17   <=  13'b1110110111010;
                cos17   <=  13'b1100001010101;
            end
            5'd16: begin
                sin17   <=  13'b1110110101101;
                cos17   <=  13'b1100001011000;
            end
            5'd17: begin
                sin17   <=  13'b1110110100001;
                cos17   <=  13'b1100001011100;
            end
            5'd18: begin
                sin17   <=  13'b1110110010101;
                cos17   <=  13'b1100001100000;
            end
            5'd19: begin
                sin17   <=  13'b1110110001010;
                cos17   <=  13'b1100001100011;
            end
            5'd20: begin
                sin17   <=  13'b1110101111110;
                cos17   <=  13'b1100001100111;
            end
            5'd21: begin
                sin17   <=  13'b1110101110010;
                cos17   <=  13'b1100001101011;
            end
            5'd22: begin
                sin17   <=  13'b1110101100110;
                cos17   <=  13'b1100001101111;
            end
            5'd23: begin
                sin17   <=  13'b1110101011010;
                cos17   <=  13'b1100001110100;
            end
            5'd24: begin
                sin17   <=  13'b1110101001110;
                cos17   <=  13'b1100001111000;
            end
            5'd25: begin
                sin17   <=  13'b1110101000010;
                cos17   <=  13'b1100001111100;
            end
            5'd26: begin
                sin17   <=  13'b1110100110110;
                cos17   <=  13'b1100010000000;
            end
            5'd27: begin
                sin17   <=  13'b1110100101011;
                cos17   <=  13'b1100010000101;
            end
            5'd28: begin
                sin17   <=  13'b1110100011111;
                cos17   <=  13'b1100010001001;
            end
            5'd29: begin
                sin17   <=  13'b1110100010011;
                cos17   <=  13'b1100010001110;
            end
            5'd30: begin
                sin17   <=  13'b1110100001000;
                cos17   <=  13'b1100010010010;
            end
            5'd31: begin
                sin17   <=  13'b1110011111100;
                cos17   <=  13'b1100010010111;
            end
            default: begin
                sin17   <=  13'd0;
                cos17   <=  13'd0;
            end
        endcase
    end
    else begin
        sin17   <=  sin17;
        cos17   <=  cos17;
    end
end

// Mux32_1: 18
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin18   <=  13'b0;
        cos18   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin18   <=  13'b1110011110000;
                cos18   <=  13'b1100010011100;
            end
            5'd1: begin
                sin18   <=  13'b1110011100101;
                cos18   <=  13'b1100010100001;
            end
            5'd2: begin
                sin18   <=  13'b1110011011001;
                cos18   <=  13'b1100010100110;
            end
            5'd3: begin
                sin18   <=  13'b1110011001110;
                cos18   <=  13'b1100010101011;
            end
            5'd4: begin
                sin18   <=  13'b1110011000010;
                cos18   <=  13'b1100010110000;
            end
            5'd5: begin
                sin18   <=  13'b1110010110111;
                cos18   <=  13'b1100010110101;
            end
            5'd6: begin
                sin18   <=  13'b1110010101011;
                cos18   <=  13'b1100010111010;
            end
            5'd7: begin
                sin18   <=  13'b1110010100000;
                cos18   <=  13'b1100010111111;
            end
            5'd8: begin
                sin18   <=  13'b1110010010100;
                cos18   <=  13'b1100011000101;
            end
            5'd9: begin
                sin18   <=  13'b1110010001001;
                cos18   <=  13'b1100011001010;
            end
            5'd10: begin
                sin18   <=  13'b1110001111110;
                cos18   <=  13'b1100011010000;
            end
            5'd11: begin
                sin18   <=  13'b1110001110010;
                cos18   <=  13'b1100011010101;
            end
            5'd12: begin
                sin18   <=  13'b1110001100111;
                cos18   <=  13'b1100011011011;
            end
            5'd13: begin
                sin18   <=  13'b1110001011100;
                cos18   <=  13'b1100011100000;
            end
            5'd14: begin
                sin18   <=  13'b1110001010001;
                cos18   <=  13'b1100011100110;
            end
            5'd15: begin
                sin18   <=  13'b1110001000110;
                cos18   <=  13'b1100011101100;
            end
            5'd16: begin
                sin18   <=  13'b1110000111011;
                cos18   <=  13'b1100011110010;
            end
            5'd17: begin
                sin18   <=  13'b1110000110000;
                cos18   <=  13'b1100011111000;
            end
            5'd18: begin
                sin18   <=  13'b1110000100100;
                cos18   <=  13'b1100011111110;
            end
            5'd19: begin
                sin18   <=  13'b1110000011001;
                cos18   <=  13'b1100100000100;
            end
            5'd20: begin
                sin18   <=  13'b1110000001111;
                cos18   <=  13'b1100100001010;
            end
            5'd21: begin
                sin18   <=  13'b1110000000100;
                cos18   <=  13'b1100100010000;
            end
            5'd22: begin
                sin18   <=  13'b1101111111001;
                cos18   <=  13'b1100100010111;
            end
            5'd23: begin
                sin18   <=  13'b1101111101110;
                cos18   <=  13'b1100100011101;
            end
            5'd24: begin
                sin18   <=  13'b1101111100011;
                cos18   <=  13'b1100100100011;
            end
            5'd25: begin
                sin18   <=  13'b1101111011000;
                cos18   <=  13'b1100100101010;
            end
            5'd26: begin
                sin18   <=  13'b1101111001110;
                cos18   <=  13'b1100100110000;
            end
            5'd27: begin
                sin18   <=  13'b1101111000011;
                cos18   <=  13'b1100100110111;
            end
            5'd28: begin
                sin18   <=  13'b1101110111000;
                cos18   <=  13'b1100100111110;
            end
            5'd29: begin
                sin18   <=  13'b1101110101110;
                cos18   <=  13'b1100101000100;
            end
            5'd30: begin
                sin18   <=  13'b1101110100011;
                cos18   <=  13'b1100101001011;
            end
            5'd31: begin
                sin18   <=  13'b1101110011001;
                cos18   <=  13'b1100101010010;
            end
            default: begin
                sin18   <=  13'd0;
                cos18   <=  13'd0;
            end
        endcase
    end
    else begin
        sin18   <=  sin18;
        cos18   <=  cos18;
    end
end

// Mux32_1: 19
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin19   <=  13'b0;
        cos19   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin19   <=  13'b1101110001110;
                cos19   <=  13'b1100101011001;
            end
            5'd1: begin
                sin19   <=  13'b1101110000100;
                cos19   <=  13'b1100101100000;
            end
            5'd2: begin
                sin19   <=  13'b1101101111001;
                cos19   <=  13'b1100101100111;
            end
            5'd3: begin
                sin19   <=  13'b1101101101111;
                cos19   <=  13'b1100101101110;
            end
            5'd4: begin
                sin19   <=  13'b1101101100101;
                cos19   <=  13'b1100101110110;
            end
            5'd5: begin
                sin19   <=  13'b1101101011010;
                cos19   <=  13'b1100101111101;
            end
            5'd6: begin
                sin19   <=  13'b1101101010000;
                cos19   <=  13'b1100110000100;
            end
            5'd7: begin
                sin19   <=  13'b1101101000110;
                cos19   <=  13'b1100110001100;
            end
            5'd8: begin
                sin19   <=  13'b1101100111100;
                cos19   <=  13'b1100110010011;
            end
            5'd9: begin
                sin19   <=  13'b1101100110010;
                cos19   <=  13'b1100110011011;
            end
            5'd10: begin
                sin19   <=  13'b1101100101000;
                cos19   <=  13'b1100110100010;
            end
            5'd11: begin
                sin19   <=  13'b1101100011110;
                cos19   <=  13'b1100110101010;
            end
            5'd12: begin
                sin19   <=  13'b1101100010100;
                cos19   <=  13'b1100110110001;
            end
            5'd13: begin
                sin19   <=  13'b1101100001010;
                cos19   <=  13'b1100110111001;
            end
            5'd14: begin
                sin19   <=  13'b1101100000000;
                cos19   <=  13'b1100111000001;
            end
            5'd15: begin
                sin19   <=  13'b1101011110111;
                cos19   <=  13'b1100111001001;
            end
            5'd16: begin
                sin19   <=  13'b1101011101101;
                cos19   <=  13'b1100111010001;
            end
            5'd17: begin
                sin19   <=  13'b1101011100011;
                cos19   <=  13'b1100111011001;
            end
            5'd18: begin
                sin19   <=  13'b1101011011001;
                cos19   <=  13'b1100111100001;
            end
            5'd19: begin
                sin19   <=  13'b1101011010000;
                cos19   <=  13'b1100111101001;
            end
            5'd20: begin
                sin19   <=  13'b1101011000110;
                cos19   <=  13'b1100111110001;
            end
            5'd21: begin
                sin19   <=  13'b1101010111101;
                cos19   <=  13'b1100111111001;
            end
            5'd22: begin
                sin19   <=  13'b1101010110011;
                cos19   <=  13'b1101000000010;
            end
            5'd23: begin
                sin19   <=  13'b1101010101010;
                cos19   <=  13'b1101000001010;
            end
            5'd24: begin
                sin19   <=  13'b1101010100001;
                cos19   <=  13'b1101000010011;
            end
            5'd25: begin
                sin19   <=  13'b1101010010111;
                cos19   <=  13'b1101000011011;
            end
            5'd26: begin
                sin19   <=  13'b1101010001110;
                cos19   <=  13'b1101000100100;
            end
            5'd27: begin
                sin19   <=  13'b1101010000101;
                cos19   <=  13'b1101000101100;
            end
            5'd28: begin
                sin19   <=  13'b1101001111100;
                cos19   <=  13'b1101000110101;
            end
            5'd29: begin
                sin19   <=  13'b1101001110011;
                cos19   <=  13'b1101000111101;
            end
            5'd30: begin
                sin19   <=  13'b1101001101010;
                cos19   <=  13'b1101001000110;
            end
            5'd31: begin
                sin19   <=  13'b1101001100001;
                cos19   <=  13'b1101001001111;
            end
            default: begin
                sin19   <=  13'd0;
                cos19   <=  13'd0;
            end
        endcase
    end
    else begin
        sin19   <=  sin19;
        cos19   <=  cos19;
    end
end

// Mux32_1: 20
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin20   <=  13'b0;
        cos20   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin20   <=  13'b1101001011000;
                cos20   <=  13'b1101001011000;
            end
            5'd1: begin
                sin20   <=  13'b1101001001111;
                cos20   <=  13'b1101001100001;
            end
            5'd2: begin
                sin20   <=  13'b1101001000110;
                cos20   <=  13'b1101001101010;
            end
            5'd3: begin
                sin20   <=  13'b1101000111101;
                cos20   <=  13'b1101001110011;
            end
            5'd4: begin
                sin20   <=  13'b1101000110101;
                cos20   <=  13'b1101001111100;
            end
            5'd5: begin
                sin20   <=  13'b1101000101100;
                cos20   <=  13'b1101010000101;
            end
            5'd6: begin
                sin20   <=  13'b1101000100100;
                cos20   <=  13'b1101010001110;
            end
            5'd7: begin
                sin20   <=  13'b1101000011011;
                cos20   <=  13'b1101010010111;
            end
            5'd8: begin
                sin20   <=  13'b1101000010011;
                cos20   <=  13'b1101010100001;
            end
            5'd9: begin
                sin20   <=  13'b1101000001010;
                cos20   <=  13'b1101010101010;
            end
            5'd10: begin
                sin20   <=  13'b1101000000010;
                cos20   <=  13'b1101010110011;
            end
            5'd11: begin
                sin20   <=  13'b1100111111001;
                cos20   <=  13'b1101010111101;
            end
            5'd12: begin
                sin20   <=  13'b1100111110001;
                cos20   <=  13'b1101011000110;
            end
            5'd13: begin
                sin20   <=  13'b1100111101001;
                cos20   <=  13'b1101011010000;
            end
            5'd14: begin
                sin20   <=  13'b1100111100001;
                cos20   <=  13'b1101011011001;
            end
            5'd15: begin
                sin20   <=  13'b1100111011001;
                cos20   <=  13'b1101011100011;
            end
            5'd16: begin
                sin20   <=  13'b1100111010001;
                cos20   <=  13'b1101011101101;
            end
            5'd17: begin
                sin20   <=  13'b1100111001001;
                cos20   <=  13'b1101011110111;
            end
            5'd18: begin
                sin20   <=  13'b1100111000001;
                cos20   <=  13'b1101100000000;
            end
            5'd19: begin
                sin20   <=  13'b1100110111001;
                cos20   <=  13'b1101100001010;
            end
            5'd20: begin
                sin20   <=  13'b1100110110001;
                cos20   <=  13'b1101100010100;
            end
            5'd21: begin
                sin20   <=  13'b1100110101010;
                cos20   <=  13'b1101100011110;
            end
            5'd22: begin
                sin20   <=  13'b1100110100010;
                cos20   <=  13'b1101100101000;
            end
            5'd23: begin
                sin20   <=  13'b1100110011011;
                cos20   <=  13'b1101100110010;
            end
            5'd24: begin
                sin20   <=  13'b1100110010011;
                cos20   <=  13'b1101100111100;
            end
            5'd25: begin
                sin20   <=  13'b1100110001100;
                cos20   <=  13'b1101101000110;
            end
            5'd26: begin
                sin20   <=  13'b1100110000100;
                cos20   <=  13'b1101101010000;
            end
            5'd27: begin
                sin20   <=  13'b1100101111101;
                cos20   <=  13'b1101101011010;
            end
            5'd28: begin
                sin20   <=  13'b1100101110110;
                cos20   <=  13'b1101101100101;
            end
            5'd29: begin
                sin20   <=  13'b1100101101110;
                cos20   <=  13'b1101101101111;
            end
            5'd30: begin
                sin20   <=  13'b1100101100111;
                cos20   <=  13'b1101101111001;
            end
            5'd31: begin
                sin20   <=  13'b1100101100000;
                cos20   <=  13'b1101110000100;
            end
            default: begin
                sin20   <=  13'd0;
                cos20   <=  13'd0;
            end
        endcase
    end
    else begin
        sin20   <=  sin20;
        cos20   <=  cos20;
    end
end

// Mux32_1: 21
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin21   <=  13'b0;
        cos21   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin21   <=  13'b1100101011001;
                cos21   <=  13'b1101110001110;
            end
            5'd1: begin
                sin21   <=  13'b1100101010010;
                cos21   <=  13'b1101110011001;
            end
            5'd2: begin
                sin21   <=  13'b1100101001011;
                cos21   <=  13'b1101110100011;
            end
            5'd3: begin
                sin21   <=  13'b1100101000100;
                cos21   <=  13'b1101110101110;
            end
            5'd4: begin
                sin21   <=  13'b1100100111110;
                cos21   <=  13'b1101110111000;
            end
            5'd5: begin
                sin21   <=  13'b1100100110111;
                cos21   <=  13'b1101111000011;
            end
            5'd6: begin
                sin21   <=  13'b1100100110000;
                cos21   <=  13'b1101111001110;
            end
            5'd7: begin
                sin21   <=  13'b1100100101010;
                cos21   <=  13'b1101111011000;
            end
            5'd8: begin
                sin21   <=  13'b1100100100011;
                cos21   <=  13'b1101111100011;
            end
            5'd9: begin
                sin21   <=  13'b1100100011101;
                cos21   <=  13'b1101111101110;
            end
            5'd10: begin
                sin21   <=  13'b1100100010111;
                cos21   <=  13'b1101111111001;
            end
            5'd11: begin
                sin21   <=  13'b1100100010000;
                cos21   <=  13'b1110000000100;
            end
            5'd12: begin
                sin21   <=  13'b1100100001010;
                cos21   <=  13'b1110000001111;
            end
            5'd13: begin
                sin21   <=  13'b1100100000100;
                cos21   <=  13'b1110000011001;
            end
            5'd14: begin
                sin21   <=  13'b1100011111110;
                cos21   <=  13'b1110000100100;
            end
            5'd15: begin
                sin21   <=  13'b1100011111000;
                cos21   <=  13'b1110000110000;
            end
            5'd16: begin
                sin21   <=  13'b1100011110010;
                cos21   <=  13'b1110000111011;
            end
            5'd17: begin
                sin21   <=  13'b1100011101100;
                cos21   <=  13'b1110001000110;
            end
            5'd18: begin
                sin21   <=  13'b1100011100110;
                cos21   <=  13'b1110001010001;
            end
            5'd19: begin
                sin21   <=  13'b1100011100000;
                cos21   <=  13'b1110001011100;
            end
            5'd20: begin
                sin21   <=  13'b1100011011011;
                cos21   <=  13'b1110001100111;
            end
            5'd21: begin
                sin21   <=  13'b1100011010101;
                cos21   <=  13'b1110001110010;
            end
            5'd22: begin
                sin21   <=  13'b1100011010000;
                cos21   <=  13'b1110001111110;
            end
            5'd23: begin
                sin21   <=  13'b1100011001010;
                cos21   <=  13'b1110010001001;
            end
            5'd24: begin
                sin21   <=  13'b1100011000101;
                cos21   <=  13'b1110010010100;
            end
            5'd25: begin
                sin21   <=  13'b1100010111111;
                cos21   <=  13'b1110010100000;
            end
            5'd26: begin
                sin21   <=  13'b1100010111010;
                cos21   <=  13'b1110010101011;
            end
            5'd27: begin
                sin21   <=  13'b1100010110101;
                cos21   <=  13'b1110010110111;
            end
            5'd28: begin
                sin21   <=  13'b1100010110000;
                cos21   <=  13'b1110011000010;
            end
            5'd29: begin
                sin21   <=  13'b1100010101011;
                cos21   <=  13'b1110011001110;
            end
            5'd30: begin
                sin21   <=  13'b1100010100110;
                cos21   <=  13'b1110011011001;
            end
            5'd31: begin
                sin21   <=  13'b1100010100001;
                cos21   <=  13'b1110011100101;
            end
            default: begin
                sin21   <=  13'd0;
                cos21   <=  13'd0;
            end
        endcase
    end
    else begin
        sin21   <=  sin21;
        cos21   <=  cos21;
    end
end

// Mux32_1: 22
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin22   <=  13'b0;
        cos22   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin22   <=  13'b1100010011100;
                cos22   <=  13'b1110011110000;
            end
            5'd1: begin
                sin22   <=  13'b1100010010111;
                cos22   <=  13'b1110011111100;
            end
            5'd2: begin
                sin22   <=  13'b1100010010010;
                cos22   <=  13'b1110100001000;
            end
            5'd3: begin
                sin22   <=  13'b1100010001110;
                cos22   <=  13'b1110100010011;
            end
            5'd4: begin
                sin22   <=  13'b1100010001001;
                cos22   <=  13'b1110100011111;
            end
            5'd5: begin
                sin22   <=  13'b1100010000101;
                cos22   <=  13'b1110100101011;
            end
            5'd6: begin
                sin22   <=  13'b1100010000000;
                cos22   <=  13'b1110100110110;
            end
            5'd7: begin
                sin22   <=  13'b1100001111100;
                cos22   <=  13'b1110101000010;
            end
            5'd8: begin
                sin22   <=  13'b1100001111000;
                cos22   <=  13'b1110101001110;
            end
            5'd9: begin
                sin22   <=  13'b1100001110100;
                cos22   <=  13'b1110101011010;
            end
            5'd10: begin
                sin22   <=  13'b1100001101111;
                cos22   <=  13'b1110101100110;
            end
            5'd11: begin
                sin22   <=  13'b1100001101011;
                cos22   <=  13'b1110101110010;
            end
            5'd12: begin
                sin22   <=  13'b1100001100111;
                cos22   <=  13'b1110101111110;
            end
            5'd13: begin
                sin22   <=  13'b1100001100011;
                cos22   <=  13'b1110110001010;
            end
            5'd14: begin
                sin22   <=  13'b1100001100000;
                cos22   <=  13'b1110110010101;
            end
            5'd15: begin
                sin22   <=  13'b1100001011100;
                cos22   <=  13'b1110110100001;
            end
            5'd16: begin
                sin22   <=  13'b1100001011000;
                cos22   <=  13'b1110110101101;
            end
            5'd17: begin
                sin22   <=  13'b1100001010101;
                cos22   <=  13'b1110110111010;
            end
            5'd18: begin
                sin22   <=  13'b1100001010001;
                cos22   <=  13'b1110111000110;
            end
            5'd19: begin
                sin22   <=  13'b1100001001110;
                cos22   <=  13'b1110111010010;
            end
            5'd20: begin
                sin22   <=  13'b1100001001010;
                cos22   <=  13'b1110111011110;
            end
            5'd21: begin
                sin22   <=  13'b1100001000111;
                cos22   <=  13'b1110111101010;
            end
            5'd22: begin
                sin22   <=  13'b1100001000100;
                cos22   <=  13'b1110111110110;
            end
            5'd23: begin
                sin22   <=  13'b1100001000000;
                cos22   <=  13'b1111000000010;
            end
            5'd24: begin
                sin22   <=  13'b1100000111101;
                cos22   <=  13'b1111000001110;
            end
            5'd25: begin
                sin22   <=  13'b1100000111010;
                cos22   <=  13'b1111000011011;
            end
            5'd26: begin
                sin22   <=  13'b1100000110111;
                cos22   <=  13'b1111000100111;
            end
            5'd27: begin
                sin22   <=  13'b1100000110101;
                cos22   <=  13'b1111000110011;
            end
            5'd28: begin
                sin22   <=  13'b1100000110010;
                cos22   <=  13'b1111000111111;
            end
            5'd29: begin
                sin22   <=  13'b1100000101111;
                cos22   <=  13'b1111001001100;
            end
            5'd30: begin
                sin22   <=  13'b1100000101100;
                cos22   <=  13'b1111001011000;
            end
            5'd31: begin
                sin22   <=  13'b1100000101010;
                cos22   <=  13'b1111001100100;
            end
            default: begin
                sin22   <=  13'd0;
                cos22   <=  13'd0;
            end
        endcase
    end
    else begin
        sin22   <=  sin22;
        cos22   <=  cos22;
    end
end

// Mux32_1: 23
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin23   <=  13'b0;
        cos23   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin23   <=  13'b1100000100111;
                cos23   <=  13'b1111001110000;
            end
            5'd1: begin
                sin23   <=  13'b1100000100101;
                cos23   <=  13'b1111001111101;
            end
            5'd2: begin
                sin23   <=  13'b1100000100011;
                cos23   <=  13'b1111010001001;
            end
            5'd3: begin
                sin23   <=  13'b1100000100000;
                cos23   <=  13'b1111010010101;
            end
            5'd4: begin
                sin23   <=  13'b1100000011110;
                cos23   <=  13'b1111010100010;
            end
            5'd5: begin
                sin23   <=  13'b1100000011100;
                cos23   <=  13'b1111010101110;
            end
            5'd6: begin
                sin23   <=  13'b1100000011010;
                cos23   <=  13'b1111010111011;
            end
            5'd7: begin
                sin23   <=  13'b1100000011000;
                cos23   <=  13'b1111011000111;
            end
            5'd8: begin
                sin23   <=  13'b1100000010110;
                cos23   <=  13'b1111011010011;
            end
            5'd9: begin
                sin23   <=  13'b1100000010100;
                cos23   <=  13'b1111011100000;
            end
            5'd10: begin
                sin23   <=  13'b1100000010011;
                cos23   <=  13'b1111011101100;
            end
            5'd11: begin
                sin23   <=  13'b1100000010001;
                cos23   <=  13'b1111011111001;
            end
            5'd12: begin
                sin23   <=  13'b1100000001111;
                cos23   <=  13'b1111100000101;
            end
            5'd13: begin
                sin23   <=  13'b1100000001110;
                cos23   <=  13'b1111100010010;
            end
            5'd14: begin
                sin23   <=  13'b1100000001100;
                cos23   <=  13'b1111100011110;
            end
            5'd15: begin
                sin23   <=  13'b1100000001011;
                cos23   <=  13'b1111100101011;
            end
            5'd16: begin
                sin23   <=  13'b1100000001010;
                cos23   <=  13'b1111100110111;
            end
            5'd17: begin
                sin23   <=  13'b1100000001001;
                cos23   <=  13'b1111101000100;
            end
            5'd18: begin
                sin23   <=  13'b1100000001000;
                cos23   <=  13'b1111101010000;
            end
            5'd19: begin
                sin23   <=  13'b1100000000111;
                cos23   <=  13'b1111101011101;
            end
            5'd20: begin
                sin23   <=  13'b1100000000110;
                cos23   <=  13'b1111101101001;
            end
            5'd21: begin
                sin23   <=  13'b1100000000101;
                cos23   <=  13'b1111101110110;
            end
            5'd22: begin
                sin23   <=  13'b1100000000100;
                cos23   <=  13'b1111110000010;
            end
            5'd23: begin
                sin23   <=  13'b1100000000011;
                cos23   <=  13'b1111110001111;
            end
            5'd24: begin
                sin23   <=  13'b1100000000010;
                cos23   <=  13'b1111110011100;
            end
            5'd25: begin
                sin23   <=  13'b1100000000010;
                cos23   <=  13'b1111110101000;
            end
            5'd26: begin
                sin23   <=  13'b1100000000001;
                cos23   <=  13'b1111110110101;
            end
            5'd27: begin
                sin23   <=  13'b1100000000001;
                cos23   <=  13'b1111111000001;
            end
            5'd28: begin
                sin23   <=  13'b1100000000001;
                cos23   <=  13'b1111111001110;
            end
            5'd29: begin
                sin23   <=  13'b1100000000000;
                cos23   <=  13'b1111111011010;
            end
            5'd30: begin
                sin23   <=  13'b1100000000000;
                cos23   <=  13'b1111111100111;
            end
            5'd31: begin
                sin23   <=  13'b1100000000000;
                cos23   <=  13'b1111111110011;
            end
            default: begin
                sin23   <=  13'd0;
                cos23   <=  13'd0;
            end
        endcase
    end
    else begin
        sin23   <=  sin23;
        cos23   <=  cos23;
    end
end

// Mux32_1: 24
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin24   <=  13'b0;
        cos24   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin24   <=  13'b1100000000000;
                cos24   <=  13'b0000000000000;
            end
            5'd1: begin
                sin24   <=  13'b1100000000000;
                cos24   <=  13'b0000000001101;
            end
            5'd2: begin
                sin24   <=  13'b1100000000000;
                cos24   <=  13'b0000000011001;
            end
            5'd3: begin
                sin24   <=  13'b1100000000000;
                cos24   <=  13'b0000000100110;
            end
            5'd4: begin
                sin24   <=  13'b1100000000001;
                cos24   <=  13'b0000000110010;
            end
            5'd5: begin
                sin24   <=  13'b1100000000001;
                cos24   <=  13'b0000000111111;
            end
            5'd6: begin
                sin24   <=  13'b1100000000001;
                cos24   <=  13'b0000001001011;
            end
            5'd7: begin
                sin24   <=  13'b1100000000010;
                cos24   <=  13'b0000001011000;
            end
            5'd8: begin
                sin24   <=  13'b1100000000010;
                cos24   <=  13'b0000001100100;
            end
            5'd9: begin
                sin24   <=  13'b1100000000011;
                cos24   <=  13'b0000001110001;
            end
            5'd10: begin
                sin24   <=  13'b1100000000100;
                cos24   <=  13'b0000001111110;
            end
            5'd11: begin
                sin24   <=  13'b1100000000101;
                cos24   <=  13'b0000010001010;
            end
            5'd12: begin
                sin24   <=  13'b1100000000110;
                cos24   <=  13'b0000010010111;
            end
            5'd13: begin
                sin24   <=  13'b1100000000111;
                cos24   <=  13'b0000010100011;
            end
            5'd14: begin
                sin24   <=  13'b1100000001000;
                cos24   <=  13'b0000010110000;
            end
            5'd15: begin
                sin24   <=  13'b1100000001001;
                cos24   <=  13'b0000010111100;
            end
            5'd16: begin
                sin24   <=  13'b1100000001010;
                cos24   <=  13'b0000011001001;
            end
            5'd17: begin
                sin24   <=  13'b1100000001011;
                cos24   <=  13'b0000011010101;
            end
            5'd18: begin
                sin24   <=  13'b1100000001100;
                cos24   <=  13'b0000011100010;
            end
            5'd19: begin
                sin24   <=  13'b1100000001110;
                cos24   <=  13'b0000011101110;
            end
            5'd20: begin
                sin24   <=  13'b1100000001111;
                cos24   <=  13'b0000011111011;
            end
            5'd21: begin
                sin24   <=  13'b1100000010001;
                cos24   <=  13'b0000100000111;
            end
            5'd22: begin
                sin24   <=  13'b1100000010011;
                cos24   <=  13'b0000100010100;
            end
            5'd23: begin
                sin24   <=  13'b1100000010100;
                cos24   <=  13'b0000100100000;
            end
            5'd24: begin
                sin24   <=  13'b1100000010110;
                cos24   <=  13'b0000100101101;
            end
            5'd25: begin
                sin24   <=  13'b1100000011000;
                cos24   <=  13'b0000100111001;
            end
            5'd26: begin
                sin24   <=  13'b1100000011010;
                cos24   <=  13'b0000101000101;
            end
            5'd27: begin
                sin24   <=  13'b1100000011100;
                cos24   <=  13'b0000101010010;
            end
            5'd28: begin
                sin24   <=  13'b1100000011110;
                cos24   <=  13'b0000101011110;
            end
            5'd29: begin
                sin24   <=  13'b1100000100000;
                cos24   <=  13'b0000101101011;
            end
            5'd30: begin
                sin24   <=  13'b1100000100011;
                cos24   <=  13'b0000101110111;
            end
            5'd31: begin
                sin24   <=  13'b1100000100101;
                cos24   <=  13'b0000110000011;
            end
            default: begin
                sin24   <=  13'd0;
                cos24   <=  13'd0;
            end
        endcase
    end
    else begin
        sin24   <=  sin24;
        cos24   <=  cos24;
    end
end

// Mux32_1: 25
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin25   <=  13'b0;
        cos25   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin25   <=  13'b1100000100111;
                cos25   <=  13'b0000110010000;
            end
            5'd1: begin
                sin25   <=  13'b1100000101010;
                cos25   <=  13'b0000110011100;
            end
            5'd2: begin
                sin25   <=  13'b1100000101100;
                cos25   <=  13'b0000110101000;
            end
            5'd3: begin
                sin25   <=  13'b1100000101111;
                cos25   <=  13'b0000110110100;
            end
            5'd4: begin
                sin25   <=  13'b1100000110010;
                cos25   <=  13'b0000111000001;
            end
            5'd5: begin
                sin25   <=  13'b1100000110101;
                cos25   <=  13'b0000111001101;
            end
            5'd6: begin
                sin25   <=  13'b1100000110111;
                cos25   <=  13'b0000111011001;
            end
            5'd7: begin
                sin25   <=  13'b1100000111010;
                cos25   <=  13'b0000111100101;
            end
            5'd8: begin
                sin25   <=  13'b1100000111101;
                cos25   <=  13'b0000111110010;
            end
            5'd9: begin
                sin25   <=  13'b1100001000000;
                cos25   <=  13'b0000111111110;
            end
            5'd10: begin
                sin25   <=  13'b1100001000100;
                cos25   <=  13'b0001000001010;
            end
            5'd11: begin
                sin25   <=  13'b1100001000111;
                cos25   <=  13'b0001000010110;
            end
            5'd12: begin
                sin25   <=  13'b1100001001010;
                cos25   <=  13'b0001000100010;
            end
            5'd13: begin
                sin25   <=  13'b1100001001110;
                cos25   <=  13'b0001000101110;
            end
            5'd14: begin
                sin25   <=  13'b1100001010001;
                cos25   <=  13'b0001000111010;
            end
            5'd15: begin
                sin25   <=  13'b1100001010101;
                cos25   <=  13'b0001001000110;
            end
            5'd16: begin
                sin25   <=  13'b1100001011000;
                cos25   <=  13'b0001001010011;
            end
            5'd17: begin
                sin25   <=  13'b1100001011100;
                cos25   <=  13'b0001001011111;
            end
            5'd18: begin
                sin25   <=  13'b1100001100000;
                cos25   <=  13'b0001001101011;
            end
            5'd19: begin
                sin25   <=  13'b1100001100011;
                cos25   <=  13'b0001001110110;
            end
            5'd20: begin
                sin25   <=  13'b1100001100111;
                cos25   <=  13'b0001010000010;
            end
            5'd21: begin
                sin25   <=  13'b1100001101011;
                cos25   <=  13'b0001010001110;
            end
            5'd22: begin
                sin25   <=  13'b1100001101111;
                cos25   <=  13'b0001010011010;
            end
            5'd23: begin
                sin25   <=  13'b1100001110100;
                cos25   <=  13'b0001010100110;
            end
            5'd24: begin
                sin25   <=  13'b1100001111000;
                cos25   <=  13'b0001010110010;
            end
            5'd25: begin
                sin25   <=  13'b1100001111100;
                cos25   <=  13'b0001010111110;
            end
            5'd26: begin
                sin25   <=  13'b1100010000000;
                cos25   <=  13'b0001011001010;
            end
            5'd27: begin
                sin25   <=  13'b1100010000101;
                cos25   <=  13'b0001011010101;
            end
            5'd28: begin
                sin25   <=  13'b1100010001001;
                cos25   <=  13'b0001011100001;
            end
            5'd29: begin
                sin25   <=  13'b1100010001110;
                cos25   <=  13'b0001011101101;
            end
            5'd30: begin
                sin25   <=  13'b1100010010010;
                cos25   <=  13'b0001011111000;
            end
            5'd31: begin
                sin25   <=  13'b1100010010111;
                cos25   <=  13'b0001100000100;
            end
            default: begin
                sin25   <=  13'd0;
                cos25   <=  13'd0;
            end
        endcase
    end
    else begin
        sin25   <=  sin25;
        cos25   <=  cos25;
    end
end

// Mux32_1: 26
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin26   <=  13'b0;
        cos26   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin26   <=  13'b1100010011100;
                cos26   <=  13'b0001100010000;
            end
            5'd1: begin
                sin26   <=  13'b1100010100001;
                cos26   <=  13'b0001100011011;
            end
            5'd2: begin
                sin26   <=  13'b1100010100110;
                cos26   <=  13'b0001100100111;
            end
            5'd3: begin
                sin26   <=  13'b1100010101011;
                cos26   <=  13'b0001100110010;
            end
            5'd4: begin
                sin26   <=  13'b1100010110000;
                cos26   <=  13'b0001100111110;
            end
            5'd5: begin
                sin26   <=  13'b1100010110101;
                cos26   <=  13'b0001101001001;
            end
            5'd6: begin
                sin26   <=  13'b1100010111010;
                cos26   <=  13'b0001101010101;
            end
            5'd7: begin
                sin26   <=  13'b1100010111111;
                cos26   <=  13'b0001101100000;
            end
            5'd8: begin
                sin26   <=  13'b1100011000101;
                cos26   <=  13'b0001101101100;
            end
            5'd9: begin
                sin26   <=  13'b1100011001010;
                cos26   <=  13'b0001101110111;
            end
            5'd10: begin
                sin26   <=  13'b1100011010000;
                cos26   <=  13'b0001110000010;
            end
            5'd11: begin
                sin26   <=  13'b1100011010101;
                cos26   <=  13'b0001110001110;
            end
            5'd12: begin
                sin26   <=  13'b1100011011011;
                cos26   <=  13'b0001110011001;
            end
            5'd13: begin
                sin26   <=  13'b1100011100000;
                cos26   <=  13'b0001110100100;
            end
            5'd14: begin
                sin26   <=  13'b1100011100110;
                cos26   <=  13'b0001110101111;
            end
            5'd15: begin
                sin26   <=  13'b1100011101100;
                cos26   <=  13'b0001110111010;
            end
            5'd16: begin
                sin26   <=  13'b1100011110010;
                cos26   <=  13'b0001111000101;
            end
            5'd17: begin
                sin26   <=  13'b1100011111000;
                cos26   <=  13'b0001111010000;
            end
            5'd18: begin
                sin26   <=  13'b1100011111110;
                cos26   <=  13'b0001111011100;
            end
            5'd19: begin
                sin26   <=  13'b1100100000100;
                cos26   <=  13'b0001111100111;
            end
            5'd20: begin
                sin26   <=  13'b1100100001010;
                cos26   <=  13'b0001111110001;
            end
            5'd21: begin
                sin26   <=  13'b1100100010000;
                cos26   <=  13'b0001111111100;
            end
            5'd22: begin
                sin26   <=  13'b1100100010111;
                cos26   <=  13'b0010000000111;
            end
            5'd23: begin
                sin26   <=  13'b1100100011101;
                cos26   <=  13'b0010000010010;
            end
            5'd24: begin
                sin26   <=  13'b1100100100011;
                cos26   <=  13'b0010000011101;
            end
            5'd25: begin
                sin26   <=  13'b1100100101010;
                cos26   <=  13'b0010000101000;
            end
            5'd26: begin
                sin26   <=  13'b1100100110000;
                cos26   <=  13'b0010000110010;
            end
            5'd27: begin
                sin26   <=  13'b1100100110111;
                cos26   <=  13'b0010000111101;
            end
            5'd28: begin
                sin26   <=  13'b1100100111110;
                cos26   <=  13'b0010001001000;
            end
            5'd29: begin
                sin26   <=  13'b1100101000100;
                cos26   <=  13'b0010001010010;
            end
            5'd30: begin
                sin26   <=  13'b1100101001011;
                cos26   <=  13'b0010001011101;
            end
            5'd31: begin
                sin26   <=  13'b1100101010010;
                cos26   <=  13'b0010001100111;
            end
            default: begin
                sin26   <=  13'd0;
                cos26   <=  13'd0;
            end
        endcase
    end
    else begin
        sin26   <=  sin26;
        cos26   <=  cos26;
    end
end

// Mux32_1: 27
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin27   <=  13'b0;
        cos27   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin27   <=  13'b1100101011001;
                cos27   <=  13'b0010001110010;
            end
            5'd1: begin
                sin27   <=  13'b1100101100000;
                cos27   <=  13'b0010001111100;
            end
            5'd2: begin
                sin27   <=  13'b1100101100111;
                cos27   <=  13'b0010010000111;
            end
            5'd3: begin
                sin27   <=  13'b1100101101110;
                cos27   <=  13'b0010010010001;
            end
            5'd4: begin
                sin27   <=  13'b1100101110110;
                cos27   <=  13'b0010010011011;
            end
            5'd5: begin
                sin27   <=  13'b1100101111101;
                cos27   <=  13'b0010010100110;
            end
            5'd6: begin
                sin27   <=  13'b1100110000100;
                cos27   <=  13'b0010010110000;
            end
            5'd7: begin
                sin27   <=  13'b1100110001100;
                cos27   <=  13'b0010010111010;
            end
            5'd8: begin
                sin27   <=  13'b1100110010011;
                cos27   <=  13'b0010011000100;
            end
            5'd9: begin
                sin27   <=  13'b1100110011011;
                cos27   <=  13'b0010011001110;
            end
            5'd10: begin
                sin27   <=  13'b1100110100010;
                cos27   <=  13'b0010011011000;
            end
            5'd11: begin
                sin27   <=  13'b1100110101010;
                cos27   <=  13'b0010011100010;
            end
            5'd12: begin
                sin27   <=  13'b1100110110001;
                cos27   <=  13'b0010011101100;
            end
            5'd13: begin
                sin27   <=  13'b1100110111001;
                cos27   <=  13'b0010011110110;
            end
            5'd14: begin
                sin27   <=  13'b1100111000001;
                cos27   <=  13'b0010100000000;
            end
            5'd15: begin
                sin27   <=  13'b1100111001001;
                cos27   <=  13'b0010100001001;
            end
            5'd16: begin
                sin27   <=  13'b1100111010001;
                cos27   <=  13'b0010100010011;
            end
            5'd17: begin
                sin27   <=  13'b1100111011001;
                cos27   <=  13'b0010100011101;
            end
            5'd18: begin
                sin27   <=  13'b1100111100001;
                cos27   <=  13'b0010100100111;
            end
            5'd19: begin
                sin27   <=  13'b1100111101001;
                cos27   <=  13'b0010100110000;
            end
            5'd20: begin
                sin27   <=  13'b1100111110001;
                cos27   <=  13'b0010100111010;
            end
            5'd21: begin
                sin27   <=  13'b1100111111001;
                cos27   <=  13'b0010101000011;
            end
            5'd22: begin
                sin27   <=  13'b1101000000010;
                cos27   <=  13'b0010101001101;
            end
            5'd23: begin
                sin27   <=  13'b1101000001010;
                cos27   <=  13'b0010101010110;
            end
            5'd24: begin
                sin27   <=  13'b1101000010011;
                cos27   <=  13'b0010101011111;
            end
            5'd25: begin
                sin27   <=  13'b1101000011011;
                cos27   <=  13'b0010101101001;
            end
            5'd26: begin
                sin27   <=  13'b1101000100100;
                cos27   <=  13'b0010101110010;
            end
            5'd27: begin
                sin27   <=  13'b1101000101100;
                cos27   <=  13'b0010101111011;
            end
            5'd28: begin
                sin27   <=  13'b1101000110101;
                cos27   <=  13'b0010110000100;
            end
            5'd29: begin
                sin27   <=  13'b1101000111101;
                cos27   <=  13'b0010110001101;
            end
            5'd30: begin
                sin27   <=  13'b1101001000110;
                cos27   <=  13'b0010110010110;
            end
            5'd31: begin
                sin27   <=  13'b1101001001111;
                cos27   <=  13'b0010110011111;
            end
            default: begin
                sin27   <=  13'd0;
                cos27   <=  13'd0;
            end
        endcase
    end
    else begin
        sin27   <=  sin27;
        cos27   <=  cos27;
    end
end

// Mux32_1: 28
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin28   <=  13'b0;
        cos28   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin28   <=  13'b1101001011000;
                cos28   <=  13'b0010110101000;
            end
            5'd1: begin
                sin28   <=  13'b1101001100001;
                cos28   <=  13'b0010110110001;
            end
            5'd2: begin
                sin28   <=  13'b1101001101010;
                cos28   <=  13'b0010110111010;
            end
            5'd3: begin
                sin28   <=  13'b1101001110011;
                cos28   <=  13'b0010111000011;
            end
            5'd4: begin
                sin28   <=  13'b1101001111100;
                cos28   <=  13'b0010111001011;
            end
            5'd5: begin
                sin28   <=  13'b1101010000101;
                cos28   <=  13'b0010111010100;
            end
            5'd6: begin
                sin28   <=  13'b1101010001110;
                cos28   <=  13'b0010111011100;
            end
            5'd7: begin
                sin28   <=  13'b1101010010111;
                cos28   <=  13'b0010111100101;
            end
            5'd8: begin
                sin28   <=  13'b1101010100001;
                cos28   <=  13'b0010111101101;
            end
            5'd9: begin
                sin28   <=  13'b1101010101010;
                cos28   <=  13'b0010111110110;
            end
            5'd10: begin
                sin28   <=  13'b1101010110011;
                cos28   <=  13'b0010111111110;
            end
            5'd11: begin
                sin28   <=  13'b1101010111101;
                cos28   <=  13'b0011000000111;
            end
            5'd12: begin
                sin28   <=  13'b1101011000110;
                cos28   <=  13'b0011000001111;
            end
            5'd13: begin
                sin28   <=  13'b1101011010000;
                cos28   <=  13'b0011000010111;
            end
            5'd14: begin
                sin28   <=  13'b1101011011001;
                cos28   <=  13'b0011000011111;
            end
            5'd15: begin
                sin28   <=  13'b1101011100011;
                cos28   <=  13'b0011000100111;
            end
            5'd16: begin
                sin28   <=  13'b1101011101101;
                cos28   <=  13'b0011000101111;
            end
            5'd17: begin
                sin28   <=  13'b1101011110111;
                cos28   <=  13'b0011000110111;
            end
            5'd18: begin
                sin28   <=  13'b1101100000000;
                cos28   <=  13'b0011000111111;
            end
            5'd19: begin
                sin28   <=  13'b1101100001010;
                cos28   <=  13'b0011001000111;
            end
            5'd20: begin
                sin28   <=  13'b1101100010100;
                cos28   <=  13'b0011001001111;
            end
            5'd21: begin
                sin28   <=  13'b1101100011110;
                cos28   <=  13'b0011001010110;
            end
            5'd22: begin
                sin28   <=  13'b1101100101000;
                cos28   <=  13'b0011001011110;
            end
            5'd23: begin
                sin28   <=  13'b1101100110010;
                cos28   <=  13'b0011001100101;
            end
            5'd24: begin
                sin28   <=  13'b1101100111100;
                cos28   <=  13'b0011001101101;
            end
            5'd25: begin
                sin28   <=  13'b1101101000110;
                cos28   <=  13'b0011001110100;
            end
            5'd26: begin
                sin28   <=  13'b1101101010000;
                cos28   <=  13'b0011001111100;
            end
            5'd27: begin
                sin28   <=  13'b1101101011010;
                cos28   <=  13'b0011010000011;
            end
            5'd28: begin
                sin28   <=  13'b1101101100101;
                cos28   <=  13'b0011010001010;
            end
            5'd29: begin
                sin28   <=  13'b1101101101111;
                cos28   <=  13'b0011010010010;
            end
            5'd30: begin
                sin28   <=  13'b1101101111001;
                cos28   <=  13'b0011010011001;
            end
            5'd31: begin
                sin28   <=  13'b1101110000100;
                cos28   <=  13'b0011010100000;
            end
            default: begin
                sin28   <=  13'd0;
                cos28   <=  13'd0;
            end
        endcase
    end
    else begin
        sin28   <=  sin28;
        cos28   <=  cos28;
    end
end

// Mux32_1: 29
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin29   <=  13'b0;
        cos29   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin29   <=  13'b1101110001110;
                cos29   <=  13'b0011010100111;
            end
            5'd1: begin
                sin29   <=  13'b1101110011001;
                cos29   <=  13'b0011010101110;
            end
            5'd2: begin
                sin29   <=  13'b1101110100011;
                cos29   <=  13'b0011010110101;
            end
            5'd3: begin
                sin29   <=  13'b1101110101110;
                cos29   <=  13'b0011010111100;
            end
            5'd4: begin
                sin29   <=  13'b1101110111000;
                cos29   <=  13'b0011011000010;
            end
            5'd5: begin
                sin29   <=  13'b1101111000011;
                cos29   <=  13'b0011011001001;
            end
            5'd6: begin
                sin29   <=  13'b1101111001110;
                cos29   <=  13'b0011011010000;
            end
            5'd7: begin
                sin29   <=  13'b1101111011000;
                cos29   <=  13'b0011011010110;
            end
            5'd8: begin
                sin29   <=  13'b1101111100011;
                cos29   <=  13'b0011011011101;
            end
            5'd9: begin
                sin29   <=  13'b1101111101110;
                cos29   <=  13'b0011011100011;
            end
            5'd10: begin
                sin29   <=  13'b1101111111001;
                cos29   <=  13'b0011011101001;
            end
            5'd11: begin
                sin29   <=  13'b1110000000100;
                cos29   <=  13'b0011011110000;
            end
            5'd12: begin
                sin29   <=  13'b1110000001111;
                cos29   <=  13'b0011011110110;
            end
            5'd13: begin
                sin29   <=  13'b1110000011001;
                cos29   <=  13'b0011011111100;
            end
            5'd14: begin
                sin29   <=  13'b1110000100100;
                cos29   <=  13'b0011100000010;
            end
            5'd15: begin
                sin29   <=  13'b1110000110000;
                cos29   <=  13'b0011100001000;
            end
            5'd16: begin
                sin29   <=  13'b1110000111011;
                cos29   <=  13'b0011100001110;
            end
            5'd17: begin
                sin29   <=  13'b1110001000110;
                cos29   <=  13'b0011100010100;
            end
            5'd18: begin
                sin29   <=  13'b1110001010001;
                cos29   <=  13'b0011100011010;
            end
            5'd19: begin
                sin29   <=  13'b1110001011100;
                cos29   <=  13'b0011100100000;
            end
            5'd20: begin
                sin29   <=  13'b1110001100111;
                cos29   <=  13'b0011100100101;
            end
            5'd21: begin
                sin29   <=  13'b1110001110010;
                cos29   <=  13'b0011100101011;
            end
            5'd22: begin
                sin29   <=  13'b1110001111110;
                cos29   <=  13'b0011100110000;
            end
            5'd23: begin
                sin29   <=  13'b1110010001001;
                cos29   <=  13'b0011100110110;
            end
            5'd24: begin
                sin29   <=  13'b1110010010100;
                cos29   <=  13'b0011100111011;
            end
            5'd25: begin
                sin29   <=  13'b1110010100000;
                cos29   <=  13'b0011101000001;
            end
            5'd26: begin
                sin29   <=  13'b1110010101011;
                cos29   <=  13'b0011101000110;
            end
            5'd27: begin
                sin29   <=  13'b1110010110111;
                cos29   <=  13'b0011101001011;
            end
            5'd28: begin
                sin29   <=  13'b1110011000010;
                cos29   <=  13'b0011101010000;
            end
            5'd29: begin
                sin29   <=  13'b1110011001110;
                cos29   <=  13'b0011101010101;
            end
            5'd30: begin
                sin29   <=  13'b1110011011001;
                cos29   <=  13'b0011101011010;
            end
            5'd31: begin
                sin29   <=  13'b1110011100101;
                cos29   <=  13'b0011101011111;
            end
            default: begin
                sin29   <=  13'd0;
                cos29   <=  13'd0;
            end
        endcase
    end
    else begin
        sin29   <=  sin29;
        cos29   <=  cos29;
    end
end

// Mux32_1: 30
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin30   <=  13'b0;
        cos30   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin30   <=  13'b1110011110000;
                cos30   <=  13'b0011101100100;
            end
            5'd1: begin
                sin30   <=  13'b1110011111100;
                cos30   <=  13'b0011101101001;
            end
            5'd2: begin
                sin30   <=  13'b1110100001000;
                cos30   <=  13'b0011101101110;
            end
            5'd3: begin
                sin30   <=  13'b1110100010011;
                cos30   <=  13'b0011101110010;
            end
            5'd4: begin
                sin30   <=  13'b1110100011111;
                cos30   <=  13'b0011101110111;
            end
            5'd5: begin
                sin30   <=  13'b1110100101011;
                cos30   <=  13'b0011101111011;
            end
            5'd6: begin
                sin30   <=  13'b1110100110110;
                cos30   <=  13'b0011110000000;
            end
            5'd7: begin
                sin30   <=  13'b1110101000010;
                cos30   <=  13'b0011110000100;
            end
            5'd8: begin
                sin30   <=  13'b1110101001110;
                cos30   <=  13'b0011110001000;
            end
            5'd9: begin
                sin30   <=  13'b1110101011010;
                cos30   <=  13'b0011110001100;
            end
            5'd10: begin
                sin30   <=  13'b1110101100110;
                cos30   <=  13'b0011110010001;
            end
            5'd11: begin
                sin30   <=  13'b1110101110010;
                cos30   <=  13'b0011110010101;
            end
            5'd12: begin
                sin30   <=  13'b1110101111110;
                cos30   <=  13'b0011110011001;
            end
            5'd13: begin
                sin30   <=  13'b1110110001010;
                cos30   <=  13'b0011110011101;
            end
            5'd14: begin
                sin30   <=  13'b1110110010101;
                cos30   <=  13'b0011110100000;
            end
            5'd15: begin
                sin30   <=  13'b1110110100001;
                cos30   <=  13'b0011110100100;
            end
            5'd16: begin
                sin30   <=  13'b1110110101101;
                cos30   <=  13'b0011110101000;
            end
            5'd17: begin
                sin30   <=  13'b1110110111010;
                cos30   <=  13'b0011110101011;
            end
            5'd18: begin
                sin30   <=  13'b1110111000110;
                cos30   <=  13'b0011110101111;
            end
            5'd19: begin
                sin30   <=  13'b1110111010010;
                cos30   <=  13'b0011110110010;
            end
            5'd20: begin
                sin30   <=  13'b1110111011110;
                cos30   <=  13'b0011110110110;
            end
            5'd21: begin
                sin30   <=  13'b1110111101010;
                cos30   <=  13'b0011110111001;
            end
            5'd22: begin
                sin30   <=  13'b1110111110110;
                cos30   <=  13'b0011110111100;
            end
            5'd23: begin
                sin30   <=  13'b1111000000010;
                cos30   <=  13'b0011111000000;
            end
            5'd24: begin
                sin30   <=  13'b1111000001110;
                cos30   <=  13'b0011111000011;
            end
            5'd25: begin
                sin30   <=  13'b1111000011011;
                cos30   <=  13'b0011111000110;
            end
            5'd26: begin
                sin30   <=  13'b1111000100111;
                cos30   <=  13'b0011111001001;
            end
            5'd27: begin
                sin30   <=  13'b1111000110011;
                cos30   <=  13'b0011111001011;
            end
            5'd28: begin
                sin30   <=  13'b1111000111111;
                cos30   <=  13'b0011111001110;
            end
            5'd29: begin
                sin30   <=  13'b1111001001100;
                cos30   <=  13'b0011111010001;
            end
            5'd30: begin
                sin30   <=  13'b1111001011000;
                cos30   <=  13'b0011111010100;
            end
            5'd31: begin
                sin30   <=  13'b1111001100100;
                cos30   <=  13'b0011111010110;
            end
            default: begin
                sin30   <=  13'd0;
                cos30   <=  13'd0;
            end
        endcase
    end
    else begin
        sin30   <=  sin30;
        cos30   <=  cos30;
    end
end

// Mux32_1: 31
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin31   <=  13'b0;
        cos31   <=  13'b0;
    end
    else if(trig) begin
        case(data_in[4:0])
            5'd0: begin
                sin31   <=  13'b1111001110000;
                cos31   <=  13'b0011111011001;
            end
            5'd1: begin
                sin31   <=  13'b1111001111101;
                cos31   <=  13'b0011111011011;
            end
            5'd2: begin
                sin31   <=  13'b1111010001001;
                cos31   <=  13'b0011111011101;
            end
            5'd3: begin
                sin31   <=  13'b1111010010101;
                cos31   <=  13'b0011111100000;
            end
            5'd4: begin
                sin31   <=  13'b1111010100010;
                cos31   <=  13'b0011111100010;
            end
            5'd5: begin
                sin31   <=  13'b1111010101110;
                cos31   <=  13'b0011111100100;
            end
            5'd6: begin
                sin31   <=  13'b1111010111011;
                cos31   <=  13'b0011111100110;
            end
            5'd7: begin
                sin31   <=  13'b1111011000111;
                cos31   <=  13'b0011111101000;
            end
            5'd8: begin
                sin31   <=  13'b1111011010011;
                cos31   <=  13'b0011111101010;
            end
            5'd9: begin
                sin31   <=  13'b1111011100000;
                cos31   <=  13'b0011111101100;
            end
            5'd10: begin
                sin31   <=  13'b1111011101100;
                cos31   <=  13'b0011111101101;
            end
            5'd11: begin
                sin31   <=  13'b1111011111001;
                cos31   <=  13'b0011111101111;
            end
            5'd12: begin
                sin31   <=  13'b1111100000101;
                cos31   <=  13'b0011111110001;
            end
            5'd13: begin
                sin31   <=  13'b1111100010010;
                cos31   <=  13'b0011111110010;
            end
            5'd14: begin
                sin31   <=  13'b1111100011110;
                cos31   <=  13'b0011111110100;
            end
            5'd15: begin
                sin31   <=  13'b1111100101011;
                cos31   <=  13'b0011111110101;
            end
            5'd16: begin
                sin31   <=  13'b1111100110111;
                cos31   <=  13'b0011111110110;
            end
            5'd17: begin
                sin31   <=  13'b1111101000100;
                cos31   <=  13'b0011111110111;
            end
            5'd18: begin
                sin31   <=  13'b1111101010000;
                cos31   <=  13'b0011111111000;
            end
            5'd19: begin
                sin31   <=  13'b1111101011101;
                cos31   <=  13'b0011111111001;
            end
            5'd20: begin
                sin31   <=  13'b1111101101001;
                cos31   <=  13'b0011111111010;
            end
            5'd21: begin
                sin31   <=  13'b1111101110110;
                cos31   <=  13'b0011111111011;
            end
            5'd22: begin
                sin31   <=  13'b1111110000010;
                cos31   <=  13'b0011111111100;
            end
            5'd23: begin
                sin31   <=  13'b1111110001111;
                cos31   <=  13'b0011111111101;
            end
            5'd24: begin
                sin31   <=  13'b1111110011100;
                cos31   <=  13'b0011111111110;
            end
            5'd25: begin
                sin31   <=  13'b1111110101000;
                cos31   <=  13'b0011111111110;
            end
            5'd26: begin
                sin31   <=  13'b1111110110101;
                cos31   <=  13'b0011111111111;
            end
            5'd27: begin
                sin31   <=  13'b1111111000001;
                cos31   <=  13'b0011111111111;
            end
            5'd28: begin
                sin31   <=  13'b1111111001110;
                cos31   <=  13'b0011111111111;
            end
            5'd29: begin
                sin31   <=  13'b1111111011010;
                cos31   <=  13'b0100000000000;
            end
            5'd30: begin
                sin31   <=  13'b1111111100111;
                cos31   <=  13'b0100000000000;
            end
            5'd31: begin
                sin31   <=  13'b1111111110011;
                cos31   <=  13'b0100000000000;
            end
            default: begin
                sin31   <=  13'd0;
                cos31   <=  13'd0;
            end
        endcase
    end
    else begin
        sin31   <=  sin31;
        cos31   <=  cos31;
    end
end

// finial Mux32_1
always@(posedge sys_clk or negedge sys_rst_n) begin
    if(~sys_rst_n) begin
        sin_out <=  13'b0;
        cos_out <=  13'b0;
    end
    else if(trig_reg) begin
        case(data_in_reg[9:5])
            5'd0: begin
                sin_out <=  sin0;
                cos_out <=  cos0;
            end
            5'd1: begin
                sin_out <=  sin1;
                cos_out <=  cos1;
            end
            5'd2: begin
                sin_out <=  sin2;
                cos_out <=  cos2;
            end
            5'd3: begin
                sin_out <=  sin3;
                cos_out <=  cos3;
            end
            5'd4: begin
                sin_out <=  sin4;
                cos_out <=  cos4;
            end
            5'd5: begin
                sin_out <=  sin5;
                cos_out <=  cos5;
            end
            5'd6: begin
                sin_out <=  sin6;
                cos_out <=  cos6;
            end
            5'd7: begin
                sin_out <=  sin7;
                cos_out <=  cos7;
            end
            5'd8: begin
                sin_out <=  sin8;
                cos_out <=  cos8;
            end
            5'd9: begin
                sin_out <=  sin9;
                cos_out <=  cos9;
            end
            5'd10: begin
                sin_out <=  sin10;
                cos_out <=  cos10;
            end
            5'd11: begin
                sin_out <=  sin11;
                cos_out <=  cos11;
            end
            5'd12: begin
                sin_out <=  sin12;
                cos_out <=  cos12;
            end
            5'd13: begin
                sin_out <=  sin13;
                cos_out <=  cos13;
            end
            5'd14: begin
                sin_out <=  sin14;
                cos_out <=  cos14;
            end
            5'd15: begin
                sin_out <=  sin15;
                cos_out <=  cos15;
            end
            5'd16: begin
                sin_out <=  sin16;
                cos_out <=  cos16;
            end
            5'd17: begin
                sin_out <=  sin17;
                cos_out <=  cos17;
            end
            5'd18: begin
                sin_out <=  sin18;
                cos_out <=  cos18;
            end
            5'd19: begin
                sin_out <=  sin19;
                cos_out <=  cos19;
            end
            5'd20: begin
                sin_out <=  sin20;
                cos_out <=  cos20;
            end
            5'd21: begin
                sin_out <=  sin21;
                cos_out <=  cos21;
            end
            5'd22: begin
                sin_out <=  sin22;
                cos_out <=  cos22;
            end
            5'd23: begin
                sin_out <=  sin23;
                cos_out <=  cos23;
            end
            5'd24: begin
                sin_out <=  sin24;
                cos_out <=  cos24;
            end
            5'd25: begin
                sin_out <=  sin25;
                cos_out <=  cos25;
            end
            5'd26: begin
                sin_out <=  sin26;
                cos_out <=  cos26;
            end
            5'd27: begin
                sin_out <=  sin27;
                cos_out <=  cos27;
            end
            5'd28: begin
                sin_out <=  sin28;
                cos_out <=  cos28;
            end
            5'd29: begin
                sin_out <=  sin29;
                cos_out <=  cos29;
            end
            5'd30: begin
                sin_out <=  sin30;
                cos_out <=  cos30;
            end
            5'd31: begin
                sin_out <=  sin31;
                cos_out <=  cos31;
            end
            default: begin
                sin_out <=  13'd0;
                cos_out <=  13'd0;
            end
        endcase
    end
end


endmodule
