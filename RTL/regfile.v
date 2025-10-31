`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2025 04:07:44 PM
// Design Name: 
// Module Name: regfile
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


module regfile(
    input clk, reset,
    input WE3,
    input [31:0] WD3,
    input [4:0] A1, A2, A3,
    output [31:0] RD1, RD2
    );
    
    reg [31:0] mem[31:0];
    
    always @ (posedge clk) begin
        if ((WE3 == 1'b1) && (A3 != 5'd0)) mem[A3] <= WD3;      // Clocked Read/Write
    end
    
    assign RD1 = (reset == 1'b1)? 32'd0 : mem[A1];
    assign RD2 = (reset == 1'b1)? 32'd0 : mem[A2];
    
    integer i;
//    always @ (posedge clk) begin
//        if (reset == 1'b1) begin
//            for (i = 0; i < 32; i = i + 1) begin
//                mem[i] = 32'd0;
//            end
//            // Initilize SP (x2) to the last memory address
//            mem[2] = 32'd31;
            
//        end
//    end

    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            mem[i] = 32'd0;
        end
        // Initilize SP (x2) to the last memory address
        mem[2] = 32'h000003FC;
    end

    
endmodule
