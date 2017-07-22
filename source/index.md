# Documentary

This is a static website generator with built-in Markdown and Gravhiz support.

```{#workflow .dot-graph}
digraph workflow {
  node [shape="circle" width=1 fixedsize=true]
  { Markdown, "Graph" } -> Site
}
```

Supported Graphivz layouts are:

![Layouts](layouts.neato)

## Installation

Install the requirements:

```bash
sudo apt-get install build-essential pandoc graphviz make pip
pip install pandocfilters
```

Clone this project from here and remove `.git` folder:

```bash
git clone git@github.com:/nirname/documentary.git && cd documentary && rm -rf .git
```

... or [download it](https://github.com/nirname/documentary/archive/master.zip).

## Running

Run inside this project folder:

```bash
make clean  # to remove all the compiled pages
make        # to build site
make serve  # to start serving files at localhost:8000
make watch  # to watch and recompile changes automatically
```

## Usage

Put some `*.md` files under `source/` folder and run `make`.

Everything compiled will be found under `docs/` folder.

Run webserver via `make serve` and open `localhost:8000` in your browser.

## Features

### Markdown

Markdown support comes from Pandoc.

### Styles

[Github Markdown styles](https://github.com/sindresorhus/github-markdown-css) are built in.

### Code highlighting

Common package of [highlightjs](https://highlightjs.org/download/) is being used.

### Graphviz

#### Stand-alone DOT

Put in your project `graph.dot` with some graph and write a link to it:

```markdown
[Graph](graph.dot)

```

`graph.dot` will be converted to `graph.svg` and link will be automatically changed as well.

#### Embedded DOT

It is also possible to write embedded DOT graph like this:

    ```dot
    digraph workflow {

      node [shape="circle" width=1 fixedsize=true]

      { MD, DOT } -> HTML

    }
    ```

This is the very code that produces graph at the top of the page.

## Acknowledgements

The very idea of implementation is borrowed from [here](https://tylercipriani.com/blog/2014/05/13/replace-jekyll-with-pandoc-makefile/)

The idea of using inline `dot` graphs shamelessly taken from [here](https://gitlab.com/meonkeys/pandoc-dot-svg-hack/tree/master)
