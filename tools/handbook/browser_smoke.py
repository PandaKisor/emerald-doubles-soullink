#!/usr/bin/env python3
"""Exercise the delivered local HTML in Firefox; screenshots stay in generated/."""
import http.server
import json
import os
from pathlib import Path
import subprocess
import threading
import time

HERE=Path(__file__).resolve().parent
NATIVE=HERE.parents[1]
GEN3=NATIVE.parents[1]
OUT=NATIVE/'generated/handbook/browser'
OUT.mkdir(parents=True,exist_ok=True)
meta=json.loads((NATIVE/'generated/handbook/data.json').read_text())['meta']
import sys
source=Path(sys.argv[1]) if len(sys.argv)>1 else GEN3/f'emerald-field-guide-{meta["campaignVersion"]}.html'
report=[]
ready=threading.Event()
class Report(http.server.BaseHTTPRequestHandler):
    def do_POST(self):
        report.append(json.loads(self.rfile.read(int(self.headers['Content-Length']))))
        self.send_response(200);self.send_header('Access-Control-Allow-Origin','*');self.end_headers();self.wfile.write(b'ok');ready.set()
    def log_message(self,*args):pass
server=http.server.HTTPServer(('127.0.0.1',0),Report)
threading.Thread(target=server.serve_forever,daemon=True).start()
url=f'http://127.0.0.1:{server.server_port}/report'
harness=(HERE/'browser_smoke.js').read_text().replace('__REPORT_URL__',url)
sample=(NATIVE/'generated/handbook/guide-sync-sample.json').read_text()  # written by verify_campaign_qol.lua
html=source.read_text().replace('<body>','<body><script>window.smokeErrors=[];window.onerror=(...a)=>smokeErrors.push(String(a[0]));window.syncSample='+json.dumps(sample).replace('<','\\u003c')+';</script>')
page=OUT/'smoke.html'
page.write_text(html.replace('</body>',f'<script>{harness}</script></body>'))
profile=OUT/f'profile-{time.time_ns()}'
profile.mkdir()
command=['firefox','--headless','--no-remote','--profile',str(profile)]
env={**os.environ,'MOZ_CRASHREPORTER_DISABLE':'1'}
with (OUT/'firefox.log').open('w') as log:
    proc=subprocess.Popen(command+[page.as_uri()],stdout=log,stderr=log,env=env)
    passed=ready.wait(45)
    proc.terminate()
    try:proc.wait(timeout=5)
    except subprocess.TimeoutExpired:proc.kill();proc.wait()
    if not passed:raise RuntimeError('Browser report timed out; inspect '+str(OUT/'firefox.log'))
    (OUT/'report.json').write_text(json.dumps(report[-1],indent=2))
    print(json.dumps(report[-1],indent=2),flush=True)
    if not report[-1].get('ok'):raise SystemExit(1)
    for view,size,extra in [('guide','1440,1400','&chapter=0&open=1,3'),('guide','1440,1400','&chapter=0&open=1,3&sync=1'),('guide','1720,1300','&chapter=0&open=10&team=1&battle=hits'),('guide','1720,1100','&chapter=0&team=1&battle=taken'),('guide','1440,1000','&chapter=0&team=1&battle=speed'),('guide','1440,900','&chapter=4&sync=1'),('results','1440,1200','&q=Zigzagoon'),('calculator','1440,1200','&team=1'),('guide','390,1400','&chapter=0&open=1&sync=1'),('guide','390,1200','&chapter=0&team=1&battle=hits'),('pokedex','1440,1100',''),('pokedex','1440,1300','&dex=392'),('pokedex','390,1300','&dex=392'),('calculator','1440,1300','&team=1&moves=1')]:
        dest=OUT/f'{view}{extra.replace("&","-").replace("=","")}-{size.split(",")[0]}.png'
        subprocess.run(command+['--screenshot',str(dest),'--window-size',size,page.as_uri()+'?preview='+view+extra],stdout=log,stderr=log,env=env,check=True,timeout=40)
        print(dest,flush=True)
server.shutdown()
