`timescale 1ns/100ps
module tb_gray_cnt;

parameter SIZE = 4;

logic 				clk;
logic 				rst_n;
logic				en;
logic	[SIZE-1:0]	cnt;

gray_cnt #(
	.SIZE	(SIZE)
) gray_cnt_u1 (
	.clk	(clk),
	.rst_n	(rst_n),
	.en		(en),
	.cnt	(cnt)
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
	en = 1'b1;
	#20 en = 1'b0;
	#100 rst_n = 1'b1;
	#100 en = 1'b1;
	#200 en = 1'b0;
	#100;
	$finish;
end

endmodule
