module fifo_rd #(
    parameter SIZE = 4
) (
    // system
    input                   rclk,
    input                   rst_n,
    // control
    input                   rd_inr,
    input       [SIZE:0]    wr_gray_async, // async
    output  reg             fifo_empty,
    output  reg             fifo_almost_empty,
    output      [SIZE:0]    rd_gray
);

reg     [SIZE:0]    wr_gray_tmp;
reg     [SIZE:0]    wr_gray;
wire    [SIZE:0]    wr_ptr;
wire    [SIZE:0]    rd_ptr;

reg     [SIZE:0]  readable_num; // number of readable data
reg     [SIZE:0]    sub1;
reg     [SIZE:0]    sub2; 

gray_cnt #(
    .SIZE   (SIZE+1)
) gray_cnt_u (
    .clk    (rclk),
    .rst_n  (rst_n),
    .en     (rd_inr),
    .cnt    (rd_gray)
);

// sync read gray cnt from read clock domain
always@(posedge rclk or negedge rst_n) begin
    if(~rst_n) begin
        wr_gray_tmp <= {(SIZE+1){1'b0}};
        wr_gray     <= {(SIZE+1){1'b0}};
    end
    else begin
        wr_gray_tmp <= wr_gray_async;
        wr_gray     <= wr_gray_tmp;
    end
end

// judge empty signal
gray_to_bin #(
    .SIZE   (SIZE+1)
) gray_to_bin_u1 (
    .gray   (wr_gray),
    .bin    (wr_ptr)
);

gray_to_bin #(
    .SIZE   (SIZE+1)
) gray_to_bin_u2 (
    .gray   (rd_gray),
    .bin    (rd_ptr)
);

always@(*) begin
    if(rd_ptr[SIZE] & (~wr_ptr[SIZE])) begin
        sub1 = {1'b1, wr_ptr[SIZE-1:0]};
        sub2 = {1'b0, rd_ptr[SIZE-1:0]};
    end
    else begin
        sub1 = wr_ptr;
        sub2 = rd_ptr;
    end
end

assign readable_num = sub1 - sub2;

// almost fifo empty
always@(posedge rclk or negedge rst_n) begin
    if(~rst_n) begin
        fifo_almost_empty <= 1'b0;
    end
    else if((rd_inr && (readable_num == 2)) || 
        ((~rd_inr) && (readable_num == 1))) begin
        fifo_almost_empty <= 1'b1;
    end
    else begin
        fifo_almost_empty <= 1'b0;
    end
end

// fifo empty
always@(posedge rclk or negedge rst_n) begin
    if(~rst_n) begin
        fifo_empty <= 1'b0;
    end
    else if((rd_inr && (readable_num == 1)) || 
        ((~rd_inr) && (readable_num == 0))) begin
        fifo_empty <= 1'b1;
    end
    else begin
        fifo_empty <= 1'b0;
    end
end       

endmodule
