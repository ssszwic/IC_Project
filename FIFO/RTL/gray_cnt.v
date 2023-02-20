module gray_cnt #(
	parameter SIZE = 4
) (
	input					clk,
	input					rst_n,
	input					en,
	output	reg	[SIZE-1:0]	cnt
);

wire	[SIZE-1:0]	cnt_bin;
wire	[SIZE-1:0]	cnt_bin_plus;
wire	[SIZE-1:0]	cnt_gray_plus;

gray_to_bin	#(
	.SIZE	(SIZE)
) gray_to_bin_u1 (
	.gray	(cnt),
	.bin	(cnt_bin)
);

assign cnt_bin_plus = cnt_bin + 1'b1;

bin_to_gray #(
	.SIZE	(SIZE)
) bin_to_gray_u1 (
	.bin	(cnt_bin_plus),
	.gray	(cnt_gray_plus)
);

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		cnt <= {SIZE{1'b0}};
	end
	else if(en) begin
		cnt <= cnt_gray_plus;
	end
	else begin
		cnt <= cnt;
	end
end

endmodule
