`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2025 08:05:25 PM
// Design Name: 
// Module Name: pcMux
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


module pcMux(
    input [31:0] PCPlus4,       // PCPlus4 = PC + 4
    input [31:0] PCTarget,      // PCTarget = PC + ImmExt
    input [31:0] RD1_Imm_Sum,   // RS1_Imm_Sum = [RD1] + ImmExt = ALUResult & 0xFFFFFFFFE
//    input [31:0] RD1,
//    input [31:0] ImmExt,
    input PCSrc,
    input isJalr,
    output [31:0] PCNext
    );
    
//    wire RD1_Imm_Sum;
//    assign RD1_Imm_Sum = RD1 + ImmExt;
    
    assign PCNext = (isJalr == 1'b1)? (RD1_Imm_Sum & 32'hFFFFFFFE) :            // jalr overrides
                    ((PCSrc == 1'b1)? PCTarget : PCPlus4);                      // Default pc mux logic
                    
endmodule
