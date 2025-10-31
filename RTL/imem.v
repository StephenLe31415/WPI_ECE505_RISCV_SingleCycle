`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2025 04:06:16 PM
// Design Name: 
// Module Name: imem
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


module imem (
    input [31:0] a,
    output [31:0] rd
);

    reg [31:0] RAM[255:0]; // 1KB instruction memory

    initial begin
        $readmemh("risc_v_test.mem", RAM);
    end

    assign rd = RAM[{a[31:2], 2'b00}]; // word-aligned access

endmodule

