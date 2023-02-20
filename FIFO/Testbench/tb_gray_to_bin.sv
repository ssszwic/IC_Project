`timescale 1ns/100ps
module tb_gray_to_bin;

parameter SIZE = 4;
int i;

logic [SIZE-1:0] gray;
logic [SIZE-1:0] bin;

gray_to_bin #(.SIZE(SIZE)) gray_to_bin_tb(
	.gray	(gray),
	.bin	(bin)
);

initial begin
    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0);
end

initial begin
	gray = 0;
	while(gray != (2 ** SIZE - 1)) begin
		#10; 
		gray = gray + 1;
	end
	#10;
	$finish;
end

endmodule
