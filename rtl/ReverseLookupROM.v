// Copyright (c) 2026 Waleed Alakwa
// SPDX-License-Identifier: MIT


module ReverseLookupROM (
    input clk,  // Clock signal
    input [7:0] address,  // Address for read operation
    output reg [7:0] output_data  // Data output from ROM
);

    reg [7:0] reverse_lookup [0:255];  // ROM for reverse lookup table

    // Load reverse lookup data from a hexadecimal file
    initial begin
        $readmemh("reverse_lookup_data.hex", reverse_lookup);
    end

    // Retrieve data from ROM on clock signal
    always @(posedge clk) begin
        if (address)  // Check if address input is valid
            output_data = reverse_lookup[address];  // Update output data
    end
     
endmodule
