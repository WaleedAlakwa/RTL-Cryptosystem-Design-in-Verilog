// Copyright (c) 2026 Waleed Alakwa
// SPDX-License-Identifier: MIT


module Encryptor(
    input clk,
    input [7:0] data_in,
    input [7:0] enc_key1,
    input [7:0] enc_key2,
    output reg [7:0] encrypted_data, intermediate_data, rotation_result,
    
    input [7:0] lookup_result  // Result from lookup table
);

reg  [7:0] stage1_output;
reg [0:7] rotated_bits;

always @(posedge clk) begin
		encrypted_data = data_in ^ enc_key1; // Initial XOR with first key
		if(lookup_result) begin
			rotated_bits = (lookup_result >> 3) | (lookup_result << (8-3)); // Rotate bits
			rotation_result = rotated_bits;
			intermediate_data = rotation_result ^ enc_key2; // XOR with second key
		end             
end

endmodule

