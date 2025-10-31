`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2025 09:56:27 PM
// Design Name: 
// Module Name: aludec
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


module aludec(
    input [6:0] op,
    input [6:0] funct7,
    input [2:0] funct3,
    input [1:0] ALUOp,
    output wire beq, bne,
    output reg [2:0] ALUControl
    );

    always @ (*) begin
        case (ALUOp)
            2'b00 : ALUControl = 3'b000;    // ADDition
            2'b01 : ALUControl = 3'b001;    // SUB
            default : begin
                case (funct3)                                                   // Funct3
                    3'b000 : begin                                              // Look at funct7 --> no need those extra wires
                        if (funct7 == 7'd1) ALUControl = 3'b100;                // MUL
                        else if (funct7 == 7'd32) ALUControl = 3'b001;          // SUB
                        else ALUControl = 3'b000;                               // ADDI - has no funct7 OR ADD w/ funct7 = 0x0
                    end
                    3'b001 : ALUControl = 3'b101;                               // SLLI
                    3'b010 : ALUControl = 3'b110;                               // SLT
                    3'b110 : ALUControl = 3'b011;                               // OR
                    3'b111 : ALUControl = 3'b010;                               // AND
                    default : ALUControl = 3'bxxx;
                endcase
            end
            2'b11 : ALUControl = 3'bxxx;                // HALT
        endcase
    end
    
    assign bne = (ALUOp == 2'b01 && funct3 == 3'b001)? 1'b1 : 1'b0;
    assign beq = (ALUOp == 2'b01 && funct3 == 3'b000)? 1'b1 : 1'b0;
    
endmodule
