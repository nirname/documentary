# 'Makefile'
MD = pandoc --data-dir=$(CURDIR) --from markdown --css styles/github-markdown.css --template github-markdown.html --standalone
# use --toc option generate links to anchors

MD_SOURCES = $(shell ls *.md)
HTML = $(MD_SOURCES:%.md=%.html)

all: md

md: $(HTML)

%.html: %.md makefile
	$(MD) --to html $< --output $@

PHONY: clean

clean: clean_html

clean_html:
	rm *.html
