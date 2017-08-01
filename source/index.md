# Documentary

This is a static website generator with built-in Markdown and Gravhiz support.

```{#workflow .dot-graph}
digraph workflow {
  node [shape="circle" width=1 fixedsize=true]
  { Markdown, "Graph" } -> Site
}
```

asdf

```seq-diag
  seqdiag {
    seqdiag -> "sequence-diagrams" [label = "generates"];
    seqdiag --> "is very easy!";
  }
```

Supported Graphivz layouts are:

![Layouts](layouts.neato)

## Installation

Install the requirements

```shell
sudo apt-get install build-essential pandoc graphviz pip
pip install pandocfilters seqdiag
```

Clone this project and remove `.git` folder:

```bash
git clone git@github.com:/nirname/documentary.git && cd documentary && rm -rf .git
```

... or [download it](https://github.com/nirname/documentary/archive/master.zip).

## Usage

### Starting

Put some `*.md` files under `source/` folder and run `make` from this project's folder.

Everything compiled will be found under `docs/` folder.

Run webserver via `make serve` and open `localhost:8000` in your browser.

Available commands are:

```bash
make clean  # to remove all the compiled pages, equal to rm -rf docs/*
make        # to build site
make serve  # to start serving files at localhost:8000
make watch  # to watch and recompile changes automatically
```

### Inline graphs

To create embedded graph add specific class to a code block:

````dot
```dot-graph
digraph workflow {
  node [shape="circle" width=1 fixedsize=true]
  { Markdown, "Graph" } -> Site
}
```
````

This is the very code that produces graph at the top of the page.

Class name must consist of an available Graphviz layout name plus `-graph` suffix.

### External graphs

To add external graph, put in your project `graph.dot` with some valid graph inside and write a link to it:

```markdown
![Graph](graph.dot)

```

`graph.dot` will be converted to `graph.svg` and links to it will be automatically changed as well.

So as to change layout of the graph change source file extension, e.g. `graph.neato`.

Don't forget to change link to the graph to `![Graph](graph.neato)`.

This might be convenient if the graph is too big for inline usage.

### Styles

[Github Markdown styles](https://github.com/sindresorhus/github-markdown-css) are built in.

## Acknowledgements

The very idea of implementation is borrowed from [here](https://tylercipriani.com/blog/2014/05/13/replace-jekyll-with-pandoc-makefile/)

The idea of using inline `dot` graphs shamelessly taken from [here](https://gitlab.com/meonkeys/pandoc-dot-svg-hack/tree/master)
