`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:13:34 PM
// Design Name: 
// Module Name: WB_stage
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


module WB_stage (
    input [31:0] mem_Read_data,
    input [31:0] mem_ALU_result,
    input MemtoReg,
    output [31:0] wb_data
    );
    
    // Reuse mux module from IF stage
    mux mux_wb (
        .a(mem_ALU_result),
        .b(mem_Read_data),
        .sel(MemtoReg),
        .y(wb_data)
    );
endmodule
