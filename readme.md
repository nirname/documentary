# Template for documentation

This is just template that assumes you are using `pandoc`, `markdown` and `make`
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
    git remote add origin your-new-repository

Remove `readme.md` and do whatever you want, e.g. for generating documentation
use:

    make       # to build *.html files
    make clean # to remove *.html files

## Updating

In case some day you want to update templates and styles refer to git features:

    git merge --squash -s subtree --no-commit documentary/master
