# Simulation and Setup

## Source files

The original `Top_tb.v` testbench and all 10 RTL modules are included. A Verilog simulator and compatible toolchain are required to run them. No specific tool version has been independently confirmed from the provided archive.

## Memory initialization

Three file references need special attention:

- `DataStorageRAM.v` opens `main_message.hex`.
- `LookupTableROM.v` opens `lookup_data.hex`.
- `ReverseLookupROM.v` opens `reverse_lookup_data.hex`.

All filenames are included under `mem/`. Because `$readmemh` resolves relative paths from the **simulator's run directory**, run the simulator from `mem/` (or copy the HEX files into the simulation working directory) instead of relying on paths relative to each `.v` source file.

## Example compile command (Icarus Verilog, if installed)

From the repository root on a shell with Icarus Verilog installed:

```bash
mkdir -p build
cd mem
iverilog -g2012 -s Top_tb -o ../build/top_tb.vvp ../rtl/*.v ../sim/Top_tb.v
vvp ../build/top_tb.vvp
```

**Important:** The original testbench has a continuously running clock and does not call `$finish`. Stop an interactive simulation manually if required. These are reproduction *instructions*, **not** evidence that this package was freshly simulated or passed functional checks.

The testbench observes and records signals without assertions that automatically compare the plaintext and decrypted data. For automated testing, a separate self-checking regression bench would be required. Avoid treating a documentation/package check as proof of encryption correctness.

## Optional static package checks

```bash
python tools/check_package.py
```

Python 3 is sufficient for this data/asset check. It validates ASCII sample content and file inclusion, but deliberately does not grade the Verilog functional behavior.
