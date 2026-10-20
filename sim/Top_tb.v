// Copyright (c) 2026 Waleed Alakwa
// SPDX-License-Identifier: MIT


// Define the testbench for the System Integration module
module Top_tb;

 // Define the clock, reset, and ROM input signals, and the encrypted, decrypted output signals
 reg clk;
 reg rst;
 wire [7:0] encrypted_Output;
 wire [7:0] decrypted_Output;
 reg [7:0] ram_input_data;
 wire queue_R;
 wire queue_NR;
  // Define the arrays for storing the encrypted and decrypted outputs
 integer j;
 integer encrypted_data_array[0:255];
 integer decrypted_data_array[0:255];


 // Instantiate the System Integration module
 Top uut (
   .clk(clk),
   .rst(rst),
   .ram_input_data(ram_input_data),
   .encrypted_Output(encrypted_Output),
   .decrypted_Output(decrypted_Output),
   .queue_R(queue_R),
   .queue_NR(queue_NR)
 );

 // Generate a clock signal
 always begin
   #5 clk = ~clk; 
 end

 // Test the System Integration module
 initial begin
  
   // Initialize the clock and reset signals, and the loop variable
   clk = 0;
   rst = 1;
   j = 0;

   // Release the reset signal after 10 time units
   #10 rst = 0;
   #10;
  
   // Test the System Integration module with different RAM input values
   for (j = 0; j < 15; j = j + 1) begin
     if (!queue_NR) begin
     ram_input_data = j;
     #10;
     encrypted_data_array[j] = encrypted_Output; 
     decrypted_data_array[j] = decrypted_Output; 
     end
   end
   
   
   rst = 1; #10;

   
 end

endmodule
