`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2025 04:46:17 PM
// Design Name: 
// Module Name: RISCV_single
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


module RISCV_single(
    input clk, reset,
//    input [31:0] Instr,
//    input [31:0] ReadData,
//    output [31:0] PC,
    output MemWrite,                        // Mainly for tb
    output [31:0] ALUResult, WriteData      // Mainly for tb
    );
    
    wire ALUSrc, RegWrite, Jump, Zero, PCSrc;
    wire [1:0] ResultSrc, ImmSrc;
    wire [2:0] ALUControl;
    wire [31:0] ReadData, Instr, PC;        // Internal wires
    
    controller cntrl(.op(Instr[6:0]),
                    .funct3(Instr[14:12]),
                    .funct7(Instr[31:25]),
                    .zero(Zero),
                    .ResultSrc(ResultSrc),
                    .MemWrite(MemWrite),
                    .PCSrc(PCSrc),
                    .ALUSrc(ALUSrc),
                    .RegWrite(RegWrite),
                    .Jump(Jump),
                    .ImmSrc(ImmSrc),
                    .ALUControl(ALUControl)
    );
    
    datapath dtpth(.clk(clk),
                   .reset(reset),
                   .ResultSrc(ResultSrc),
                   .PCSrc(PCSrc),
                   .ALUSrc(ALUSrc),
                   .RegWrite(RegWrite),
                   .ImmSrc(ImmSrc),
                   .ALUControl(ALUControl),
                   .Instr(Instr),
                   .ReadData(ReadData),
                   .zero(Zero),
                   .PC(PC),                 // Produces the PC for imem
                   .ALUResult(ALUResult),
                   .WriteData(WriteData)    
    );
    
    blk_mem_gen_0 dmem(.clka(clk),
                       .ena(1'b1),
                       .wea(MemWrite),
                       .addra(ALUResult[7:0]),     // Word-aligned, since we use IP for DataMem, no need to discard the lower 2 bits!!!
                       .dina(WriteData),
                       .douta(ReadData)
    );
    
    // Instr. mem.
    reg_rom imem(.addr(PC),         // Input: the address of the instr. pointed to by PC
                 .rd(Instr)         // Output: the instr. pointed to by PC
    );
    
endmodule
