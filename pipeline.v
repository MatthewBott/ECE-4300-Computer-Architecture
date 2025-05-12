`timescale 1ns / 1ps

module pipeline (
    input wire clk,
    input wire reset,
    input wire [31:0] mem_npc,               // Input for memory NPC
    input wire [4:0] mem_wb_writereg,        // Input for write register
    input wire [31:0] mem_wb_writedata,      // Input for write data
    output wire [1:0] WB_out,                // Output for WB control
    output wire [31:0] read_data_out,        // Output for read data from memory
    output wire [31:0] alu_result_out,       // Output for ALU result
    output wire [4:0] write_reg_out,         // Output for write register
    output wire PCSrc,                       // Output for PC Source (branch)
    output wire [31:0] write_data_out        // Output for write data (from MEM stage)
);

    // ------------------ IF Stage Wires ------------------
    wire [31:0] IF_ID_instr;
    wire [31:0] IF_ID_npc;

    // ------------------ ID Stage Wires ------------------
    wire [1:0]  wb_ctlout;
    wire [2:0]  id_ex_mem;
    wire [3:0]  id_ex_execute;
    wire [31:0] id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext;
    wire [4:0]  id_ex_instr_bits_20_16, id_ex_instr_bits_15_11;

    // ------------------ EX Stage Wires ------------------
    wire [1:0]  ex_mem_wb;
    wire [2:0]  ex_mem_mem;
    wire        zero;
    wire [31:0] alu_result, ex_mem_rdata2;
    wire [4:0]  ex_mem_muxout;

    // ------------------ MEM Stage Wires ------------------
    wire [1:0]  mem_wb_wb;
    wire [31:0] mem_read_data, mem_alu_result;
    wire [4:0]  mem_write_reg;
    wire        pcsrc;

    // ------------------ WB Stage Wires ------------------
    wire [31:0] wb_data;

    // ------------------ IF Stage ------------------
    IF_stage IF (
        .clk(clk),
        .reset(reset),
        .ex_mem_pcrsrc(pcsrc),
        .ex_mem_npc(mem_npc),
        .IF_ID_npc(IF_ID_npc),
        .IF_ID_instr(IF_ID_instr)
    );

    // ------------------ ID Stage ------------------
    ID_stage ID (
        .clk(clk),
        .rst(reset),
        .wb_reg_write(mem_wb_wb[1]),
        .wb_write_reg_location(mem_wb_writereg),
        .mem_wb_write_data(mem_wb_writedata),
        .if_id_instr(IF_ID_instr),
        .if_id_npc(IF_ID_npc),
        .wb_ctlout(wb_ctlout),
        .id_ex_mem(id_ex_mem),
        .id_ex_execute(id_ex_execute),
        .id_ex_npc(IF_ID_npc),  // Forwarded NPC from IF stage
        .id_ex_readdat1(id_ex_readdat1),
        .id_ex_readdat2(id_ex_readdat2),
        .id_ex_sign_ext(id_ex_sign_ext),
        .id_ex_instr_bits_20_16(id_ex_instr_bits_20_16),
        .id_ex_instr_bits_15_11(id_ex_instr_bits_15_11)
    );

    // ------------------ EX Stage ------------------
    EX_stage EX (
        .clk(clk),
        .ctlwb_in(id_ex_wb),
        .ctlm_in(id_ex_mem),
        .npc(IF_ID_npc),  // still using this name for NPC
        .rdata1(id_ex_readdat1),
        .rdata2(id_ex_readdat2),
        .s_extend(id_ex_sign_ext),
        .instr_2016(id_ex_instr_bits_20_16),
        .instr_1511(id_ex_instr_bits_15_11),
        .alu_op(id_ex_execute[3:2]),
        .funct(id_ex_sign_ext[5:0]),       // assume function code is from sign_ext
        .alusrc(id_ex_execute[1]),
        .regdst(id_ex_execute[0]),
        .ctlwb_out(ex_mem_wb),
        .ctlm_out(ex_mem_mem),
        .adder_out(),                      // Not used after this stage
        .alu_result_out(alu_result),
        .rdata2_out(ex_mem_rdata2),
        .muxout_out(ex_mem_muxout)
    );

    // ------------------ MEM Stage ------------------
    MEM_stage MEM (
        .clk(clk),
        .ALUResult(alu_result),
        .WriteData(ex_mem_rdata2),
        .WriteReg(ex_mem_muxout),
        .WBControl(ex_mem_wb),
        .MemWrite(ex_mem_mem[1]),
        .MemRead(ex_mem_mem[0]),
        .Branch(ex_mem_mem[2]),
        .Zero(zero),
        .ReadData(mem_read_data),
        .ALUResult_out(mem_alu_result),
        .WriteReg_out(mem_write_reg),
        .WBControl_out(mem_wb_wb),
        .PCSrc(pcsrc)
    );

    // ------------------ WB Stage ------------------
    WB_stage WB (
        .mem_Read_data(mem_read_data),
        .mem_ALU_result(mem_alu_result),
        .MemtoReg(mem_wb_wb[0]),
        .wb_data(wb_data)
    );

    // ------------------ Output Assignments ------------------
    assign WB_out = mem_wb_wb;              // Write-back control signals
    assign read_data_out = mem_read_data;   // Data read from memory
    assign alu_result_out = mem_alu_result; // ALU result from MEM stage
    assign write_reg_out = mem_write_reg;   // Write register address
    assign PCSrc = pcsrc;                   // PC source for branch decision
    assign write_data_out = wb_data;        // Write-back data from WB stage

endmodule
