#!/usr/bin/env python3

import sys
import subprocess
import re

print("Fixing rpath for {}".format(sys.argv[1]))

args = []

with subprocess.Popen(['otool', '-L', sys.argv[1]], stdout=subprocess.PIPE) as p:
    for bline in p.stdout.readlines():
        line = bline.decode('utf-8')
        m = re.match(r'\s+(.*)\s+\(', line)
        if m:
            lib_line = m.group(1)
            if lib_line.startswith('@rpath'):
                name = lib_line.split('/')[-1]
                args = args + [ '-change', lib_line, '@loader_path/{}'.format(name) ]
                

if len(args) > 0:
    args = [ "install_name_tool" ] + args + [ sys.argv[1] ]
    print("Running: {}".format(' '.join(args)))
    subprocess.run(args, capture_output=True, check=True, text=True)