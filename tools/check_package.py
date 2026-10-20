#!/usr/bin/env python3
"""Check archived file completeness and the ASCII example; not an HDL functional test."""
from pathlib import Path
import re

repo=Path(__file__).resolve().parent.parent
expected_modules=['clock_driver.v','DataStorageRAM.v','Decryptor.v','Encryptor.v','FIFO.v','LookupTableROM.v','ReverseLookupROM.v','SRAM_Buffer.v','system_fsm.v','Top.v']
expected_imgs=['fifo-waveforms.png','controller-fsm.png','top-module-code.png','system-simulation.png','system-rtl-block-diagram.png']
required=['README.md','LICENSE','AUTHORS.md','CITATION.cff','THIRD_PARTY_NOTICES.md','sim/Top_tb.v']
required+=['rtl/'+x for x in expected_modules]
required+=['mem/main_message.hex','mem/lookup_data.hex','mem/reverse_lookup_data.hex']
required+=['assets/screenshots/'+x for x in expected_imgs]
required+=['assets/original-captures/'+x.replace('.png','.webp') for x in expected_imgs]
missing=[p for p in required if not (repo/p).is_file()]
assert not missing, 'Required assets missing: '+', '.join(missing)

text=(repo/'mem/lookup_data.hex').read_text(encoding='utf-8')
records={int(a,16):int(v,16) for a,v in re.findall(r'@([0-9A-Fa-f]{2})\s+([0-9A-Fa-f]{2})',text)}
assert records.get(0)==0
assert bytes(records[i] for i in range(1,13)).decode('ascii') == 'Cryptosystem'
assert (repo/'mem/lookup_data.hex').read_bytes()==(repo/'mem/main_message.hex').read_bytes()
readme=(repo/'README.md').read_text(encoding='utf-8')
for target in re.findall(r'!?\[[^\]]*\]\(([^)]+)\)',readme):
    if not target.startswith(('http:','https:','#','mailto:')):
        assert (repo/target.split('#',1)[0]).exists(), f'Broken README link: {target}'
for name in expected_imgs:
    assert (repo/'assets/screenshots'/name).read_bytes().startswith(b'\x89PNG\r\n\x1a\n')
print('PASS: repository inventory, ASCII message, memory filename copy, PNG signatures and README links')
print('NOTE: this is not a Verilog compile, encryption round-trip test, or hardware verification.')
