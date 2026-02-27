`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2026 15:07:13
// Design Name: 
// Module Name: fifo_practice
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

module fifo_practice#
(
parameter data_width=8,
parameter depth=8
)
(
input wrt_enable,
input read_enable,
input clk,
input [data_width-1:0] data_in,
input rst,
output reg [data_width-1:0] data_out,
output full,
output empty
    );
    reg [data_width-1:0] memory [0:depth-1];
    localparam PTR_WIDTH = $clog2(depth);
    reg [PTR_WIDTH-1:0] write_pointer;
    reg [PTR_WIDTH-1:0] read_pointer;
    reg [PTR_WIDTH:0] count;
    assign full=(count==depth);
    assign empty=(count==0);
   always @(posedge clk) begin
    if (rst) begin
        write_pointer <= 0;
        read_pointer  <= 0;
        count <= 0;
        data_out <= 0;
    end
    else begin
        if (wrt_enable && !full) begin
            memory[write_pointer] <= data_in;
            write_pointer <= (write_pointer == depth-1) ? 0 : write_pointer + 1;
        end

        if (read_enable && !empty) begin
            data_out <= memory[read_pointer];
            read_pointer <= (read_pointer == depth-1) ? 0 : read_pointer + 1;
        end

        case ({wrt_enable && !full, read_enable && !empty})
            2'b10: count <= count + 1;
            2'b01: count <= count - 1;
            default: count <= count;
        endcase
    end
end
endmodule
