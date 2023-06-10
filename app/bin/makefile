# 'Makefile'

PROJECT_PATH ?= /local
PROJECT_SOURCE_DIR ?= src
PROJECT_TARGET_DIR ?= docs

# Where sources are located
SOURCE_DIR = $(PROJECT_PATH)/$(PROJECT_SOURCE_DIR)

# Where all the compiled sources will be
TARGET_DIR = $(PROJECT_PATH)/$(PROJECT_TARGET_DIR)

# what to put inside cname
DOMAIN = $(PROJECT_DOMAIN)

# Output format
TO ?= html
# --to revealjs

WATCH_COMMAND ?= make all

# This is relative to makefile
DOCUMENTARY_PATH ?= ./..
$(info $(DOCUMENTARY_PATH))
MAKEFILE ?= $(DOCUMENTARY_PATH)/bin/makefile
PLUGINS ?= $(DOCUMENTARY_PATH)/plugins

MD = pandoc \
	--from markdown \
	--standalone \
	--highlight-style kate \
	--filter $(PLUGINS)/graphviz.py \
	--filter $(PLUGINS)/diag.py

DOT = dot -Tsvg
NEATO = neato -Tsvg
FDP = fdp -Tsvg
SFDT = sfdp -Tsvg
TWOPI = twopi -Tsvg
CIRCO = circo -Tsvg
SEQ = seqdiag3 -Tsvg

STATIC_SOURCES = $(shell find $(SOURCE_DIR) -iregex '.*\.(png|jpg|jpeg|svg|js)$$')
STATIC_TARGETS = $(STATIC_SOURCES:$(SOURCE_DIR)/%=$(TARGET_DIR)/%)

CSS_SOURCES = $(shell find $(SOURCE_DIR) -name '*.css')
CSS_TARGETS = $(CSS_SOURCES:$(SOURCE_DIR)/%.css=$(TARGET_DIR)/%.css)

# JS_SOURCES = $(shell find $(SOURCE_DIR) -name '*.js')
# JS_TARGETS = $(JS_SOURCES:$(SOURCE_DIR)/%.js=$(TARGET_DIR)/%.js)

MD_SOURCES = $(shell find $(SOURCE_DIR) -name '*.md')
MD_TARGETS = $(MD_SOURCES:$(SOURCE_DIR)/%.md=$(TARGET_DIR)/%.html)

DOT_SOURCES = $(shell find $(SOURCE_DIR) -name '*.dot')
DOT_TARGETS = $(DOT_SOURCES:$(SOURCE_DIR)/%.dot=$(TARGET_DIR)/%.dot.svg)

NEATO_SOURCES = $(shell find $(SOURCE_DIR) -name '*.neato')
NEATO_TARGETS = $(NEATO_SOURCES:$(SOURCE_DIR)/%.neato=$(TARGET_DIR)/%.neato.svg)

FDP_SOURCES = $(shell find $(SOURCE_DIR) -name '*.fdp')
FDP_TARGETS = $(FDP_SOURCES:$(SOURCE_DIR)/%.fdp=$(TARGET_DIR)/%.fdp.svg)

SFDP_SOURCES = $(shell find $(SOURCE_DIR) -name '*.sfdp')
SFDP_TARGETS = $(SFDP_SOURCES:$(SOURCE_DIR)/%.sfdp=$(TARGET_DIR)/%.sfpd.svg)

TWOPI_SOURCES = $(shell find $(SOURCE_DIR) -name '*.twopi')
TWOPI_TARGETS = $(TWOPI_SOURCES:$(SOURCE_DIR)/%.twopi=$(TARGET_DIR)/%.twopi.svg)

CIRCO_SOURCES = $(shell find $(SOURCE_DIR) -name '*.circo')
CIRCO_TARGETS = $(CIRCO_SOURCES:$(SOURCE_DIR)/%.circo=$(TARGET_DIR)/%.circo.svg)

SEQ_SOURCES = $(shell find $(SOURCE_DIR) -name '*.seq')
SEQ_TARGETS = $(SEQ_SOURCES:$(SOURCE_DIR)/%.seqdiag=$(TARGET_DIR)/%.seqdiag.svg)

all: sources no_jekyll cname permissions
#reveal.js

.IGNORE: $(TARGET_DIR)/reveal.js

# reveal.js: $(TARGET_DIR)/reveal.js

# $(TARGET_DIR)/reveal.js:
# 	@cp -r $(RESOURCES_DIR)/reveal.js $(TARGET_DIR)
# ifeq ($(TO),revealjs)
# else
# 	@echo "no reveal.js"
# endif

sources: \
	$(STATIC_TARGETS)\
	$(CSS_TARGETS) \
	$(MD_TARGETS) \
	$(DOT_TARGETS) \
	$(NEATO_TARGETS) \
	$(FDP_TARGETS) \
	$(SFDP_TARGETS) \
	$(TWOPI_TARGETS) \
	$(CIRCO_TARGETS) \
	$(SEQ_TARGETS)
# 	$(JS_TARGETS) \

$(STATIC_TARGETS):$(TARGET_DIR)/%: $(SOURCE_DIR)/% $(MAKEFILE)
	mkdir -p $(@D); \
	cp -f $< $@

$(CSS_TARGETS):$(TARGET_DIR)/%.css: $(SOURCE_DIR)/%.css $(MAKEFILE)
	mkdir -p $(@D); \
	cp -f $< $@

# $(JS_TARGETS):$(TARGET_DIR)/%.js: $(SOURCE_DIR)/%.js $(MAKEFILE)
# 	@mkdir -p $(@D); \
# 	cp -f $< $@

$(MD_TARGETS):$(TARGET_DIR)/%.html: $(SOURCE_DIR)/%.md $(CSS_TARGETS) $(JS_TARGETS) $(MAKEFILE) $(PLUGINS)/*.*
	mkdir -p $(@D); \
	$(MD) \
	$(foreach var,$(CSS_TARGETS), --css `python3 $(PLUGINS)/relpath.py $(var) $(@D)`) \
	--to $(TO) $< | sed -f $(PLUGINS)/relext.sed > $@;
# 	$(foreach var,$(JS_TARGETS), --js `python3 $(PLUGINS)/relpath.py $(var) $(@D)`) \

$(DOT_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/% $(MAKEFILE)
	mkdir -p $(@D); \
	$(DOT) $< -o $@

$(NEATO_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/% $(MAKEFILE)
	mkdir -p $(@D); \
	$(NEATO) $< -o $@

$(FDP_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/% $(MAKEFILE)
	mkdir -p $(@D); \
	$(FDP) $< -o $@

$(SFDP_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/% $(MAKEFILE)
	mkdir -p $(@D); \
	$(SFDP) $< -o $@

$(TWOPI_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/% $(MAKEFILE)
	mkdir -p $(@D); \
	$(TWOPI) $< -o $@

$(CIRCO_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/% $(MAKEFILE)
	mkdir -p $(@D); \
	$(CIRCO) $< -o $@

$(SEQ_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/% $(MAKEFILE)
	mkdir -p $(@D); \
	$(SEQ) $< -o $@

no_jekyll: $(TARGET_DIR)/.no_jekyll
$(TARGET_DIR)/.no_jekyll:
	touch $@

cname:
	echo $(DOMAIN) > $(TARGET_DIR)/CNAME

permissions:
	chown -R 1000:1000 $(TARGET_DIR)

PHONY: watch serve clean debug cname permissions

watch:
	(while true; do $(WATCH_COMMAND); sleep 1; done) | grep -v 'make\[1\]'

serve:
	cd $(TARGET_DIR) && python3 -m SimpleHTTPServer 8000

clean:
	rm -rf $(TARGET_DIR)/*

debug:
	@echo "DOMAIN: " $(DOMAIN)
	@echo "SOURCE_DIR: " $(SOURCE_DIR)
	@echo "TARGET_DIR: " $(TARGET_DIR)
	@echo "PLUGINS: " $(PLUGINS)
	@echo "STATIC_SOURCES: " $(STATIC_SOURCES)
	@echo "STATIC_TARGETS: " $(STATIC_TARGETS)
	@echo "CSS_SOURCES: " $(CSS_SOURCES)
	@echo "CSS_TARGETS: " $(CSS_TARGETS)
	@echo "MD_SOURCES: " $(MD_SOURCES)
	@echo "MD_TARGETS: " $(MD_TARGETS)
	@echo "DOT_SOURCES: " $(DOT_SOURCES)
	@echo "DOT_TARGETS: " $(DOT_TARGETS)
	@echo "NEATO_SOURCES: " $(NEATO_SOURCES)
	@echo "NEATO_TARGETS: " $(NEATO_TARGETS)
	@echo "FDP_SOURCES: " $(FDP_SOURCES)
	@echo "FDP_TARGETS: " $(FDP_TARGETS)
	@echo "SFDP_SOURCES: " $(SFDP_SOURCES)
	@echo "SFDP_TARGETS: " $(SFDP_TARGETS)
	@echo "TWOPI_SOURCES: " $(TWOPI_SOURCES)
	@echo "TWOPI_TARGETS: " $(TWOPI_TARGETS)
	@echo "CIRCO_SOURCES: " $(CIRCO_SOURCES)
	@echo "CIRCO_TARGETS: " $(CIRCO_TARGETS)
	@echo "SEQ_SOURCES: " $(SEQ_SOURCES)
	@echo "SEQ_TARGETS: " $(SEQ_TARGETS)
