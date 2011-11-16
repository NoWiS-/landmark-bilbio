SRCS = *.tex
NAME = presentation
BIN = $(NAME).pdf

default: build

all: build run

.PHONY: default build clean mrproper run

build: $(SRCS)
	pdflatex $(NAME)
	#bibtex $(NAME)
	#pdflatex $(NAME)
	pdflatex $(NAME)

run: build
	evince $(BIN)

clean:
	rm -f *.vrb *.nav *.snm *.log *.aux *.toc *.out *.bbl *.blg *.dvi

mrproper: clean
	rm -f $(BIN)
