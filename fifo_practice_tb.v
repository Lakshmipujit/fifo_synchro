`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2026 10:29:05
// Design Name: 
// Module Name: fifo_practice_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_practice_tb;

reg clk;
reg rst;
reg wrt_enable;
reg read_enable;
reg [7:0] data_in;     // Must match DATA_WIDTH
wire [7:0] data_out;   // DUT drives this
wire full;             // DUT drives this
wire empty;            // DUT drives this

// Instantiate DUT
fifo_practice uut (
    .clk(clk),
    .rst(rst),
    .wrt_enable(wrt_enable),
    .read_enable(read_enable),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

// Clock generation
always #10 clk = ~clk;
initial begin
    $monitor("T=%0t | din=%h dout=%h wr=%b rd=%b full=%b empty=%b",
              $time, data_in, data_out, wrt_enable, read_enable, full, empty);

    clk = 0;
    rst = 1;
    wrt_enable = 0;
    read_enable = 0;
    data_in = 0;

    // Proper reset
    repeat (2) @(posedge clk);
    rst = 0;

    // WRITE 4 VALUES
    @(posedge clk);
    wrt_enable = 1;
    data_in = 8'h11;

    @(posedge clk) data_in = 8'h22;
    @(posedge clk) data_in = 8'h33;
    @(posedge clk) data_in = 8'h44;

    @(posedge clk);
    wrt_enable = 0;

    // READ 4 VALUES
    @(posedge clk);
    read_enable = 1;

    repeat (4) @(posedge clk);

    read_enable = 0;

    repeat (2) @(posedge clk);
    $finish;
end
endmodule