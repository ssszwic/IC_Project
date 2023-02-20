module fifo_wr #(
    parameter SIZE = 4
) (
    // system
    input                   wclk,
    input                   rst_n,
    // control
    input                   wr_inr,
    input       [SIZE:0]    rd_gray_async, // async
    output  reg             fifo_full,
    output  reg             fifo_almost_full,
    output      [SIZE:0]    wr_gray
);

reg     [SIZE:0]    rd_gray_tmp;
reg     [SIZE:0]    rd_gray;
wire    [SIZE:0]    wr_ptr;
wire    [SIZE:0]    rd_ptr;

reg     [SIZE:0]  writable_num; // number of writable data
reg     [SIZE:0]    sub1;
reg     [SIZE:0]    sub2; 

gray_cnt #(
    .SIZE   (SIZE+1)
) gray_cnt_u (
    .clk    (wclk),
    .rst_n  (rst_n),
    .en     (wr_inr),
    .cnt    (wr_gray)
);

// sync writ gray cnt from writ clock domain
always@(posedge wclk or negedge rst_n) begin
    if(~rst_n) begin
        rd_gray_tmp <= {(SIZE+1){1'b0}};
        rd_gray     <= {(SIZE+1){1'b0}};
    end
    else begin
        rd_gray_tmp <= rd_gray_async;
        rd_gray     <= rd_gray_tmp;
    end
end

// judge full signal
gray_to_bin #(
    .SIZE   (SIZE+1)
) gray_to_bin_u1 (
    .gray   (rd_gray),
    .bin    (rd_ptr)
);

gray_to_bin #(
    .SIZE   (SIZE+1)
) gray_to_bin_u2 (
    .gray   (wr_gray),
    .bin    (wr_ptr)
);

always@(*) begin
    if(rd_ptr[SIZE] ^ wr_ptr[SIZE]) begin
        sub1 = {1'b0, rd_ptr[SIZE-1:0]};
        sub2 = {1'b0, wr_ptr[SIZE-1:0]};
    end
    else begin
        sub1 = {1'b1, rd_ptr[SIZE-1:0]};
        sub2 = {1'b0, wr_ptr[SIZE-1:0]};
    end
end

assign writable_num = sub1 - sub2;

// almost fifo full
always@(posedge wclk or negedge rst_n) begin
    if(~rst_n) begin
        fifo_almost_full <= 1'b0;
    end
    else if((wr_inr && (writable_num == 2)) || 
        ((~wr_inr) && (writable_num == 1))) begin
        fifo_almost_full <= 1'b1;
    end
    else begin
        fifo_almost_full <= 1'b0;
    end
end

// fifo full
always@(posedge wclk or negedge rst_n) begin
    if(~rst_n) begin
        fifo_full <= 1'b0;
    end
    else if((wr_inr && (writable_num == 1)) || 
        ((~wr_inr) && (writable_num == 0))) begin
        fifo_full <= 1'b1;
    end
    else begin
        fifo_full <= 1'b0;
    end
end 

endmodule
