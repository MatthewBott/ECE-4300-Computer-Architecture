`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:28:59 PM
// Design Name: 
// Module Name: sign_extend
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


module sign_extend(
    input wire [15:0] immediate,      // 16-bit immediate from instruction
    output wire [31:0] extended       // 32-bit sign-extended immediate
);

    // Sign-extend the 16-bit immediate to 32 bits
    assign extended = {{16{immediate[15]}}, immediate};  // Extend the sign bit

endmodule
