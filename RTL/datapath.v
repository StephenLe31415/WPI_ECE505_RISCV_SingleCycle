`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2025 03:48:46 PM
// Design Name: 
// Module Name: datapath
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


module datapath(
    input clk, reset,
    input [1:0] ResultSrc,
    input PCSrc, ALUSrc,
    input RegWrite,
    input [1:0] ImmSrc,
    input [2:0] ALUControl,
    input [31:0] Instr,
    input [31:0] ReadData,
    output zero,
    output [31:0] PC,
    output [31:0] ALUResult, WriteData
    );
    
    wire [31:0] PCNext, PCPlus4, PCTarget;
    wire [31:0] ImmExt;
    wire [31:0] SrcA, SrcB;
    wire [31:0] Result;
    
    // isJalr logic
    wire isJalr;                                                // TRUE if instr. = jalr
    assign isJalr = (Instr[6:0] == 7'b1100111)? 1'b1 : 1'b0;    // Opcode for jalr is UNIQUE
    
    // Next PC logic
    flopr #(32) pcreg(.clk(clk),
                      .reset(reset),
                      .d(PCNext),
                      .q(PC)
    );
    
    adder pcAdd4(.a(PC),
                 .b(32'd4),
                 .y(PCPlus4)
    );
    
    adder pcAddBranch(.a(PC),
                      .b(ImmExt),
                      .y(PCTarget)
    );
    
//    mux2 #(32) pcMux(.d0(PCPlus4),
//                     .d1(PCTarget),
//                     .s(PCSrc),
//                     .y(PCNext)
//    );

    pcMux mux4PC(.PCPlus4(PCPlus4),
                 .PCTarget(PCTarget),
                 .RD1_Imm_Sum(ALUResult),       // jalr needs [rd1] + imm
                 .PCSrc(PCSrc),
                 .isJalr(isJalr),                 // asserted based on opcode from Instr.
                 .PCNext(PCNext)
    );
     
    // Reg file Logic
    regfile rf(.clk(clk),
               .reset(reset),
               .WE3(RegWrite),
               .WD3(Result),            // WB result from mux3
               .A1(Instr[19:15]),       // Src reg 1
               .A2(Instr[24:20]),       // Src reg 2
               .A3(Instr[11:7]),        // Write Destination Reg
               .RD1(SrcA),
               .RD2(WriteData)          // SrcB
    );
    
    extend ext(.instr(Instr),
               .immsrc(ImmSrc),
               .immext(ImmExt)
    );
    
    // ALU logic
    // Operand B Mux
    mux2 #(32) srcbMux(.d0(WriteData),
                       .d1(ImmExt),
                       .s(ALUSrc),
                       .y(SrcB)
    );
    
    ALU alu(.a(SrcA),
            .b(SrcB),   
            .ALUControl(ALUControl),
            .ALUResult(ALUResult),
            .zero(zero)
    );
    
    // Write Back Mux
    mux3 #(32) resultMux(.d0(ALUResult),
                         .d1(ReadData),
                         .d2(PCPlus4),
                         .s(ResultSrc),
                         .y(Result)
    );
    
endmodule
