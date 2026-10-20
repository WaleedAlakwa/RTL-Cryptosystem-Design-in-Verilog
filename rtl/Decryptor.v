// Copyright (c) 2026 Waleed Alakwa
// SPDX-License-Identifier: MIT


module Decryptor(
    input clk,
    input [7:0] encrypted_data,
    input [7:0] dec_key1,
    input [7:0] dec_key2,
    output reg [7:0] data_out, final_result,
    
    input [7:0] reverse_lookup_result
);

reg [7:0] stage1_decrypted;

always @(posedge clk) begin
		if (encrypted_data) begin
		 	stage1_decrypted = encrypted_data ^ dec_key2; // Initial decryption step
		 	
			data_out = (stage1_decrypted >> 5) | (stage1_decrypted << (8-5)); // Rotate bits
		end
		if (reverse_lookup_result) begin
			final_result = reverse_lookup_result ^ dec_key1; // Final decryption step
		end	
end

endmodule
