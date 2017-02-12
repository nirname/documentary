# Documentary

This is a static website compilator for `markdown` pages.

## Installation

Install the requirements:

    sudo apt-get install build-essential pandoc

Clone this project from here and remove `.git` folder:

    git clone git@github.com:/nirname/documentary.git
    cd documentary && rm -rf .git

... or [download it](https://github.com/nirname/documentary/archive/master.zip), or
fork it.

## Usage

Put some `.md` files inside and compile them

    make        # to build site
    make serve  # to start serving files at localhost:8000
    make watch  # to watch and recompile changes automatically
