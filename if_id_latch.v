`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:24:19 PM
// Design Name: 
// Module Name: if_id_latch
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


module if_id_latch(
  input clk, reset,
  input [31:0] npc, instr,
  output reg [31:0] npcout, instrout
);
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      npcout <= 0;
      instrout <= 0;
    end else begin
      npcout <= npc;
      instrout <= instr;
    end
  end
endmodule
