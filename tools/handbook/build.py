#!/usr/bin/env python3
"""Assemble the offline companion as one HTML file; no CDN or runtime fetches."""
import argparse
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NATIVE = HERE.parents[1]
GEN3 = NATIVE.parents[1]

def build(output=None):
    data_path = NATIVE / 'generated/handbook/data.json'
    data = json.loads(data_path.read_text())
    text = (HERE / 'index.html').read_text()
    for marker, filename in [('STYLES','styles.css'),('CALCULATOR','calculator.js'),('APP','app.js')]:
        body = (HERE / filename).read_text()
        if marker != 'STYLES':
            assert '</script' not in body.lower(), filename
        text = text.replace('/* ' + marker + ' */', body)
    embedded = json.dumps(data, ensure_ascii=False, separators=(',', ':')).replace('<','\\u003c').replace('\u2028','\\u2028').replace('\u2029','\\u2029')
    text = text.replace('/* DATA */', embedded)
    assert '/* DATA */' not in text
    out = Path(output) if output else GEN3 / f'emerald-field-guide-{data["meta"]["campaignVersion"]}.html'
    out.write_text(text)
    digest = hashlib.sha256(out.read_bytes()).hexdigest()
    out.with_name(out.name + '.sha256').write_text(f'{digest}  {out.name}\n')
    print(f'{out}\n{out.stat().st_size:,} bytes · SHA256 {digest}')
    return out

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output')
    build(parser.parse_args().output)
