`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2025 08:57:01 PM
// Design Name: 
// Module Name: mux3
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


module mux3 #(parameter W = 8) (
    input [W-1:0] d0, d1, d2,
    input [1:0] s,
    output [W-1:0] y
    );
    
    assign y = (s[1] == 1'b1)? d2 : ((s[0] == 1'b1)? d1 : d0);
    
endmodule
