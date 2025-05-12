`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 04:31:32 PM
// Design Name: 
// Module Name: EX_stage
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


module EX_stage(
    input clk,
    input [1:0] ctlwb_in, ctlm_in,
    input [31:0] npc, rdata1, rdata2, s_extend,
    input [4:0] instr_2016, instr_1511,
    input [1:0] alu_op,
    input [5:0] funct,
    input alusrc, regdst,
    output [1:0] ctlwb_out, ctlm_out,
    output [31:0] adder_out, alu_result_out, rdata2_out,
    output [4:0] muxout_out
);
    // Wires
    wire [31:0] alu_in2;
    wire [2:0] alu_control;
    wire alu_zero;
    wire [4:0] regdst_muxout;
    wire [31:0] adder_wire, alu_result;

    // Adder for branch target
    add adder_inst(
        .a(npc),
        .b(s_extend),
        .result(adder_wire)
    );

    // ALUSrc Mux
    mux mux32_inst(
        .a(rdata2),
        .b(s_extend),
        .sel(alusrc),
        .y(alu_in2)
    );

    // ALU Control
    alu_control alu_ctrl_inst(
        .alu_op(alu_op),
        .funct(funct),
        .select(alu_control)
    );

    // ALU
    alu alu(
        .a(rdata1),
        .b(alu_in2),
        .control(alu_control),
        .result(alu_result),
        .zero(alu_zero)
    );

    // RegDst Mux
    mux5 regdst_mux(
        .a(instr_2016),
        .b(instr_1511),
        .sel(regdst),
        .y(regdst_muxout)
    );

    // Latch for EX/MEM
    ex_latch ex_mem_reg_ctlwb(
        .clk(clk),
        .reset(1'b0),
        .in(ctlwb_in),
        .out(ctlwb_out)
    );

    ex_latch ex_mem_reg_ctlm(
        .clk(clk),
        .reset(1'b0),
        .in(ctlm_in),
        .out(ctlm_out)
    );

    ex_latch #(32) ex_mem_reg_adder(
        .clk(clk),
        .reset(1'b0),
        .in(adder_wire),
        .out(adder_out)
    );

    ex_latch #(32) ex_mem_reg_alu_result(
        .clk(clk),
        .reset(1'b0),
        .in(alu_result),
        .out(alu_result_out)
    );

    ex_latch #(32) ex_mem_reg_rdata2(
        .clk(clk),
        .reset(1'b0),
        .in(rdata2),
        .out(rdata2_out)
    );

    ex_latch #(5) ex_mem_reg_muxout(
        .clk(clk),
        .reset(1'b0),
        .in(regdst_muxout),
        .out(muxout_out)
    );
endmodule
