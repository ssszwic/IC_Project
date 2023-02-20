`timescale 1ns/100ps
module tb_ram;

parameter   WIDTH = 8,
            DEPTH = 4;

logic                   clk;
logic                   rst_n;
logic                   wr_en;
logic   [DEPTH-1:0]     wr_addr;
logic   [DEPTH-1:0]     rd_addr;
logic   [WIDTH-1:0]     wr_data;
logic   [WIDTH-1:0]     rd_data;

int                     seed;
int                     i;

ram #(
    .WIDTH      (WIDTH),
    .DEPTH      (DEPTH)
) ram_u1 (
    .clk        (clk),
    .rst_n      (rst_n),
    .wr_en      (wr_en),
    .wr_addr    (wr_addr),
    .rd_addr    (rd_addr),
    .wr_data    (wr_data),
    .rd_data    (rd_data)
);

initial begin
    if(!$value$plusargs("seed=%d", seed)) begin
        seed = 100;
    end
    $srandom(seed);

    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0);
end

initial begin
    clk = 1'b1;
    forever #10 clk = ~clk;
end

// write test
initial begin
    rst_n = 1'b0;
    wr_en = 1'b0;
    wr_addr = 0;
    rd_addr = 0;
    wr_data = 0;
    #100;
    rst_n = 1'b1;
    #20;

    for(i = 0; i < 2**DEPTH; i = i + 1) begin
        @(posedge clk);
        #1;
        wr_en = 1'b1;
        wr_addr = i;
        wr_data = {$random(seed)} % (2**WIDTH);
        @(posedge clk);
        #1;
        wr_en = 1'b0;
        wr_addr = 0;
        wr_data = 0;
    end

    // read test
    repeat(100) begin
        #20 rd_addr = {$random(seed)} % (2**DEPTH);
    end
    #100 $finish; 
end

endmodule


