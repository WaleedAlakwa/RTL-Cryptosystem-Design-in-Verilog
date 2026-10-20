# Design and Simulation Screenshots

All five screenshots were provided by the author. The uploaded files were WebP images despite PNG-looking filenames. They are archived losslessly as original WebP files in `assets/original-captures/` and decoded into actual PNG images in `assets/screenshots/` for consistent GitHub rendering.

| Screenshot | What it depicts |
|---|---|
| [System block diagram](../assets/screenshots/system-rtl-block-diagram.png) | Forward/reverse ROM modules, RAM, FIFO and encipher/decipher architecture |
| [Controller FSM](../assets/screenshots/controller-fsm.png) | `INIT`, `LOAD`, `ENCRYPT`, `DECRYPT`, `OUTPUT`, `IDLE` state model |
| [System waveform](../assets/screenshots/system-simulation.png) | Message signals, encrypted/decrypted buses, clock and queue signals |
| [FIFO waveform](../assets/screenshots/fifo-waveforms.png) | Enqueue/dequeue activity, data bytes, pointers and status flags |
| [Source editor](../assets/screenshots/top-module-code.png) | Captured Verilog top-level interface in the original EDA editor |

These are captured results, not regenerated simulation reports. The screenshot of the source editor shows a top-level module name variant; the packaged source file is `Top.v`, supplied unchanged except for attribution header comments.
