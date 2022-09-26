module Div( 
	// system signal                     		
	input					sys_clk				,     		
	input					sys_rst_n			,   		
	// dataflow                          		
	input			[31:0]	data1_in			,    		
	input			[31:0]	data2_in			,    		
	output	reg		[31:0]	data_out			,    		
	// control                           		
	input					trig				,        		
	output	reg				vld					,         		
	// MultiUnit control                 		
	input			[31:0]	mul_result_in		,
	output	reg		[31:0]	mul_data1_out		,
	output	reg		[31:0]	mul_data2_out		,
	// MultiUnit control
	input					mul_result_vld		,
	output	reg				mul_trig_out
);

always@(*) begin
	data_out = 0;
	vld = 0;
	mul_data1_out = 0;
	mul_data2_out = 0;
	mul_trig_out = 0;
end

endmodule
