#!/usr/bin/env python

"""
Pandoc filter to process code blocks with class "graphviz" into
inline SVG.

Based on graphviz.py from pandocfilters 1.2.1 at
https://pypi.python.org/pypi/pandocfilters/ (MIT licensed).
"""

SUPPORTED_COMMAMDS = ['dot', 'neato', 'fdp', 'sfdp', 'twopi', 'circo']

from pandocfilters import RawBlock, toJSONFilter
from subprocess import Popen, PIPE

def graphviz(key, value, format, meta):
  if key == 'CodeBlock':
    [[ident,classes,keyvals], code] = value
    # raise Exception(str(value))
    commands = list(set(classes) & set(SUPPORTED_COMMAMDS))
    if commands:
      if format not in ['html', 'html5', 'revealjs']:
        raise Exception('output format must be HTML')
      proc = Popen(
      	[commands[0], '-T', 'svg'],
      	stdin=PIPE,
      	stdout=PIPE,
      	encoding='utf8',
      	universal_newlines=True
      )
      (output, errors) = proc.communicate(code)
      return RawBlock("html", output)

if __name__ == "__main__":
    toJSONFilter(graphviz)
