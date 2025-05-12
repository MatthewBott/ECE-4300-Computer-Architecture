`timescale 1ns / 1ps

module pipelineTB;

    // Inputs
    reg clk;
    reg reset;
    reg [31:0] mem_npc;
    reg [4:0] mem_wb_writereg;
    reg [31:0] mem_wb_writedata;

    // Outputs
    wire [1:0] WB_out;
    wire [31:0] read_data_out;
    wire [31:0] alu_result_out;
    wire [4:0] write_reg_out;
    wire PCSrc;
    wire [31:0] write_data_out;

    // Instruction and Data memory
    reg [31:0] MEM [0:255]; // Shared memory for demonstration
    integer i;

    // Instantiate the pipeline
    pipeline uut (
        .clk(clk),
        .reset(reset),
        .mem_npc(mem_npc),
        .mem_wb_writereg(mem_wb_writereg),
        .mem_wb_writedata(mem_wb_writedata),
        .WB_out(WB_out),
        .read_data_out(read_data_out),
        .alu_result_out(alu_result_out),
        .write_reg_out(write_reg_out),
        .PCSrc(PCSrc),
        .write_data_out(write_data_out)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        mem_npc = 0;
        mem_wb_writereg = 0;
        mem_wb_writedata = 0;

        // Display risc.txt content
        $readmemb("risc.txt", MEM);
        $display("\n-- Contents of risc.txt (Instruction Memory) --");
        for (i = 0; i < 24; i = i + 1)
            $display("Instruction Memory [%0d] = %b", i, MEM[i]);

        // Display data.txt content
        $readmemb("data.txt", MEM);
        $display("\n-- Contents of data.txt (Data Memory) --");
        for (i = 0; i < 6; i = i + 1)
            $display("Data Memory [%0d] = %b", i, MEM[i]);

        // Reset sequence
        #10 reset = 0;

        // Run simulation for a few cycles
        #100;

        // Display key outputs
        $display("\n-- Final Pipeline Outputs --");
        $display("WB_out          = %b", WB_out);
        $display("read_data_out   = %h", read_data_out);
        $display("alu_result_out  = %h", alu_result_out);
        $display("write_reg_out   = %d", write_reg_out);
        $display("PCSrc           = %b", PCSrc);
        $display("write_data_out  = %h", write_data_out);

        $finish;
    end

endmodule
