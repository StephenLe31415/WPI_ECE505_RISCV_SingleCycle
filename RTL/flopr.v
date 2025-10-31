`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2025 08:50:31 PM
// Design Name: Resettable FF
// Module Name: flopr
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


module flopr #(parameter W = 8) (
    input clk, reset,
    input [W-1:0]d,
    output reg [W-1:0]q
    );
    
    always @ (posedge clk or posedge reset) begin
        if (reset == 1'b1) q <= 0;                  // reset: PC = 0x00000000
        else q <= d;
    end
endmodule
