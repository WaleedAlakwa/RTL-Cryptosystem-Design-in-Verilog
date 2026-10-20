// Copyright (c) 2026 Waleed Alakwa
// SPDX-License-Identifier: MIT

module SRAM_Buffer  (
    input clk,
    input [6:0] write_idx,
    input [6:0] read_idx,
    output reg [7:0] out_data,
    input [7:0] in_data,
    input read_en,
    input write_en
    );

    reg [7:0] buffer[0:255];  // Buffer for data storage

    // Handle data writing to buffer on clock edge
    always @(posedge clk)
    begin
        if (write_en)
            buffer[write_idx] <= in_data;
    end

    // Asynchronous read from buffer
    always @(read_idx)
    begin
        if (read_en)
            out_data <= buffer[read_idx];
    end

endmodule
