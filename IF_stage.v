`timescale 1ns / 1ps

module IF_stage (
    input  wire        clk,
    input  wire        reset,
    input  wire        ex_mem_pcrsrc,  // Control signal for branch selection
    input  wire [31:0] ex_mem_npc,     // Branch target from EX/MEM stage
    output wire [31:0] IF_ID_npc,      // Latched NPC output
    output wire [31:0] IF_ID_instr     // Latched instruction output
);

    // Internal signals
    wire [31:0] pc;         // Current program counter
    wire [31:0] pc_plus_1;  // Result of adding 1 to pc
    wire [31:0] npc;        // Next program counter (selected by MUX)
    wire [31:0] instr;      // Instruction read from memory

    //------------------------------------
    // 1) Program Counter
    //------------------------------------
    program_counter PC (
        .clk   (clk),
        .reset (reset),
        .npc   (npc),
        .pc    (pc)
    );

    //------------------------------------
    // 2) Adder (pc + 1)
    //------------------------------------
    adder ADD_PC (
        .pcin  (pc),
        .pcout (pc_plus_1)
    );

    //------------------------------------
    // 3) MUX for Branching:
    // If ex_mem_pcrsrc is asserted, npc is set to ex_mem_npc;
    // otherwise, use pc_plus_1.
    //------------------------------------
    assign npc = ex_mem_pcrsrc ? ex_mem_npc : pc_plus_1;

    //------------------------------------
    // 4) Instruction Memory
    //------------------------------------
    instruction_memory IM (
        .addr (pc),
        .data (instr)
    );

    //------------------------------------
    // 5) IF/ID Latch
    //------------------------------------
    if_id_latch IF_ID (
        .clk      (clk),
        .reset    (reset),
        .npc      (npc),
        .instr    (instr),
        .npcout   (IF_ID_npc),
        .instrout (IF_ID_instr)
    );

endmodule