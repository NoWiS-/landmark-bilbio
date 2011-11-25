LATEX = lualatex
SRCS = *.tex

HOFFMANN = hoffmann04
DOMSHLAK_IJCAI = domshlak_ijcai
DISCUSSION = discussion

HOFFMANN_SRC = $(wildcard $(HOFFMANN)/*.tex)
DOMSHLAK_IJCAI_SRC = $(wildcard $(DOMSHLAK_IJCAI)/*.tex)
DISCUSSION_SRC = $(wildcard $(DISCUSSION)/*.tex)

.PHONY: default build clean mrproper run

default: $(DOMSHLAK_IJCAI)
	@make -s clean
	@echo "Done : $^"

all: $(HOFFMANN) $(DOMSHLAK_IJCAI) $(DISCUSSION)
	@make -s clean
	@echo "Done : $^"

$(HOFFMANN): $(HOFFMANN).pdf
$(DOMSHLAK_IJCAI): $(DOMSHLAK_IJCAI).pdf
$(DISCUSSION): $(DISCUSSION).pdf

$(HOFFMANN).pdf: $(HOFFMANN).tex $(HOFFMANN_SRC)
	$(LATEX) $<
	$(LATEX) $<

$(DOMSHLAK_IJCAI).pdf: $(DOMSHLAK_IJCAI).tex $(DOMSHLAK_IJCAI_SRC)
	$(LATEX) $<
	$(LATEX) $<

$(DISCUSSION).pdf: $(DISCUSSION).tex $(DISCUSSION_SRC)
	$(LATEX) $<
	$(LATEX) $<

run: $(HOFFMANN) $(DOMSHLAK_IJCAI) $(DISCUSSION)
	evince $(HOFFMANN).pdf $(DOMSHLAK_IJCAI).pdf $(DISCUSSION).pdf

clean:
	rm -f *.vrb *.nav *.snm *.log *.aux *.toc *.out *.bbl *.blg *.dvi

mrproper: clean
	rm -f *.pdf
