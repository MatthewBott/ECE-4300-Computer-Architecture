`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:29:27 PM
// Design Name: 
// Module Name: register
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


module register(
    output reg [31:0] A_readdat1,  // Register 1 output
    output reg [31:0] B_readdat2,  // Register 2 output
    input [4:0] rs,                // Source Register 1
    input [4:0] rt,                // Source Register 2
    input [4:0] rd,                // Destination Register
    input [31:0] write_data,       // Data to write to the register
    input regwrite,                // Register write enable signal
    input clk,                     // Clock signal
    input rst                      // Reset signal
    );

    // Internal 32 registers, each 32 bits wide
    reg [31:0] REG [31:0];

    // Initialization block for testing purposes
    initial begin
        REG[0] = 32'h002300AA;
        REG[1] = 32'h10654321;
        REG[2] = 32'h00100022;
        REG[3] = 32'h8C123456;
        REG[4] = 32'h8F123456;
        REG[5] = 32'hAD654321;
        REG[6] = 32'h60000066;
        REG[7] = 32'h13012345;
        REG[8] = 32'hAC654321;
        REG[9] = 32'h12012345;
    end

    // Read and write logic
    always @(posedge clk) begin
        if (rst) begin
            // Reset the register outputs to zero on reset signal
            A_readdat1 <= 32'b0;
            B_readdat2 <= 32'b0;
        end else begin
            if (regwrite) begin
                // Write to register rd
                REG[rd] <= write_data;
            end
            // Always read the values from registers rs and rt
            A_readdat1 <= REG[rs];
            B_readdat2 <= REG[rt];
        end
    end

endmodule
