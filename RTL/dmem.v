`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2025 04:13:40 PM
// Design Name: 
// Module Name: dmem
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


module dmem(
    input clk,
    input WE,
    input [31:0] addr,
    input [31:0] wd,      // Write Data to mem.
    output [31:0] rd      // Read Data from mem - Unregistered
    );
    
    reg [31:0] RAM[255:0];      // 256 x 32-bit = 1KB RAM --> downwards addressing
    
    // Preload mem. with values
    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            RAM[i] = 32'd0;
        end
    end
    
    // Writing onto mem.
    always @ (posedge clk) begin
        if (WE == 1'b1) RAM[addr[31:2]] <= wd;
    end
    
    // Reading from mem.
    assign rd = RAM[addr[31:2]];        // Combinaitonal read
    
endmodule
