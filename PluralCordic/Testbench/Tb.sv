
module Tb;
logic                       sys_clk         ;
logic                       sys_rst_n       ;
logic           [8:0]       re_in           ;
logic           [8:0]       im_in           ;
logic                       trig            ;

wire            [8:0]       ampli_out       ;
wire    signed  [9:0]       theta_out       ;
wire                        vld             ;
wire                        err             ;

int                         seed            ;
int                         cnt1            ;
int                         cnt2            ; 
int                         wait_cnt        ;

real                        ampli           ;
real                        ampli_real      ;
real                        theta           ;
real                        theta_real      ;
real                        err_ampli       ;
real                        err_ampli_max   ;
real                        err_theta       ;
real                        err_theta_max   ;


Top Top_inst(
	.sys_clk				(sys_clk				),	// i 1b
	.sys_rst_n				(sys_rst_n				),	// i 1b
    // data flow
	.re_in					(re_in					),	// i 9b
	.im_in					(im_in					),	// i 9b
	.ampli_out				(ampli_out				),	// o 9b
	.theta_out				(theta_out				),	// o 10b
	.err					(err					),	// o 1b
    // control
	.trig					(trig					),	// i 1b
	.vld					(vld					)	// o 1b
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
    // initial
    re_in   = 0;
    im_in   = 0;
    trig    = 0;

    @(posedge sys_rst_n);
    #100;
   
    err_theta_max = 0;
    err_ampli_max = 0;

    cnt1 = -256;
    while(cnt1 < 256) begin
        cnt2 = -256;
        while(cnt2 < 256) begin
            @(posedge sys_clk);
            #1;
            re_in   =   cnt1;
            im_in   =   cnt2;
            trig    =   1;
            @(posedge sys_clk);
            #1;
            re_in   =   0;
            im_in   =   0;
            trig    =   0;
            
            wait_cnt = 0;
            while(wait_cnt < 100) begin
                @(posedge sys_clk);
                #1;
                if (vld) begin
                    ampli       = ampli_out / (2.0**5);
                    theta       = theta_out * 0.006135923151542565;

                    // calculate real value
                    ampli_real  = $sqrt((cnt1/32.0)**2 + (cnt2/32.0)**2);
                    if(cnt1 == 0) begin
                        if(cnt2 > 0) begin
                            theta_real  =   1.5707963267948966; 
                        end
                        else if (cnt2 < 0) begin
                            theta_real  =   -1.5707963267948966;  
                        end
                        else begin
                            theta_real  =   0; 
                        end
                    end
                    else begin
                        theta_real = $atan(real'(cnt2)/real'(cnt1)); 
                    end

                    // calculate err
                    if (cnt1 == 0 && cnt2 == 0) begin
                        if (err != 1) begin
                            err_theta = 10;
                            err_ampli = 10;
                        end  
                        else begin
                            err_theta = 0;
                            err_ampli = 0;
                        end
                    end 
                    else begin
                        err_theta = $abs(theta - theta_real);
                        err_ampli = $abs(ampli - ampli_real);
                    end

                    // calculate max err
                    if(err_theta_max < err_theta) begin
                        err_theta_max = err_theta; 
                    end 
                    if(err_ampli_max < err_ampli) begin
                        err_ampli_max = err_ampli; 
                    end 
                    break;
                end
                wait_cnt = wait_cnt + 1;
            end
            cnt2 = cnt2 + 1;
        end
        cnt1 = cnt1 + 1;
    end
    #100 $finish;
end

endmodule
