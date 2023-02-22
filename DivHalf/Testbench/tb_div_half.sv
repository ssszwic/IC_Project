`timescale 1ns/100ps
module tb_div_half;

logic clk;
logic rst_n;
logic clk_out;

div_half #(
    .NUM            (4.5            )
) div_half_u (
    .clk            (clk            ), // i 1b 
    .rst_n          (rst_n          ), // i 1b 
    .clk_out        (clk_out        )  // o 1b 
);

initial begin
    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0);
end

initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;
end

initial begin
    rst_n = 1'b0;
    #100;
    rst_n = 1'b1;
    #10000;
    $finish;
end

endmodule
