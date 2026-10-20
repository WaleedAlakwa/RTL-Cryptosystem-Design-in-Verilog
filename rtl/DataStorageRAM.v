// Copyright (c) 2026 Waleed Alakwa
// SPDX-License-Identifier: MIT

module DataStorageRAM (
    input wire clk,
    input wire reset,
    input [7:0] access_addr,
    output reg [7:0] data_out,
    input [7:0] crypt_addr,  // Encryption data address
    input [7:0] crypt_data_in,  // Input data for encryption
    output reg [7:0] crypt_data_out,  // Output data from encryption
    input [7:0] decrypt_addr,  // Decryption data address
    input [7:0] decrypt_data_in,  // Input data for decryption
    output reg [7:0] decrypt_data_out  // Output data from decryption
);

// Declaring memory arrays
reg [7:0] main_memory [0:255];
reg [7:0] encryption_buffer [0:255];  // Encryption buffer array
reg [7:0] decryption_buffer [0:255];  // Decryption buffer array


initial begin
    $readmemh("main_message.hex", main_memory);
end


// Handling write operations
always @(*) begin
    encryption_buffer[crypt_addr] <= crypt_data_in;  // Store data in encryption buffer
    decryption_buffer[decrypt_addr] <= decrypt_data_in;  // Store data in decryption buffer
end

// Managing read operations
always @(posedge clk) begin
    if (access_addr) begin
        data_out <= main_memory[access_addr];  // Retrieve data from main memory
    end
    if (crypt_data_in) begin
        crypt_data_out = encryption_buffer[crypt_addr];  // Retrieve data from encryption buffer
    end
    if (decrypt_data_in) begin
        decrypt_data_out = decryption_buffer[decrypt_addr];  // Retrieve data from decryption buffer
    end
end

endmodule
