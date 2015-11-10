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

    git push -u origin master

## Using

Remove `readme.md` and do whatever you want, e.g. for generating documentation
use:

    make       # to build *.html files
    make clean # to remove *.html files

## Updating

In case some day you want to update templates and styles refer to git features.
And of course you'd like to keep your `readme.md` unchanged, don't you?
Do all the local commits then:

    # Working with separate branch
    git checkout -b documentary documentary/master # do it once
    git checkout documentary # later

    git pull
    git checkout master
    git merge --squash --no-commit documentary
    git checkout origin/master -- readme.md

    # Working with remote master
    git fetch documentary
    git merge --squash --no-commit documentary/master
    git checkout origin/master -- readme.md

To keep you `readme.md` do:

    git stash # if you have local changes
    git merge --squash --no-commit documentary/master
    git checkout origin master -- readme.md origin/master
    git pop # if you had local changes

## Pretty viewing

You may wish to use `nginx` to view the html document files in browser.

Create `nginx.conf`:

    cd /path/to/project
    cp nginx.conf.example nginx.conf

Uncomment `root` directive in `nginx.conf` and set path:

    #root /path/to/project;

Start `nginx` like so:

    sudo nginx -c /path/to/project/nginx.conf
