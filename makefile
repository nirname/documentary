# 'Makefile'

# Where sources are located
SOURCE_DIR = source
# Where all the compiled sources will be
TARGET_DIR = docs

MD = pandoc --data-dir=$(CURDIR) \
	--from markdown --standalone --quiet \
	--highlight-style kate \
	--filter plugins/graphviz.py \
	--filter plugins/diag.py

DOT = dot -Tsvg
NEATO = neato -Tsvg
FDP = fdp -Tsvg
SFDT = sfdp -Tsvg
TWOPI = twopi -Tsvg
CIRCO = circo -Tsvg
SEQ = seqdiag -Tsvg

STATIC_SOURCES = $(shell find -E $(SOURCE_DIR) -iregex '.*\.(png|jpg|jpeg|svg)$$')
STATIC_TARGETS = $(STATIC_SOURCES:$(SOURCE_DIR)/%=$(TARGET_DIR)/%)

CSS_SOURCES = $(shell find $(SOURCE_DIR) -name '*.css')
CSS_TARGETS = $(CSS_SOURCES:$(SOURCE_DIR)/%.css=$(TARGET_DIR)/%.css)

MD_SOURCES = $(shell find $(SOURCE_DIR) -name '*.md')
MD_TARGETS = $(MD_SOURCES:$(SOURCE_DIR)/%.md=$(TARGET_DIR)/%.html)

DOT_SOURCES = $(shell find $(SOURCE_DIR) -name '*.dot')
DOT_TARGETS = $(DOT_SOURCES:$(SOURCE_DIR)/%.dot=$(TARGET_DIR)/%.svg)

NEATO_SOURCES = $(shell find $(SOURCE_DIR) -name '*.neato')
NEATO_TARGETS = $(NEATO_SOURCES:$(SOURCE_DIR)/%.neato=$(TARGET_DIR)/%.svg)

FDP_SOURCES = $(shell find $(SOURCE_DIR) -name '*.fdp')
FDP_TARGETS = $(FDP_SOURCES:$(SOURCE_DIR)/%.fdp=$(TARGET_DIR)/%.svg)

SFDP_SOURCES = $(shell find $(SOURCE_DIR) -name '*.sfdp')
SFDP_TARGETS = $(SFDP_SOURCES:$(SOURCE_DIR)/%.sfdp=$(TARGET_DIR)/%.svg)

TWOPI_SOURCES = $(shell find $(SOURCE_DIR) -name '*.twopi')
TWOPI_TARGETS = $(TWOPI_SOURCES:$(SOURCE_DIR)/%.twopi=$(TARGET_DIR)/%.svg)

CIRCO_SOURCES = $(shell find $(SOURCE_DIR) -name '*.circo')
CIRCO_TARGETS = $(CIRCO_SOURCES:$(SOURCE_DIR)/%.circo=$(TARGET_DIR)/%.svg)

SEQ_SOURCES = $(shell find $(SOURCE_DIR) -name '*.seq')
SEQ_TARGETS = $(SEQ_SOURCES:$(SOURCE_DIR)/%.seq=$(TARGET_DIR)/%.svg)

all: sources no_jekyll

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

$(STATIC_TARGETS):$(TARGET_DIR)/%: $(SOURCE_DIR)/% makefile
	@mkdir -p $(@D)
	cp -f $< $@

$(CSS_TARGETS):$(TARGET_DIR)/%.css: $(SOURCE_DIR)/%.css makefile
	@mkdir -p $(@D)
	cp -f $< $@

$(MD_TARGETS):$(TARGET_DIR)/%.html: $(SOURCE_DIR)/%.md $(CSS_TARGETS) makefile plugins/*.py
	@mkdir -p $(@D)
	$(MD) $(foreach var,$(CSS_TARGETS), --css `python plugins/relpath.py $(var) $(@D)`) --to html5 $< --output $@
	@sed -i '' -e '/href="./s/\.md/\.html/g' $@
	@sed -i '' -e '/href="./s/\.dot/\.svg/g' $@
	@sed -i '' -e '/href="./s/\.neato/\.svg/g' $@
	@sed -i '' -e '/href="./s/\.fdp/\.svg/g' $@
	@sed -i '' -e '/href="./s/\.sfdp/\.svg/g' $@
	@sed -i '' -e '/href="./s/\.twopi/\.svg/g' $@
	@sed -i '' -e '/href="./s/\.circo/\.svg/g' $@
	@sed -i '' -e '/src="./s/\.dot/\.svg/g' $@
	@sed -i '' -e '/src="./s/\.neato/\.svg/g' $@
	@sed -i '' -e '/src="./s/\.fdp/\.svg/g' $@
	@sed -i '' -e '/src="./s/\.sfdp/\.svg/g' $@
	@sed -i '' -e '/src="./s/\.twopi/\.svg/g' $@
	@sed -i '' -e '/src="./s/\.circo/\.svg/g' $@
	@sed -i '' -e '/src="./s/\.seq/\.svg/g' $@

$(DOT_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/%.dot makefile
	@mkdir -p $(@D)
	$(DOT) $< -o $@

$(NEATO_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/%.neato makefile
	@mkdir -p $(@D)
	$(NEATO) $< -o $@

$(FDP_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/%.fdp makefile
	@mkdir -p $(@D)
	$(FDP) $< -o $@

$(SFDP_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/%.sfdp makefile
	@mkdir -p $(@D)
	$(SFDP) $< -o $@

$(TWOPI_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/%.twopi makefile
	@mkdir -p $(@D)
	$(TWOPI) $< -o $@

$(CIRCO_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/%.circo makefile
	@mkdir -p $(@D)
	$(CIRCO) $< -o $@

$(SEQ_TARGETS):$(TARGET_DIR)/%.svg: $(SOURCE_DIR)/%.seq makefile
	@mkdir -p $(@D)
	$(SEQ) $< -o $@

no_jekyll: $(TARGET_DIR)/.no_jekyll

$(TARGET_DIR)/.no_jekyll:
	touch $@

PHONY: watch serve clean debug

watch:
	(while true; do make; sleep 1; done) | grep -v 'make\[1\]'

serve:
	cd $(TARGET_DIR) && python -m SimpleHTTPServer 8000

clean:
	rm -rf $(TARGET_DIR)/*

# QQQ = $(foreach var,$(CSS_SOURCES), $(python plugins/relpath.py . $(var));)

debug:
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
