`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2022 08:29:23 AM
// Design Name: 
// Module Name: tb_ALU
// Project Name: RISC-V Single Cycle Processor
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

module tb_alu();

	wire 	[31:0] 	Y;                      
	wire 			zero;
	reg [31:0] expected;
	
	reg 	[31:0] 	A, B;
	reg 	[2:0] 	opcode;
  
	ALU dut (.a(A),
	         .b(B),
	         .ALUControl(opcode),
	         .zero(zero),
	         .ALUResult(Y)
	);
  
	initial begin
	    expected = 32'd0;

		#10;
		opcode = 3'b010; 	// AND
		A = 32'h00000005;
		B = 32'h00000004;		
		expected = A & B;
		#10;                // Prop. delay
		$display("### A = %h, B = %h ###", A , B);
		$display("Y = %h, expected = %h", Y, expected);
		if (Y == expected) begin
		  $display("AND: PASSED");
		end else $display("AND: FAILED");
		
		#10;
		opcode = 3'b011;	// OR
		A = 32'h00000007;
		B = 32'h00000008;
		expected = A | B;	
		#10;
		$display("### A = %h, B = %h ###", A , B);
		$display("Y = %h, expected = %h", Y, expected);	
		if (expected == Y) begin
		  $display("OR: PASSED");
		end else $display("OR: FAILED");
		
	 	#10;
		opcode = 3'b000;	// ADD
		A = 32'h00000005;
		B = 32'h00000004;
		expected = A + B;
		#10;
		$display("### A = %h, B = %h ###", A , B);
		$display("Y = %h, expected = %h", Y, expected);
	    if (expected == Y) begin
		  $display("ADD: PASSED");
		end else $display("ADD: FAILED");	
			
		#10;
		opcode = 3'b001;	// SUB
		A = 32'h00000009;
		B = 32'h00000004;	
		expected = A - B;	
		#10;
		$display("### A = %h, B = %h ###", A , B);
		$display("Y = %h, expected = %h", Y, expected);
	    if (expected == Y) begin
		  $display("SUB: PASSED");
		end else $display("SUB: FAILED");
		
		#10;
		opcode = 3'b100;	// Mult 
		A = 32'h00000007;
		B = 32'h00000005;
		expected = A * B;		
		#10;
		$display("### A = %h, B = %h ###", A , B);
		$display("Y = %h, expected = %h", Y, expected);
	    if (expected == Y) begin
		  $display("MULT: PASSED");
		end else $display("MULT: FAILED");
		
		#10;
		opcode = 3'b101;	// Bit Shift
		A = 32'h00000003;
		B = 32'h00000004;
		expected = A << B[4:0];
		#10;
		$display("### A = %h, B = %h ###", A , B);
		$display("Y = %h, expected = %h", Y, expected);
	    if (expected == Y) begin
		  $display("BIT SHIFT: PASSED");
		end else $display("BIT SHIFT: FAILED");
		
		#10;
	    opcode = 3'b110;	// SLT
		A = 32'h00000003;
		B = 32'h00000004;
		expected = 32'd1;   // A < B
		#10;
		$display("### A = %h, B = %h ###", A , B);
		$display("Y = %h, expected = %h", Y, expected);
	    if (expected == Y) begin
		  $display("SLT: PASSED");
		end else $display("SLT: FAILED");
		
		#10;
		$stop;

	end
endmodule
