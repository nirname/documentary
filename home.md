# Template for documentation

This is just template that assumes you are using `markdown`, `pandoc` and `make`
as tools for creating documentation.

Being required quite often `makefile` and pandoc templates (`github-styles.css`
and `github-template.html`) prepared in advance.


**Warning**

Current template is simplified and contains only `$body`, `$css`, `$dir` and
`lang` variables.

## How to start

Clone this project.

Then do:

    git remote rename origin documentary
    git remote add origin git@your-new-repository.git

Remove `readme.md` and do whatever you want, e.g. for generating documentation
use:

    make       # to build *.html files
    make clean # to remove *.html files

## Updating

In case some day you want to update templates and styles refer to git features.
And of course you'd like to keep your `readme.md` unchanged, don't you?
Do all the local commits then do:

    git fetch documentary
    git merge --no-ff --squash -s subtree --no-commit documentary/master
    git checkout origin/master -- readme.md

Then do commits normally

## Pretty viewing

You may wish to use `nginx` to view the html document files in browser.

Uncomment `root` directive in `nginx.conf` and set path:

    #root /path/to/project;

Start `nginx` like so:

    sudo nginx -c /path/to/project/nginx.conf
