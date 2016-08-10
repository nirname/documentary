# Static site template

This is static site template that assumes you are using `markdown`,
`pandoc` and `make` as tools for creating documentation.

## Installation

Install the requirements:

    sudo apt-get install build-essential pandoc nginx

Clone this project

    git clone git@github.com:/nirname/documentary.git

Then do:

    git remote rename origin documentary
    git remote add origin git@your-new-repository.git

    git push -u origin master

## Running

>  TODO:
>  add conf to sites enables in nginx,
>  add script pushing this config

## Usage

    make       # to build *.html files
    make clean # to remove *.html files