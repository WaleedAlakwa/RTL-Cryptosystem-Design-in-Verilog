// Copyright (c) 2026 Waleed Alakwa
// SPDX-License-Identifier: MIT


module FIFO(
    // Input signals
    input  clk,
    input  rst,

    // Control signals
    input  enqueue,
    input [7:0] data_in,
    input  dequeue,
    // Output data signal
    output [7:0] data_out,

    // Queue status outputs
    output reg queue_full,
    output reg queue_empty
    );

   // Internal state for managing the queue
   reg [7:0] next_len; 
   reg [7:0] curr_len;
   // Pointers for managing the queue
   reg [6:0] read_index;
   reg [6:0] write_index;
   // Activation signals for read/write operations
   wire active_read, active_write;

   // Conditions to trigger read and write operations
   assign active_read = dequeue && !queue_empty;
   assign active_write = enqueue && !queue_full;

   // Logic to update queue length
   always @(*)
     if (active_write && !active_read)
       next_len <= curr_len + 1;
     else if (!active_write && active_read)
       next_len <= curr_len - 1;
     else
       next_len <= curr_len;

   // Handle queue operations on clock's rising edge
   always @(posedge clk)
     begin
        curr_len <= next_len;
        queue_full <= (next_len == 256);
        queue_empty <= (next_len == 0);

        if (active_read)
          read_index <= read_index + 1;

        if (active_write)
          write_index <= write_index + 1;

        if (rst)
          begin
             queue_empty <= 1;
             queue_full <= 0;
             curr_len <= 0;
             read_index <= 0;
             write_index <= 0;
          end
     end

   // Memory instance for data storage
   SRAM_Buffer buffer_instance(
        .clk(clk),
        .write_idx(write_index),
        .read_idx(read_index),
        .write_en(active_write),
        .read_en(active_read),
        .in_data(data_in),
        .out_data(data_out)
        );
endmodule
