module div_half #(
    parameter   NUM = 4.5 // NUM.5 div, NUM > 1
) (
    // sys
    input               clk,
    input               rst_n,
    output              clk_out
);

localparam NUM_INT = integer'($floor(NUM));
localparam LEN = NUM_INT * 2 + 1; // twice the number of divisions

reg     [LEN-1:0]       sr;
reg                     sr1;
reg                     sr2;
reg                     sr3;

always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        sr <= {{{LEN-1}{1'b0}}, 1'b1};
    end
    else begin
        // ring shifter
        sr <= {sr[LEN-2:0], sr[LEN-1]};
    end
end

always@(negedge clk or negedge rst_n) begin
    if(~rst_n) begin
        sr1 <= 1'b0;
        sr2 <= 1'b0;
        sr3 <= 1'b0;
    end
    else begin
        sr1 <= sr[0];
        sr2 <= sr[NUM_INT];
        sr3 <= sr[NUM_INT+1];
    end
end

assign clk_out = (sr1 | sr[0] | sr[1]) | (sr2 | sr3 | sr[NUM_INT+1]);

endmodule
