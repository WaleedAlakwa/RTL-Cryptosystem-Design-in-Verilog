// Copyright (c) 2026 Waleed Alakwa
// SPDX-License-Identifier: MIT

module Top (
   // Clock and reset input signals
   input clk,
   input rst,
   
   // Data input signal from ROM
   input [7:0] ram_input_data,
   
   // Encrypted and decrypted memory output signals
   output [7:0] encrypted_Output,
   output [7:0] decrypted_Output,
   
   // Full and empty status output signals
   output wire queue_R,
   output wire queue_NR
);

 // Internal signals for RAM and FIFO outputs
 wire [7:0] ram_output;
 wire [7:0] fifo_output;
 
 // Internal signals for read and write enable
 wire read_enable = ~queue_NR;
 wire write_enable = ~queue_R;
 
 // Internal signals for encryption and decryption outputs
 wire [7:0] encrypted_result;
 wire [7:0] encrypted_memory_output;
 wire [7:0] decrypted_result;
 wire [7:0] decrypted_memory_output;
 
 
// Internal signal connections
wire [7:0] lookup_address, reverse_lookup_address, encryption_output;
wire [7:0] lookup_result, reverse_lookup_result, decryption_output;
 
 
 // Instantiate the RAM module
 DataStorageRAM ram_instance (
   .clk(clk),
   .reset(rst),
   .access_addr(ram_input_data),
   .data_out(ram_output),
   .crypt_addr(ram_input_data),
   .crypt_data_in(encryption_output),
   .crypt_data_out(encrypted_memory_output),
   .decrypt_addr(ram_input_data),
   .decrypt_data_in(decryption_output),
   .decrypt_data_out(decrypted_memory_output)
 );
 
 
 // Instantiate Substitution Table ROM
 LookupTableROM lookup_rom (
    .clk(clk),
    .address(encrypted_result),
    .output_data(lookup_result)
);

// Instantiate Inverse Table ROM
 ReverseLookupROM reverse_lookup_rom (
    .clk(clk),
    .address(decrypted_result),
    .output_data(reverse_lookup_result)
);

 
 
 
 // Instantiate the FIFO module
 FIFO fifo_instance (
   .clk(clk),
   .rst(rst),
   .enqueue(write_enable),
   .data_in(ram_output),
   .dequeue(read_enable),
   .data_out(fifo_output),
   .queue_full(queue_R),
   .queue_empty(queue_NR)
 );
 
 // Instantiate the encryption module
 Encryptor encryption_module (
    .clk(clk),
    .data_in(fifo_output),
    .enc_key1(8'h35), // Example key for encryption
    .enc_key2(8'h6F), // Example key for encryption
    .encrypted_data(encrypted_result),
    .rotation_result(lookup_address),
    .lookup_result(lookup_result),
    .intermediate_data(encryption_output)
 );

// Instantiate the decryption module
 Decryptor decryption_module (
    .clk(clk),
    .encrypted_data(encryption_output),
    .dec_key1(8'h35), // Example key for decryption
    .dec_key2(8'h6F), // Example key for decryption
    .data_out(decrypted_result),
    .reverse_lookup_result(reverse_lookup_result),
    .final_result(decryption_output)
);
 
 
 // Assign the outputs to the corresponding internal signals
 assign encrypted_Output = encrypted_memory_output;
 assign decrypted_Output = decrypted_memory_output;

endmodule
