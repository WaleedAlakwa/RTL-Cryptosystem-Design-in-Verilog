# ASCII Test Message and Memory Files

## Encoding of the demonstration text

`Cryptosystem` consists of **12 ASCII characters**, stored as 12 hex byte values:

| Character | C | r | y | p | t | o | s | y | s | t | e | m |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Hex ASCII | 43 | 72 | 79 | 70 | 74 | 6F | 73 | 79 | 73 | 74 | 65 | 6D |

The supplied `lookup_data.hex` is a *message-sized memory image*, beginning with `@00 00`, and then the characters at addresses `@01` through `@0C`. It is appropriate for this sample data to contain only the required message, rather than all 256 possible byte values. This does **not** mean every one of its entries defines a global substitution map.

The design separately includes a 256-record `reverse_lookup_data.hex` file, indexed with hexadecimal 8-bit addresses. Values outside standard 7-bit ASCII may appear because lookup data can operate on the full eight-bit space, not only printable English text.

## Filename compatibility / provenance

The user's upload contained `lookup_data.hex` and `reverse_lookup_data.hex`. The supplied `DataStorageRAM.v` reads a third filename, `main_message.hex`. To make all source-referenced filenames present, the packaging step adds `mem/main_message.hex` as a **byte-identical copy** of the supplied message-bearing `lookup_data.hex`. This copy is a packaging convenience, not a newly discovered original file or a change to the author's HDL.

`LookupTableROM.v` separately reads `lookup_data.hex`; both source references are maintained exactly as written. The project is preserved in its supplied form rather than guessing table values or silently modifying the datapath.

## Reproducibility note

The reverse HEX file contains 256 address/value records; in the exact uploaded data, `@20` and `@A0` each occur twice, while `@1A` and `@9A` do not occur as address tags. This observation is about literal records, **not** a conclusion that the author's original demonstrated simulation failed. If building a general-purpose all-256-byte test, review which lookup image and address mapping were used in the original tool project; do not silently replace supplied values.
