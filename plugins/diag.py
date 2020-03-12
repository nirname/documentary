#!/usr/bin/env python

"""
Pandoc filter to process code blocks with class "*diag" into
inline SVG.

Based on graphviz.py from pandocfilters 1.2.1 at
https://pypi.python.org/pypi/pandocfilters/ (MIT licensed).
"""

SUPPORTED_COMMAMDS = ['seqdiag']

from pandocfilters import RawBlock, toJSONFilter
from subprocess import Popen, PIPE

def diag(key, value, format, meta):
  if key == 'CodeBlock':
    [[ident,classes,keyvals], code] = value
    # raise Exception(str(value))
    commands = list(set(classes) & set(SUPPORTED_COMMAMDS))
    if commands:
      if format not in ['html', 'html5', 'revealjs']:
        raise Exception('output format must be HTML')

      proc = Popen(
        "seqdiag -T svg  -o /dev/stdout -",
        shell=True,
        stdin=PIPE,
        stdout=PIPE,
        stderr=PIPE,
        universal_newlines=True
      )
      (output, errors) = proc.communicate(code)
      return RawBlock("html", output)

if __name__ == "__main__":
    toJSONFilter(diag)


# seqdiag source/diag.seq -Tsvg --nodoctype -o /dev/stdout
