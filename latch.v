`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:30:30 PM
// Design Name: 
// Module Name: latch
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


module latch(
    output reg [1:0] wb_out,
    output reg [2:0] mem_out,
    output reg [3:0] ctl_out,
    output reg [4:0] instr_bits_20_16_out, instr_bits_15_11_out,
    output reg [31:0] npc_out, readdat1_out, readdat2_out, sign_ext_out,
    input clk,                    // Clock signal
    input rst,                    // Reset signal
    input [1:0] ctl_wb,
    input [2:0] ctl_mem,
    input [3:0] ctl_ex,
    input [4:0] instr_bits_20_16, instr_bits_15_11,
    input [31:0] npc, readdat1, readdat2, sign_ext
    );

    always @(posedge clk) begin
        if (rst) begin
            // Reset outputs to 0 when reset is asserted
            wb_out <= 2'b00;
            mem_out <= 3'b000;
            ctl_out <= 4'b0000;
            instr_bits_20_16_out <= 5'b00000;
            instr_bits_15_11_out <= 5'b00000;
            npc_out <= 32'b0;
            readdat1_out <= 32'b0;
            readdat2_out <= 32'b0;
            sign_ext_out <= 32'b0;
        end
        else begin
            // Latch the values on the rising edge of the clock
            wb_out <= ctl_wb;
            mem_out <= ctl_mem;
            ctl_out <= ctl_ex;
            instr_bits_20_16_out <= instr_bits_20_16;
            instr_bits_15_11_out <= instr_bits_15_11;
            npc_out <= npc;
            readdat1_out <= readdat1;
            readdat2_out <= readdat2;
            sign_ext_out <= sign_ext;
        end
    end

endmodule
