TEX := rebuttal.tex

rebuttal.pdf: $(TEX)
	latexmk -pdf -halt-on-error $<

.PHONY: tidy
tidy:
	latexmk -c $(TEX)

.PHONY: clean
clean:
	latexmk -C $(TEX)
