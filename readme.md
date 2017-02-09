# Static site compilator

This is static site compilator based on `make` that assumes you are:

 * Formatting pages in `markdown`
 * Using `pandoc`, `graphviz` as tools
 * Using `nginx` as webserver

Of course, these are just options. You are free to change any of them.

## Installation

Install the requirements:

    sudo apt-get install build-essential pandoc graphviz nginx

Clone this project from here:

    git clone git@github.com:/nirname/documentary.git

Or (download it)[https://github.com/nirname/documentary/archive/master.zip], or
fork it.

Rename `documentary` folder as you wish (e.g. `my_web_site`).

Remove `.git` directory:

    cd documentary
    rm -rf .git

## Usage

Put some `.md` files inside and compile them

    make       # to build site
    make clean # to remove builded files

## Running

>  TODO:
>  add conf to sites enables in nginx,
>  add script pushing this config

