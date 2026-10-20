// Copyright (c) 2026 Waleed Alakwa
// SPDX-License-Identifier: MIT

module system_fsm(
    input clk,
    input reset,
    output reg load_data,
    output reg start_encrypt,
    output reg start_decrypt,
    output reg data_ready
);

// State Definitions using parameters
parameter IDLE = 3'b000,
          INIT = 3'b001,
          LOAD = 3'b010,
          ENCRYPT = 3'b011,
          DECRYPT = 3'b100,
          OUTPUT = 3'b101;

reg [2:0] current_state, next_state;

// State transition logic
always @(posedge clk or negedge reset) begin
    if (!reset)
        current_state <= INIT;
    else
        current_state <= next_state;
end

// Next state logic
always @(*) begin
    case (current_state)
        INIT: next_state = LOAD;
        LOAD: next_state = ENCRYPT;
        ENCRYPT: next_state = DECRYPT;
        DECRYPT: next_state = OUTPUT;
        OUTPUT: next_state = IDLE;
        IDLE: next_state = (data_ready ? LOAD : IDLE);
        default: next_state = IDLE;
    endcase
end

// Output logic based on the state
always @(*) begin
    load_data = (current_state == LOAD);
    start_encrypt = (current_state == ENCRYPT);
    start_decrypt = (current_state == DECRYPT);
    data_ready = (current_state == OUTPUT);
end

endmodule
