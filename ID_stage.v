`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:26:07 PM
// Design Name: 
// Module Name: ID_stage
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


module ID_stage(
    input wire          clk,
                        rst,
                        wb_reg_write,
    input wire [4:0]    wb_write_reg_location,
    input wire  [31:0]  mem_wb_write_data,
                        if_id_instr,
                        if_id_npc,
    output wire [1:0]   wb_ctlout,
    output wire [2:0]    id_ex_mem,
    output wire [3:0]    id_ex_execute,
    output wire [31:0]   id_ex_npc,
                        id_ex_readdat1,
                        id_ex_readdat2,
                        id_ex_sign_ext,
    output wire [4:0]    id_ex_instr_bits_20_16,
                        id_ex_instr_bits_15_11
);

    // Internal signals for the components
    wire [31:0] sign_ext_internal,
                readdat1_internal,
                readdat2_internal;
    wire [1:0] wb_internal;
    wire [2:0] mem_internal;
    wire [3:0] ex_internal;

    // Instantiate the Sign Extend module
    sign_extend sE0(
        .immediate(if_id_instr[15:0]),  // 16-bit immediate from instruction
        .extended(sign_ext_internal)     // Extended 32-bit immediate
    );

    // Instantiate the Register File module
    register rf0(
        .clk(clk),                         // Clock input
        .rst(rst),                         // Reset input
        .regwrite(wb_reg_write),           // Register write control signal
        .rs(if_id_instr[25:21]),          // Source register 1 (rs)
        .rt(if_id_instr[20:16]),          // Source register 2 (rt)
        .rd(if_id_instr[15:11]),          // Destination register (rd)
        .write_data(mem_wb_write_data),    // Data to write to register
        .A_readdat1(readdat1_internal),   // Read data 1 from register file
        .B_readdat2(readdat2_internal)    // Read data 2 from register file
    );

    // Instantiate the Control module
    control c0(
        .clk(clk),                         // Clock input
        .rst(rst),                         // Reset input
        .opcode(if_id_instr[31:26]),      // Opcode from the instruction
        .wb(wb_internal),                 // Writeback control signals
        .mem(mem_internal),               // Memory control signals
        .ex(ex_internal)                  // Execute control signals
    ); 

    // Instantiate the Latch module for ID/EX pipeline register
    latch iEL0(
        .clk(clk),                         // Clock input
        .rst(rst),                         // Reset input
        .ctl_wb(wb_internal),              // Writeback control signals
        .ctl_mem(mem_internal),            // Memory control signals
        .ctl_ex(ex_internal),              // Execute control signals
        .npc(if_id_npc),                  // Next PC value
        .readdat1(readdat1_internal),     // Data from register file (readdat1)
        .readdat2(readdat2_internal),     // Data from register file (readdat2)
        .sign_ext(sign_ext_internal),     // Sign-extended immediate value
        .instr_bits_20_16(if_id_instr[20:16]),  // Instruction bits 20-16 (rt)
        .instr_bits_15_11(if_id_instr[15:11]),  // Instruction bits 15-11 (rd)
        .wb_out(id_ex_wb),                // Writeback control signals for EX stage
        .mem_out(id_ex_mem),              // Memory control signals for EX stage
        .ctl_out(id_ex_execute),          // Execute control signals for EX stage
        .npc_out(id_ex_npc),              // NPC for EX stage
        .readdat1_out(id_ex_readdat1),    // Readdat1 for EX stage
        .readdat2_out(id_ex_readdat2),    // Readdat2 for EX stage
        .sign_ext_out(id_ex_sign_ext),    // Sign-extended immediate for EX stage
        .instr_bits_20_16_out(id_ex_instr_bits_20_16), // RT (bits 20-16) for EX stage
        .instr_bits_15_11_out(id_ex_instr_bits_15_11)  // RD (bits 15-11) for EX stage
    );

endmodule
