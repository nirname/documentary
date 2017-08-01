#!/usr/bin/env python

import subprocess
from subprocess import Popen, PIPE, check_output, call

# Command

# seqdiag source/diag.seq -Tsvg --nodoctype -o /dev/stdout

# Working code

# print call("seqdiag -T svg --nodoctype -o /dev/stdout source/diag.seq", shell=True)

qqq = """
  diagram {
    browser  -> webserver [label = "GET /index.html"];
    browser <-- webserver;
    browser  -> webserver [label = "POST /blog/comment"];
                webserver  -> database [label = "INSERT comment"];
                webserver <-- database;
    browser <-- webserver;
}
"""

proc = Popen(
    "seqdiag -T svg --nodoctype -o /dev/stdout /dev/stdin",
    shell=True,
    stdin=PIPE, stdout=PIPE, stderr=PIPE
)

# proc.stdin.write(qqq)
# proc.wait()
res = proc.communicate(qqq)
if proc.returncode:
    print res[1]
print 'result:', res[0]