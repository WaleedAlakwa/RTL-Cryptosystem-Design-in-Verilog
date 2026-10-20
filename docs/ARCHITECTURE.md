# System Architecture

The project implements a modular byte-wide data transformation in Verilog.

## Functional blocks

1. **Input memory (`DataStorageRAM`)** — provides a byte array initialized from `main_message.hex`, plus separate encryption and decryption buffers.
2. **FIFO (`FIFO`, `SRAM_Buffer`)** — moves bytes using queue read/write pointers and status signals.
3. **Encryptor (`Encryptor`)** — XORs the incoming byte with `8'h35`; accepts a forward-ROM lookup result, rotates it right by three bits, then XORs with `8'h6F`.
4. **Decryptor (`Decryptor`)** — XORs encrypted data with `8'h6F`, rotates it right by five bits, then combines reverse-ROM output with `8'h35`.
5. **ROMs (`LookupTableROM`, `ReverseLookupROM`)** — use `$readmemh` and are clocked on the rising edge.
6. **Top-level (`Top`)** — instantiates the memory, FIFO, ROMs and encryption/decryption modules and exposes result/status buses.

The `system_fsm` and `clock_driver` files are also provided. They are independent utility/control modules, **not connected as instances in the supplied `Top.v`**. The six-state FSM capture is included as separate design evidence.

## Keys and transforms

The demonstration uses 8-bit fixed keys `35` and `6F` (hexadecimal), with right rotations of three and five bits on the forward and return paths respectively. In an 8-bit word, rotating right by five reverses a rotation right by three.

This is not an industry-standard cipher, nor evidence of cryptographic security. Its aim is demonstrating hardware modules, reversible byte manipulation, state/control diagrams and FPGA-oriented workflows.

## Hardware and implementation scope

The captures show a modular RTL architecture in an EDA/simulation environment. Complete FPGA board project settings, device pin assignments, full synthesis reports and a physical-hardware execution record were not among the supplied files, so no hardware deployment claim is made here.
