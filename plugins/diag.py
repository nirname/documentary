#!/usr/bin/env python

"""
Pandoc filter to process code blocks with class "*diag" into
inline SVG.

Based on graphviz.py from pandocfilters 1.2.1 at
https://pypi.python.org/pypi/pandocfilters/ (MIT licensed).
"""

SUPPORTED_COMMAMDS = ['seq-diag']

from pandocfilters import RawBlock, toJSONFilter
from subprocess import Popen, PIPE

def diag(key, value, format, meta):
  if key == 'CodeBlock':
    [[ident,classes,keyvals], code] = value
    # raise Exception(str(value))
    commands = list(set(classes) & set(SUPPORTED_COMMAMDS))
    if commands:
      if format not in ['html', 'html5']:
        raise Exception('output format must be HTML')
      p = Popen([commands[0].replace('-', ''), '-T', 'svg'], stdin=PIPE, stdout=PIPE)
      (output, errors) = p.communicate(code)
      return RawBlock("html", output)

if __name__ == "__main__":
    toJSONFilter(diag)
