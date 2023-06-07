# Documentary

Static website compiler with markdown, charts and graphs support.

Converts simple text notation into pretty looking pages.

It doesn't pretend to be a new tool, it is just convenient union of other great tools.

## Getting Started

**Install Docker.**

Create new project within new folder:

```bash
docker run --rm -v $(pwd):/app nirname/documentary documentary init website
cd website
```

To add existing one, put your markdown under `source/` folder first:

```bash
cd website
docker run --rm -v $(pwd):/app nirname/documentary documentary init .
```

Then:

```bash
./documentary build
```

Open `docs/sample.html`

As simple as that.

# Further Reading

Have a look at [documentary gh-pages](https://nirname.github.io/documentary-docs/)
to find out what is capable of.

You may try other [examples](https://nirname.github.io/documentary-docs/#examples) or
[build reveal.js presentation](https://nirname.github.io/documentary-docs/#reveal.js) as well.

## Features

* Markdown extended from *[Pandoc](https://pandoc.org/)*
* All the types of graphs that *[Graphviz](https://graphviz.org/)* supports
* Flowchart diagramms via *[Seqdiag](http://blockdiag.com/en/seqdiag/index.html)*
* Embedded and standalone images

## Structure of the project

* bin - executables
* plugins - things that enhance and extend markdown
* resources - built-in styles and other 
* templates - self-descripting, this will be used as scaffold and put within project
* docs - 

## Join the Development

I would really appreciate any assistance so as to increase amount of diagrams and simplify usage.

* [Skim through the plan](docs/todo.md).
* [Have a look at what has been done so far in changelog](docs/changelog.md).
* [Grap sample markdown](docs/sample.md) to test if it works.

## Acknowledgements

The very idea of implementation is borrowed from [here](https://tylercipriani.com/blog/2014/05/13/replace-jekyll-with-pandoc-makefile/)

The idea of using inline `dot` graphs shamelessly taken from [here](https://gitlab.com/meonkeys/pandoc-dot-svg-hack/tree/master)
