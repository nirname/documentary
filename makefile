# 'Makefile'
# use --toc option generate links to anchors
MD = pandoc --data-dir=$(CURDIR) --from markdown \
	--css ../styles/github-markdown.css --css ../styles/documentary.css \
	--template github-markdown.html --standalone

SOURCES_DIR = .
OBJECTS_DIR = doc

#MD_SOURCES = $(shell find . -name '*.md')
MD_SOURCES = $(shell find . -name '*.md' | cut -sd / -f 2-)
HTML_OBJECTS = $(MD_SOURCES:%.md=$(OBJECTS_DIR)/%.html)

#all:
#	@echo $(MD_SOURCES)
#	@echo $(HTML_OBJECTS)

all: md

md: $(HTML_OBJECTS)

$(OBJECTS_DIR)/%.html: $(SOURCES_DIR)/%.md makefile
	@mkdir -p $(@D)
	$(MD) --to html $< --output $@

PHONY: clean

clean: clean_html clean_dir

clean_html:
	rm $(HTML_OBJECTS)

clean_dir:
	find $(OBJECTS_DIR) -type d -empty -delete
