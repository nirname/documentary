# Documentary

Static website compiler with markdown, charts and graphs support.

Converts simple text notation into pretty looking pages.

It doesn't pretend to be a new tool, it is just convenient union of other great tools.

## Getting started

Install Docker. Then:

```bash
docker pull nirname/documentary
```

Create a new folder for your website:

```bash
mkdir website && cd website
```

Create `sample.md` file under `source` subfolder:

```bash
mkdir source && touch source/sample.md
```

Copy and paste this to `source/sample.md`:

    # Hello

    ```dot
    digraph {
      A -> B
    }
    ```

Prepare build script:

```bash
touch build.sh
chmod +x build.sh
```

Copy and paste the following code inside build.sh

```bash
#!/usr/bin/env bash
docker run --rm -v $(pwd):/project nirname/documentary documentary
```

```bash
docker run -v "`pwd`:/project" -it --rm nirname/documentary documentary
```

Your will find compiled output under `docs` subfolder. Check the result:

```bash
open docs/sample.html
```

As simple as that.

Have a look at [documentary gh-pages](https://nirname.github.io/documentary-docs/)
to find out what is capable of.

You may try other [examples](https://nirname.github.io/documentary-docs/#examples) or
[build reveal.js presentation](https://nirname.github.io/documentary-docs/#reveal.js) as well.

## Features

* Markdown extended from *Pandoc*

* All the types of graphs that *Graphviz* supports

* Flowchart diagramms via *Seqdiag*

* Embedded and standalone images

## Join the development

I would really appreciate any assistance so as to increase amount of diagrams and simplify usage.

[Skim through the plan](https://nirname.github.io/documentary-docs/todo.html).

## Acknowledgements

The very idea of implementation is borrowed from [here](https://tylercipriani.com/blog/2014/05/13/replace-jekyll-with-pandoc-makefile/)

The idea of using inline `dot` graphs shamelessly taken from [here](https://gitlab.com/meonkeys/pandoc-dot-svg-hack/tree/master)