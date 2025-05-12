`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:30:08 PM
// Design Name: 
// Module Name: control
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


module control(
    output reg [1:0] wb,            // Writeback control signals (2 bits)
    output reg [2:0] mem,           // Memory control signals (3 bits)
    output reg [3:0] ex,            // Execute control signals (4 bits)
    input [5:0] opcode,             // Opcode to determine control signals
    input clk,                      // Clock signal
    input rst                       // Reset signal
    );

    // Defining opcode constants
    parameter RTYPE = 6'b000000;
    parameter LW = 6'b100011;
    parameter SW = 6'b101011;
    parameter BEQ = 6'b000100;
    
    // Initial block to set initial values
    initial begin
        wb <= 2'b00;
        mem <= 3'b000;
        ex <= 4'b0000;
    end
    
    // Always block sensitive to clock and reset
    always @(posedge clk) begin
        if (rst) begin
            // Reset all control signals when rst is asserted
            wb <= 2'b00;
            mem <= 3'b000;
            ex <= 4'b0000;
        end else begin
            case(opcode)
                RTYPE: begin
                    wb <= 2'b10;        // Write to register
                    mem <= 3'b000;      // No memory access
                    ex <= 4'b1100;      // ALU operation (e.g., ADD)
                end
                
                LW: begin
                    wb <= 2'b01;        // Write to register (Load Word)
                    mem <= 3'b001;      // Memory read
                    ex <= 4'b0010;      // ALU operation (e.g., ADD)
                end
                
                SW: begin
                    wb <= 2'b00;        // No write to register
                    mem <= 3'b010;      // Memory write
                    ex <= 4'b0010;      // ALU operation (e.g., ADD)
                end
                
                BEQ: begin
                    wb <= 2'b00;        // No write to register
                    mem <= 3'b000;      // No memory access
                    ex <= 4'b0110;      // ALU operation (e.g., SUB for comparison)
                end
                
                default: begin
                    wb <= 2'b00;        // Default: no write
                    mem <= 3'b000;      // Default: no memory access
                    ex <= 4'b0000;      // Default: no ALU operation
                end
            endcase
        end
    end

endmodule
