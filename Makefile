TEX := rebuttal.tex
TYP := rebuttal.typ

.PHONY: help
help: ## Show available targets
	@grep -E '^[a-zA-Z_.-]+:.*##' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*## "}; {printf "  %-22s %s\n", $$1, $$2}'

.PHONY: all
all: rebuttal.pdf rebuttal-typst.pdf ## Build both PDFs

rebuttal.pdf: $(TEX) ## Build LaTeX PDF
	latexmk -pdf -halt-on-error $<

rebuttal-typst.pdf: $(TYP) ## Build Typst PDF
	typst compile $< $@

.PHONY: tidy
tidy: ## Remove auxiliary files
	latexmk -c $(TEX)

.PHONY: clean
clean: ## Remove all generated files
	latexmk -C $(TEX)
	rm -f rebuttal-typst.pdf
