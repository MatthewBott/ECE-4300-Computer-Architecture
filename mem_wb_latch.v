`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:40:52 PM
// Design Name: 
// Module Name: mem_wb_latch
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


module mem_wb_latch(
    input clk,
    input [31:0] ALUResult_in,
    input [31:0] ReadData_in,
    input [4:0] WriteReg_in,
    input [1:0] WBControl_in,
    output reg [31:0] ALUResult_out,
    output reg [31:0] ReadData_out,
    output reg [4:0] WriteReg_out,
    output reg [1:0] WBControl_out
    );

    always @(posedge clk) begin
        ALUResult_out <= ALUResult_in;
        ReadData_out <= ReadData_in;
        WriteReg_out <= WriteReg_in;
        WBControl_out <= WBControl_in;
    end
endmodule
