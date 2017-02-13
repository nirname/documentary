# 'Makefile'

# Where sources are located
SOURCES_DIR = .
# Where all the compiled sources will be
OBJECTS_DIR = doc

# Where assets are located
ASSETS_DIR = styles
# Where all the compiled assets will be
BUILDS_DIR = $(OBJECTS_DIR)/styles

# use --toc option generate links to anchors
MD = pandoc --data-dir=$(CURDIR) --from markdown \
	--css $(ASSETS_DIR)/github-markdown.css --css $(ASSETS_DIR)/documentary.css \
	--template github-markdown.html --standalone

DOT = dot -Tsvg

CSS_ASSETS = $(shell find $(ASSETS_DIR) -name '*.css' | cut -sd / -f 2-)
CSS_BUILDS = $(CSS_ASSETS:%.css=$(BUILDS_DIR)/%.css)

MD_SOURCES = $(shell find $(SOURCES_DIR) -name '*.md' | cut -sd / -f 2-)
HTML_OBJECTS = $(MD_SOURCES:%.md=$(OBJECTS_DIR)/%.html)

DOT_SOURCES = $(shell find $(SOURCES_DIR) -name '*.dot' | cut -sd / -f 2-)
DOT_OBJECTS = $(DOT_SOURCES:%.dot=$(OBJECTS_DIR)/%.svg)

all: assets sources
# @echo "Done"

assets: $(CSS_BUILDS)

$(BUILDS_DIR)/%.css: $(ASSETS_DIR)/%.css
	@mkdir -p $(@D)
	@cp -f $< $@

sources: md_sources dot_sources

md_sources: $(HTML_OBJECTS)

$(OBJECTS_DIR)/%.html: $(SOURCES_DIR)/%.md makefile
	@mkdir -p $(@D)
	@$(MD) --to html $< --output $@
	@sed -i '' -e '/href="./s/\.md/\.html/g' $@
	@sed -i '' -e '/src="./s/\.dot/\.svg/g' $@

dot_sources: $(DOT_OBJECTS)

$(OBJECTS_DIR)/%.svg: $(SOURCES_DIR)/%.dot makefile
	@mkdir -p $(@D)
	@$(DOT) $< -o $@

PHONY: watch serve clean debug

watch:
	(while true; do make; sleep 1; done) | grep -v 'make\[1\]'

serve:
	cd $(OBJECTS_DIR) && python -m SimpleHTTPServer 8000

clean: clean_builds clean_objects clean_dir

clean_builds:
	- rm $(CSS_BUILDS)

clean_objects:
	- rm $(HTML_OBJECTS)

clean_dir:
	- find $(OBJECTS_DIR) -type d -empty -delete

debug:
	@echo $(CSS_ASSETS)
	@echo $(CSS_BUILDS)
	@echo $(MD_SOURCES)
	@echo $(HTML_OBJECTS)
