`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:40:23 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input [31:0] Address,
    input [31:0] WriteData,
    input MemWrite,
    input MemRead,
    output reg [31:0] ReadData
);

    reg [31:0] memory [0:255];  // Memory with 256 words, each 32 bits

    // Initialize memory and ReadData
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 32'b0;
        ReadData = 32'b0;
    end

    // Memory write on any change of inputs
    always @(*) begin
        if (MemWrite)
            memory[Address[7:0]] = WriteData;
    end

    // Memory read on any change of inputs
    always @(*) begin
        if (MemRead)
            ReadData = memory[Address[7:0]];
        else
            ReadData = 32'b0;  // Optional: make sure it's not left as X
    end

endmodule
