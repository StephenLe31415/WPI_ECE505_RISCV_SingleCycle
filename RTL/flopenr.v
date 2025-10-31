`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2025 08:53:10 PM
// Design Name: 
// Module Name: flopenr
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


module flopenr #(parameter W = 8)(
    input clk, reset, en,
    input [W-1:0]d,
    output reg [W-1:0]q
    );
    
    always @ (posedge clk, reset) begin
        if (reset == 1'b1) q <= 0;
        else if (en == 1'b1) q <= d;
    end
endmodule
