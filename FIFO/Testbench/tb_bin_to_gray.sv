`timescale 1ns/100ps
module tb_bin_to_gray;

parameter SIZE = 4;

logic [SIZE-1:0] bin;
logic [SIZE-1:0] gray;

bin_to_gray #(.SIZE(SIZE)) bin_to_gray_tb(
	.bin	(bin),
	.gray	(gray)
);

initial begin
    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0);
end

initial begin
	bin = 0;
	while(bin != (2 ** SIZE - 1)) begin
		#10; 
		bin = bin + 1;
	end
	#10;
	$finish;
end

endmodule
