module Tb;
logic                           sys_clk     ;
logic                           sys_rst_n   ;
logic                           trig        ;
logic               [9:0]       data_in     ;

wire                            vld         ;
wire    signed      [12:0]      sin_out     ;
wire    signed      [12:0]      cos_out     ;

int                             seed        ;
int                             i           ;
int                             cnt         ;

real                            sin_real    ;
real                            cos_real    ;
real                            delta       ;
real                            theta       ;
real                            sin_rtl     ;
real                            cos_rtl     ;
real                            sin_err     ;
real                            cos_err     ;
real                            max_err     ;

Top Top_inst(
	.sys_clk				(sys_clk				),	// i 1b
	.sys_rst_n				(sys_rst_n				),	// i 1b
    // control
	.trig					(trig					),	// i 1b
	.vld					(vld					),	// o 1b
    // data flow
	.data_in				(data_in				),	// i 10b
	.sin_out				(sin_out				),	// o 13b
	.cos_out				(cos_out				)	// o 13b
);

initial begin
    if(!$value$plusargs("seed=%d", seed)) begin
        seed = 100;
    end
    $srandom(seed);

    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0);
end

// Clock block
initial begin
    sys_clk = 0;
    forever #10 sys_clk = ~sys_clk;
end

// Reset block
initial begin
    sys_rst_n = 0;
    #100
    sys_rst_n = 1;
end

initial begin
    trig = 0;
    data_in = 0;

    @(posedge sys_rst_n);
    #100;


    delta = 0.006135923151542565;


    max_err = 0;
    i = 0;
    while(i < 2**10) begin
        @(posedge sys_clk);
        #1;
        data_in = i;
        theta = int'(data_in) * delta;
        trig = 1;
        @(posedge sys_clk);
        #1;
        data_in = 0;
        trig = 0;
        
        cnt = 0;
        while(cnt < 100) begin
            @(posedge sys_clk);
            #1;
            if(vld) begin
                sin_rtl = int'(sin_out) / (2.0**11); 
                cos_rtl = int'(cos_out) / (2.0**11); 
                sin_real = $sin(theta);
                cos_real = $cos(theta);
                sin_err = $abs(sin_rtl - sin_real);
                cos_err = $abs(cos_rtl - cos_real);
                if($max(sin_err, cos_err) > max_err) begin
                    max_err = $max(sin_err, cos_err);
                end
                break;
            end
            cnt = cnt + 1;
        end
        i = i + 1;
    end

    $finish;


end


endmodule
