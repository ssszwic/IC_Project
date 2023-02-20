module tb_fifo;

parameter   WIDTH   = 8,
            DEPTH   = 4,
            WCLK    = 10,
            RCLK    = 16;

parameter   FILE_WR = "out/wr.txt",
            FILE_RD = "out/rd.txt";

logic                       rst_n;

logic                       wclk;
logic                       wr_en;
logic                       full;
logic                       almost_full;
logic       [WIDTH-1:0]     din;

logic                       rclk;
logic                       rd_en;
logic                       empty;
logic                       almost_empty;
logic       [WIDTH-1:0]     dout;

int                         seed;
int                         fid_wr;
int                         fid_rd;

fifo #(
    .WIDTH              (WIDTH),
    .DEPTH              (DEPTH)
) fifo_u (
    .rst_n              (rst_n),
    .wclk               (wclk),
    .wr_en              (wr_en),
    .full               (full),
    .almost_full        (almost_full),
    .din                (din),
    .rclk               (rclk),
    .rd_en              (rd_en),
    .empty              (empty),
    .almost_empty       (almost_empty),
    .dout               (dout)
);

initial begin
    if(!$value$plusargs("seed=%d", seed)) begin
        seed = 100;
    end
    $srandom(seed);
    $display("\d", seed);

    $fsdbDumpfile("tb.fsdb");
    $fsdbDumpvars(0);
end

// reset and finish
initial begin
    rst_n = 1'b0;
    #100;
    rst_n = 1'b1;
    #200000;
    $fclose(fid_wr);
    $finish;
end

// clockrst_n
initial begin
    wclk = 1'b1;
    forever #(WCLK/2) wclk = ~wclk;
end

initial begin
    rclk = 1'b1;
    forever #(RCLK/2) rclk = ~rclk;
end

// write test
initial begin
    wr_en = 1'b0;
    din = 0;
    @(posedge rst_n);
    #100;
    // random write
    fid_wr = $fopen(FILE_WR, "w");
    forever begin
        @(posedge wclk);
        #(WCLK-1);
        if((~almost_full) && (~full) && ({$random(seed)}%2)) begin
            #2;
            wr_en = 1'b1;
            din = {$random(seed)} % (2**WIDTH);
            $fwrite(fid_wr, "%b\n", din);
        end
        else begin
            #2;
            wr_en = 1'b0;
            din = 0; 
        end
    end
end

// read test
initial begin
    rd_en = 1'b0;
    @(posedge rst_n);
    #100;
    // random read
    fid_rd = $fopen(FILE_RD, "w");
    forever begin
        @(posedge rclk);
        #(RCLK-1);
        if((~almost_empty) && (~empty) && ({$random(seed)}%2)) begin
            #2;
            fork
                // the read data will be available in next cycle
                #(RCLK) $fwrite(fid_rd, "%b\n", dout);
                rd_en = 1'b1;
            join_any
        end
        else begin
            #2;
            rd_en = 1'b0;
        end
    end
end

endmodule
