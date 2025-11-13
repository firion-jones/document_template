# Makefile for converting Markdown files to PDF

# Source and destination directories
SRC_DIR = markdown
BUILD_DIR = build

# Find all .md files in the markdown directory
MD_FILES := $(wildcard $(SRC_DIR)/*.md)

# Generate corresponding PDF filenames in the build directory
PDF_FILES := $(patsubst $(SRC_DIR)/%.md,$(BUILD_DIR)/%.pdf,$(MD_FILES))

# Pandoc options with citation support and better image handling
PANDOC_OPTS = -V geometry:margin=0.75in -V fontsize=9pt -V papersize=a4 \
              --resource-path=.:images:markdown \
              --citeproc \
              --bibliography=references.bib \
              --csl=harvard-cite-them-right.csl \
              -H header.tex \
              --from=markdown+raw_tex \
              -V graphics=true \
              -V colorlinks=true \
              --default-image-extension=png \
              -M floatplacement=H \
			  

# Make LaTeX \input look into project, markdown, and tables directories.
TEXINPUTS_PATH := .:$(SRC_DIR):$(SRC_DIR)/tables:

# Default target
all: $(PDF_FILES)

# Combined report target
combined: $(BUILD_DIR)/combined-report.pdf

$(BUILD_DIR)/combined-report.pdf: $(MD_FILES) references.bib harvard-cite-them-right.csl | $(BUILD_DIR)
	TEXINPUTS="$(TEXINPUTS_PATH)" pandoc $(SRC_DIR)/*.md -o $@ $(PANDOC_OPTS)

# Combined report without table of contents (for submission)
submission: $(BUILD_DIR)/submission-report.pdf

$(BUILD_DIR)/submission-report.pdf: $(MD_FILES) references.bib harvard-cite-them-right.csl | $(BUILD_DIR)
	TEXINPUTS="$(TEXINPUTS_PATH)" pandoc $(SRC_DIR)/*.md -o $@ $(PANDOC_OPTS)

# Rule to create build directory if it doesn't exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Pattern rule to convert .md files to .pdf files
$(BUILD_DIR)/%.pdf: $(SRC_DIR)/%.md | $(BUILD_DIR)
	TEXINPUTS="$(TEXINPUTS_PATH)" pandoc $< -o $@ $(PANDOC_OPTS)

# Clean target to remove generated PDFs
clean:
	rm -rf $(BUILD_DIR)

# Phony targets
.PHONY: all clean combined submission

# Print help information
help:
	@echo "Available targets:"
	@echo "  all        - Convert all Markdown files to PDF (default)"
	@echo "  combined   - Create single combined report PDF with TOC"
	@echo "  submission - Create combined report PDF without TOC"
	@echo "  clean      - Remove all generated PDF files"
	@echo "  help       - Show this help message"
	@echo ""
	@echo "Markdown files should be placed in the '$(SRC_DIR)/' directory"
	@echo "Generated PDFs will be placed in the '$(BUILD_DIR)/' directory"
	@echo "Citation files needed: references.bib and harvard-cite-them-right.csl"
	@echo "LaTeX includes resolved via TEXINPUTS: $(TEXINPUTS_PATH)"