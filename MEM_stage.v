`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:38:45 PM
// Design Name: 
// Module Name: MEM_stage
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


module MEM_stage(
    input clk,
    input [31:0] ALUResult,
    input [31:0] WriteData,
    input [4:0] WriteReg,
    input [1:0] WBControl,
    input MemWrite,
    input MemRead,
    input Branch,
    input Zero,
    output [31:0] ReadData,
    output [31:0] ALUResult_out,
    output [4:0] WriteReg_out,
    output [1:0] WBControl_out,
    output PCSrc
    );

    wire [31:0] DataMemReadData;

    // AND Gate for determining PCSrc
    and_gate andGate(
        .Branch(Branch),
        .Zero(Zero),
        .PCSrc(PCSrc)
    );

    // Data Memory for loading and storing data
    data_memory dataMem(
        .Address(ALUResult),
        .WriteData(WriteData),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(DataMemReadData)
    );

    // MEM/WB Latch to store output for the write-back stage
    mem_wb_latch memwb(
        .clk(clk),
        .ALUResult_in(ALUResult),
        .ReadData_in(DataMemReadData),
        .WriteReg_in(WriteReg),
        .WBControl_in(WBControl),
        .ALUResult_out(ALUResult_out),
        .ReadData_out(ReadData),
        .WriteReg_out(WriteReg_out),
        .WBControl_out(WBControl_out)
    );
    
endmodule
