// Copyright (c) 2026 Waleed Alakwa
// SPDX-License-Identifier: MIT


module clock_driver (
    input Clock_in,     // input: 50 MHz clock signal
    output reg Clock_out  // output: 4 Hz clock signal
);

// variable to keep track of the count
reg [25:0] counter = 0; // 26 bits to count upto 50_000_000

always @(posedge Clock_in) begin
    if(counter < 50_000_000) begin
        counter <= counter + 1;
        Clock_out <= 0;
    end
    else begin
        counter <= 0;
        Clock_out <= 1;
    end
end

endmodule