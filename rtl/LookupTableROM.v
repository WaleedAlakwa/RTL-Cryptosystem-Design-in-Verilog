// Copyright (c) 2026 Waleed Alakwa
// SPDX-License-Identifier: MIT


module LookupTableROM (
    input clk,  // Clock signal
    input [7:0] address,  // Address for read operation
    output reg [7:0] output_data  // Data output from ROM
);

    reg [7:0] lookup_table [0:255];  // ROM for lookup table

    // Initialize ROM with data from a hexadecimal file
    initial begin
        $readmemh("lookup_data.hex", lookup_table);
    end

    // Output data based on the address on clock edge
    always @(posedge clk) begin
        if (address)  // Check for a non-zero address
            output_data = lookup_table[address];  // Assign data to output
    end
     
endmodule
