`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2025 12:02:41 AM
// Design Name: 
// Module Name: controller
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


module controller(
    input [6:0] op,
    input [2:0] funct3,
    input [6:0] funct7,
    input zero,
    output [1:0] ResultSrc,
    output MemWrite,
    output PCSrc, ALUSrc,
    output RegWrite, Jump,
    output [1:0] ImmSrc,
    output [2:0] ALUControl
    );
    
    wire [1:0] ALUOp;
    wire Branch;
    wire bne, beq;
    
    maindec md(.op(op),
               .ResultSrc(ResultSrc),
               .MemWrite(MemWrite),
               .Branch(Branch),
               .ALUSrc(ALUSrc),
               .RegWrite(RegWrite),
               .Jump(Jump),
               .ImmSrc(ImmSrc),
               .ALUOp(ALUOp)
    );
               
    aludec ad(.op(op),
              .funct7(funct7),
              .funct3(funct3),
              .ALUOp(ALUOp),
              .beq(beq),
              .bne(bne),
              .ALUControl(ALUControl)
    );
    
    assign PCSrc = (Branch & ((beq & zero) | (bne & ~zero))) | Jump;
    
endmodule
