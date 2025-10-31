`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2025 10:52:17 PM
// Design Name: 
// Module Name: tb_riscv_single
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


module tb_riscv_single();

    // INPUT Declarations
    reg clk, reset;
    
    // OUTPUT Declarations
    wire [31:0] WriteData, DataAddr;
    wire MemWrite;
    
    // DUT instantiation
    top DUT(.clk(clk),
            .reset(reset),
            .WriteData(WriteData),
            .DataAddr(DataAddr),
            .MemWrite(MemWrite)
    );
    
    // Simulate the FPGA clock = 100MHz --> local_clk = 20MHz 
    initial clk = 1'b0;
    always #5 clk = ~clk;   

    // Init test
    initial begin
        reset <= 1'b1;
        #22;
        reset <= 1'b0;
        $display("### SIMULATION STARTED ###");
        
        // Check result FACTORIAL PROGEAM
        repeat(2000) begin
            #10;            // 1 FPGA clock cycle
        end
        
        $finish;
    end

    // Check result for PROGRAM 2 
//    always @ (posedge clk) begin
//        $display("### Data Addr = 0x%h, Data = 0x%h ##", DataAddr, WriteData);
//        if (MemWrite == 1'b1) begin
//            #25;
//            $display("### Data Addr = 0x%h, Data = 0x%h ###", DataAddr, WriteData);
//            if (DataAddr === 32'h0000000c && WriteData === 32'h00000248) begin
//                $display("### Simulation PASSED ###");
//                $stop;
//            end else begin
//                $display("### Simulation FAILED ###");
//                $stop;
//            end
//        end
//    end

/************************************************************************************************/

   // check results for ADDITIONAL PROGRAM
//   always @(negedge clk)
//   begin
//        if(MemWrite) begin
//           if(DataAddr === 100 & WriteData === 25) begin
//              $display("Simulation succeeded");
//              $stop;
//           end else if (DataAddr !== 96) begin
//              $display("Simulation failed");
//              $stop;
//           end
//         end
//   end
   
endmodule
