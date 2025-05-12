`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:37:56 PM
// Design Name: 
// Module Name: ex_latch
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


module ex_latch #(parameter WIDTH = 32) (
    input wire clk,
    input wire reset,
    input wire [WIDTH-1:0] in,
    output reg [WIDTH-1:0] out
    );
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 0;
        else
            out <= in;
    end
endmodule
