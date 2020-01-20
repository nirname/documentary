# Documentary

Static website compiler with markdown, charts and graphs support.

Converts simple text notation into pretty looking pages.

It doesn't pretend to be a new tool, it is just convenient union of other great tools.

## Getting started

Create a project, say `my-docs`, containing 2 folders `source` and `docs`.
Put some `*.md` and `*.dot` files under `source` folder and then run:

```
cd my-docs
```

To build simple html project use:

```
docker run --rm -v $(pwd):/project nirname/documentary documentary
```

To build reveal.js project use:

```
docker run --rm -v $(pwd):/project nirname/documentary documentary TO=revealjs
```

And then download and copy reveal.js to your project/docs/ folder.

Have a look at [documentary gh-pages](https://nirname.github.io/documentary-docs/)
to find out what is capable of.

## Features

* Markdown extended from *Pandoc*

* All the types of graphs that *Graphviz* builds

* Flowchart diagramms via *Seqdiag*

## Join the development

I would really appreciate any assistance so as to increase amount of diagrams and simplify usage.

To create new image locally use

```
make -f docker build
```

[Read through the plan](source/todo.md).

## Acknowledgements

The very idea of implementation is borrowed from [here](https://tylercipriani.com/blog/2014/05/13/replace-jekyll-with-pandoc-makefile/)

The idea of using inline `dot` graphs shamelessly taken from [here](https://gitlab.com/meonkeys/pandoc-dot-svg-hack/tree/master)