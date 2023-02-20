module fifo #(
    parameter   WIDTH   = 8,
                DEPTH   = 4
) (
    // system
    input                   rst_n,
    // write clock domain
    input                   wclk,
    input                   wr_en,
    output                  full,
    output                  almost_full,
    input       [WIDTH-1:0] din,
    // read clock domain
    input                   rclk,
    input                   rd_en,
    output                  empty,
    output                  almost_empty,
    output  reg [WIDTH-1:0] dout
);

wire        [DEPTH-1:0]     wr_addr;
wire        [DEPTH-1:0]     rd_addr;

wire        [WIDTH-1:0]     rd_data;

wire        [DEPTH:0]       wr_gray;
wire        [DEPTH:0]       wr_bin;
wire        [DEPTH:0]       rd_gray;
wire        [DEPTH:0]       rd_bin;

// convert gray cnt to addr of ram
gray_to_bin #(
    .SIZE       (DEPTH+1)
) gray_to_bin_u1 (
    .gray       (wr_gray),
    .bin        (wr_bin)
);

gray_to_bin #(
    .SIZE       (DEPTH+1)
) gray_to_bin_u2 (
    .gray       (rd_gray),
    .bin        (rd_bin)
);

assign wr_addr = wr_bin[DEPTH-1:0];
assign rd_addr = rd_bin[DEPTH-1:0];

ram #(
    .WIDTH          (WIDTH),
    .DEPTH          (DEPTH)
) ram_u (
    .clk            (wclk),
    .rst_n          (rst_n),
    .wr_en          (wr_en),
    .wr_addr        (wr_addr),
    .rd_addr        (rd_addr),
    .wr_data        (din),
    .rd_data        (rd_data)
);

// hit a beat
always@(posedge rclk or negedge rst_n) begin
    if(~rst_n) begin
        dout <= {WIDTH{1'b0}};
    end
    else begin
        dout <= rd_data;
    end
end

fifo_wr #(
    .SIZE               (DEPTH)
) fifo_wr_u (
   .wclk                (wclk),
   .rst_n               (rst_n),
   .wr_inr              (wr_en),
   .rd_gray_async       (rd_gray),
   .fifo_full           (full),
   .fifo_almost_full    (almost_full),
   .wr_gray             (wr_gray)
);

fifo_rd #(
    .SIZE               (DEPTH)
) fifo_rd_u (
    .rclk               (rclk),
    .rst_n              (rst_n),
    .rd_inr             (rd_en),
    .wr_gray_async      (wr_gray),
    .fifo_empty         (empty),
    .fifo_almost_empty  (almost_empty),
    .rd_gray            (rd_gray)
);

endmodule
