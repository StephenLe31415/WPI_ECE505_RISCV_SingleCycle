`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 08:29:23 AM
// Design Name: 
// Module Name: tb_reg_rom
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

module rb_reg_rom;
    reg [31:0] A; //5 bit register address input
    wire [31:0] rd;  //read data outputs
    integer i;

    reg_rom DUT(.addr(A),
              .rd(rd)
    );
    
    initial begin
    A = 32'd0;
    for (i = 0; i < 128; i = i + 4) begin
        A = i;
        #25;          // Prop delay
        $display("### addr = 0x%h, Instr = 0x%h ###", A, rd);
        #50;          // 1 whole clock period
    end
    $stop;
    
    end
endmodule

//    // Read instruction from address 0
//    A = 32'h00000000;
//    #10; // Wait for some time
//    $display("### addr = 0x%h, Instr = 0x%h ###", A, rd);

//    // Read instruction from address 1
//    A = 32'h00000004;
//    #10; // Wait for some time
//    $display("### addr = 0x%h, Instr = 0x%h ###", A, rd);

//    // Read instruction from address 2
//    A = 32'h00000008;
//    #10; // Wait for some time
//    $display("### addr = 0x%h, Instr = 0x%h ###", A, rd);

//    // Read instruction from address 3
//    A = 32'h0000000C;
//    #10; // Wait for some time
//    $display("### addr = 0x%h, Instr = 0x%h ###", A, rd);