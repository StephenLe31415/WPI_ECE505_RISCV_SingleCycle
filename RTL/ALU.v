`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2025 09:05:11 PM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Supports ADD, SUB, ADDI, LW, SW, MUL, SLLI, AND, OR
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input [31:0] a, b,
    input [2:0] ALUControl,
    output zero,
    output reg [31:0] ALUResult
    );
       
    // SLT logic
    wire [31:0] sum;
    wire signA, signB, signR, less_signed;
    
    assign sum = (ALUControl == 3'b001 || ALUControl == 3'b110)? (a - b) : (a + b);
    assign signA = a[31];
    assign signB = b[31];
    assign signR = sum[31];
    assign less_signed = (signA != signB)? signA : signR;     // True if signA < signB (signed)
       
    always @ (*) begin
        case(ALUControl)
            3'b000 : ALUResult = a + b;
            3'b001 : ALUResult = a + ((~b) + 1);
            3'b010 : ALUResult = a & b;
            3'b011 : ALUResult = a | b;
            3'b100 : ALUResult = a * b;
            3'b101 : ALUResult = a << b;
            3'b110 : ALUResult = {31'd0, less_signed};
            default : ALUResult = 32'd0;
        endcase
    end                
                       
    assign zero = &(~ALUResult);
    
endmodule