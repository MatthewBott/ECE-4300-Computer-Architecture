`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:23:44 PM
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(output [31:0] data, input [31:0] addr);
  reg [31:0] memory [0:127];
  wire [6:0] index = addr[8:2]; // word-aligned access (since addr is byte-based)

  initial begin
    memory[0] = 32'hA00000AA;
    memory[1] = 32'h10000011;
    memory[2] = 32'h20000022;
    memory[3] = 32'h30000033;
    memory[4] = 32'h40000044;
    memory[5] = 32'h50000055;
    memory[6] = 32'h60000066;
    memory[7] = 32'h70000077;
    memory[8] = 32'h80000088;
    memory[9] = 32'h90000099;
  end

  assign data = memory[index];
endmodule
