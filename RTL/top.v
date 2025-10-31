`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2025 04:55:39 PM
// Design Name: 
// Module Name: top
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


module top(
    input clk,      // 100MHz iput from the FPGA 
    input reset,
    output [31:0] WriteData,        // Data written to Mem. 
    output [31:0] DataAddr,         // Address to write the data to
    output MemWrite
    );
    
    wire [31:0] PC, Instr, ReadData;
    wire clk_local, locked;
    
    // 20MHz clock generation
    clk_wiz_0 local_clk(.clk_out1(clk_local),
                        .reset(reset),
                        .locked(locked),
                        .clk_in1(clk)
    );
    
    // Instantiate Processor
    RISCV_single riscvSingle(.clk(clk_local),
                             .reset(reset),
//                             .PC(PC),
//                             .Instr(Instr),
//                             .ReadData(ReadData),
                             .MemWrite(MemWrite),
                             .ALUResult(DataAddr),      // Output of ALU = address to Data Mem.
                             .WriteData(WriteData)
    );
    
endmodule
