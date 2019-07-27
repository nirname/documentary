---
title: Documentary
header-includes:
    <meta name="keywords" content="pandoc static website compiler graph graphviz seqdiag sequence diagrams" />
    <meta name="description" content="static website generator on top of pandoc and make with built-in markdown, gravhiz and sequence diagrams support" />
---

This is a static website generator on top of Pandoc and Make
with built-in Markdown, Gravhiz and Sequence diagrams support.

## Content

* [Installation](#installation)
* [Structure](#structure)
* [Usage](#usage)
* [Examples](#examples)

Read through [future development plans](todo.md).

## Installation and Usage

### Docker

Install Docker. Then

```bash
docker pull nirname/documentary
```

Create new folder for you website, put something under `source` subfolder and compile:

```
mkdir website && cd website
touch "# Hello" > source/index.md
docker run -v "`pwd`:/project" -it --rm nirname/documentary documentary
```

Your will found compiled output under `docs` subfolder.

As simple as that.

### Local

Clone this project and remove `.git` folder:

```bash
git clone git@github.com:/nirname/documentary.git && cd documentary && rm -rf .git
```

... or [download it](https://github.com/nirname/documentary/archive/master.zip).

Install the requirements as follows.

Pip:

```shell
https://pip.readthedocs.io/en/stable/installing/
```

Ubuntu:


```shell
apt-get install build-essential pandoc graphviz
pip install pandocfilters seqdiag
```

MacOS:

```shell
brew install build-essential pandoc graphviz
pip install pandocfilters seqdiag
```

Use `sudo` if needed.


Put some `*.md`, `*.css` and `*.dot` files under `source/` folder, run:

```shell
make
```

Everything compiled will be found under `docs/` folder.

To skip trhough website run

```shell
make serve
```

and open `localhost:8000` in your browser.

To watch changes automatically run:

```
make watch
```

in antoher terminal.

To remove `docs` folder completely, run:

```
make clean
```
This is equal to `rm -rf docs/*`

## Examples

### reveal.js

```bash
rm -rf reveal.js
wget https://github.com/hakimel/reveal.js/archive/master.tar.gz
tar -xzvf master.tar.gz
mv reveal.js-master reveal.js
rm master.tar.gz
```

Replace

```
--to html5
```
in `makefile` to

```
--to revealjs
```

### Inline images

To create embedded graph add specific class to a code block.

---

**Graphviz**

````
```dot
digraph workflow {
  node [shape="rect" width=1]
  { Markdown, Graphviz, Sequence } -> HTML
}
```
````

```dot
digraph workflow {
  node [shape="rect" width=1]
  { Markdown, Graphviz, Sequence } -> HTML
}
```

---

**Sequence diagrams**

````
```seqdiag
seqdiag {
  make; pandoc; tool;
  make -> pandoc         [label = "markdown"];
          pandoc -> tool [label = "graph"];
          pandoc <- tool [label = "svg"];
  make <- pandoc         [label = "html"];
  make ->           tool [label = "graph"];
  make <-           tool [label = "svg"];
}
```
````

```seqdiag
seqdiag {
  make; pandoc; tool;
  make -> pandoc         [label = "markdown"];
          pandoc -> tool [label = "graph"];
          pandoc <- tool [label = "svg"];
  make <- pandoc         [label = "html"];
  make ->           tool [label = "graph"];
  make <-           tool [label = "svg"];
}
```

---

### Standalone images

It might be convenient to keep your graph as a separate file in case it is too big for inline usage.

To add external graph, put in your project `layouts.neato` with some valid graph inside and write a link to it:

```markdown
![Supported Formats](formats.neato)

```

![Supported Formats](formats.neato)

Layout of the image will be derived automatically by source file extension.
`formats.neato` will be converted to `formats.svg` and links to it will be automatically changed as well.

So as to change layout of the graph change source file extension, e.g. `formats.circo`.
Don't forget to change link to the graph to `![Supported Formats](formats.circo)`.
