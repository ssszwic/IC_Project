`timescale 1ns/1ns
module Tb;
logic                       sys_clk         ;
logic                       sys_rst_n       ;
logic           [31:0]      a               ;
logic           [31:0]      b               ;
logic           [1:0]       opcode          ;
logic                       trig            ;

wire            [31:0]      c               ;
wire                        vld             ;
wire                        work            ;

int                         seed            ;
int                         cnt             ;
longint                     err             ;

shortreal                   a_real          ;
shortreal                   b_real          ;
shortreal                   c_real          ;

logic           [31:0]      c_right         ;

Top Top_inst(
	.sys_clk				(sys_clk				),	// i 1b
	.sys_rst_n				(sys_rst_n				),	// i 1b
	.data1_in				(a                      ),	// i 32b
	.data2_in				(b				        ),	// i 32b
	.opcode					(opcode					),	// i 2b
	.trig					(trig					),	// i 1b
	.data_out				(c       				),	// o 32b
	.vld					(vld					),	// o 1b
	.work					(work					)	// o 1b
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
    sys_rst_n    =   0;
    a            =   0;
    b            =   0;
    opcode       =   0;
    trig         =   0;
    
    // wait recover
    @(posedge sys_clk);
    #200; 

    @(posedge sys_clk);
    #1;
    a       =   int'($random(seed));
    b       =   int'($random(seed));

    // prohibit the input of subnormal number 
    if(a[30:23] == 0 && a[22:0] != 0) begin
        a[22:0] = 0; 
    end
    if(b[30:23] == 0 && b[22:0] != 0) begin
        b[22:0] = 0; 
    end

    trig    =   1;
    opcode  =   {$random(seed)} % 2; // unsigned { }  for $random%2 = {-1, 0, 1}
    a_real  =   $bitstoshortreal(a);
    b_real  =   $bitstoshortreal(b);

    // delay 1 clock
    @(posedge sys_clk);
    #1;
    a       =   0;
    b       =   0;
    trig    =   0;

    repeat(1e4) begin
        // Prevent program death when vld = 1 forever.
        cnt = 0;
        while(cnt < 1000) begin
            // wait vld signal
            @(posedge sys_clk);
            #1;
            if(vld) begin
                // calculate acroding to opcode
                case(opcode) 
                    2'b00:  c_real = a_real + b_real;
                    2'b01:  c_real = a_real - b_real;
                    2'b10:  c_real = a_real * b_real;
                    2'b11:  c_real = a_real / b_real;
                    default:c_real = 0;
                endcase
                c_right =   $shortrealtobits(c_real);

                // set the decimal of NaN to 1
                if(c_right[30:23] == 8'd255 && c_right[22:0] != 8'd0) begin
                    c_right = {32{1'b1}};
                end

                err = $abs(c_right - int'(c));
                
                // next input
                a       =   int'($random(seed));
                b       =   int'($random(seed));

                // prohibit the input of subnormal number 
                if(a[30:23] == 0 && a[22:0] != 0) begin
                    a[22:0] = 0; 
                end
                if(b[30:23] == 0 && b[22:0] != 0) begin
                    b[22:0] = 0; 
                end

                trig    =   1;
                opcode  =   {$random(seed)} % 2;
                a_real  =   $bitstoshortreal(a);
                b_real  =   $bitstoshortreal(b);

                // delay 1 clock
                @(posedge sys_clk);
                #1;
                a       =   0;
                b       =   0;
                trig    =   0;

                break;
            end
            cnt = cnt + 1;
        end
    end
    $finish;
end


endmodule
