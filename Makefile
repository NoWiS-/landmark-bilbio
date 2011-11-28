# Utils
LATEX = lualatex

# Goal rules
HOFFMANN = hoffmann04
DOMSHLAK_IJCAI = domshlak_ijcai
DISCUSSION = discussion

# Sources
CITATION_SRC = $(wildcard cite/*.tex)
HOFFMANN_SRC = $(wildcard $(HOFFMANN)/*.tex)
DOMSHLAK_IJCAI_SRC = $(wildcard $(DOMSHLAK_IJCAI)/*.tex)
DISCUSSION_SRC = $(wildcard $(DISCUSSION)/*.tex)

# PHONY
.PHONY: citation default build clean mrproper run

# Default rules
default: $(DOMSHLAK_IJCAI)
	@make -s clean
	@echo "Done : $^"

all: $(HOFFMANN) $(DOMSHLAK_IJCAI) $(DISCUSSION)
	@make -s clean
	@echo "Done : $^"

run: $(HOFFMANN) $(DOMSHLAK_IJCAI) $(DISCUSSION)
	evince $(HOFFMANN).pdf $(DOMSHLAK_IJCAI).pdf $(DISCUSSION).pdf

clean:
	rm -f *.vrb *.nav *.snm *.log *.aux *.toc *.out *.bbl *.blg *.dvi

mrproper: clean
	rm -f *.pdf

# Create nice citation for beamer (FIXME : create a latex package)
citation:
	@cd create_bib && ./create_tex_files.sh ../bib.bib ../cite && cd ..
	@rm -f create_bib/__bib*

# Make the pdf for the goal rules
$(HOFFMANN): $(HOFFMANN).pdf
$(DOMSHLAK_IJCAI): $(DOMSHLAK_IJCAI).pdf
$(DISCUSSION): $(DISCUSSION).pdf

# How to make a pdf with latex sources
$(HOFFMANN).pdf: $(HOFFMANN).tex $(HOFFMANN_SRC) $(CITATION_SRC)
	$(LATEX) $<
	$(LATEX) $<

$(DOMSHLAK_IJCAI).pdf: $(DOMSHLAK_IJCAI).tex $(DOMSHLAK_IJCAI_SRC) \
											 $(CITATION_SRC)
	$(LATEX) $<
	$(LATEX) $<

$(DISCUSSION).pdf: $(DISCUSSION).tex $(DISCUSSION_SRC) $(CITATION_SRC)
	$(LATEX) $<
	$(LATEX) $<

