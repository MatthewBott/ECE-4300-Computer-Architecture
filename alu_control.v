`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:36:33 PM
// Design Name: 
// Module Name: alu_control
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


module alu_control (
    output reg [2:0] select,
    input [5:0] funct,
    input [1:0] alu_op
    );
    
    always @(*) begin
        case (alu_op)
            2'b00: select = 3'b010; // LW or SW
            2'b01: select = 3'b110; // BEQ
            2'b10: begin
                case (funct)
                    6'b100000: select = 3'b010; // ADD
                    6'b100010: select = 3'b110; // SUB
                    6'b100100: select = 3'b000; // AND
                    6'b100101: select = 3'b001; // OR
                    6'b101010: select = 3'b111; // SLT
                    default:   select = 3'bxxx; // Unknown
                endcase
            end
            default: select = 3'bxxx;
        endcase
    end
endmodule
