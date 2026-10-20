# Project Evidence and Verification Scope

## Evidence included

- Eleven original Verilog files (10 design RTL modules and one testbench).
- Author-provided simulation captures of the top-level data path and FIFO activity.
- Author-provided state diagram, top-level editor view and system block diagram.
- ASCII test-data HEX file and 256-record reverse mapping HEX file.

The supplied simulation images are consistent with the author's described workflow in which the message `Cryptosystem` is processed byte-by-byte and displayed in decrypted form. They are retained as historical engineering evidence.

## Checks performed when preparing this archive

- All 11 original HDL sources are present, with **no changes to the original HDL body** (only author/SPDX comments added).
- Uploaded HEX files are unchanged; a correctly labeled copy of the ASCII sample provides `main_message.hex`.
- All five original screenshots are included and properly decoded into actual PNGs for the README.
- Copyright, MIT license and citation metadata are included.
- Relative README links, archive integrity and basic ASCII data checks are verified by the package build.

## Boundaries of these checks

No **new** HDL compile, simulation, hardware synthesis, or FPGA board test is claimed. `Top_tb.v` is observation-based and is not a self-terminating, self-checking pass/fail test. The reverse table contains 256 source records, including repeated address tags, as noted in [ASCII and data](ASCII_AND_DATA.md). Neither a limited-length message file nor the existence of address-tag repetitions alone establishes a failed original simulation.

This repository preserves the design **as demonstrated and supplied**, while clearly separating the author's recorded waveforms from fresh reproducibility or security claims.
