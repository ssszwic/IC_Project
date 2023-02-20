module ram #(
    parameter   WIDTH = 8,
                DEPTH = 4
) (
    // system
    input                       clk,
    input                       rst_n,
    // control
    input                       wr_en,
    input       [DEPTH-1:0]     wr_addr,
    input       [DEPTH-1:0]     rd_addr,
    // data
    input       [WIDTH-1:0]     wr_data,
    output      [WIDTH-1:0]     rd_data
);

reg     [WIDTH-1:0] memory [0:2**DEPTH-1];
integer i;

always@(posedge clk or negedge rst_n) begin
    for(i = 0; i < 2**DEPTH; i = i + 1) begin
        if(~rst_n) begin
            memory[i] <= {WIDTH{1'b0}};
        end
        else if(wr_en && (wr_addr == i)) begin
            memory[i] <= wr_data;
        end
        else begin
            memory[i] <= memory[i];
        end
    end
end

assign rd_data = memory[rd_addr];

endmodule
