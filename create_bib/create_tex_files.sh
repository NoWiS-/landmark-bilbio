#!/bin/bash

# Ugly thingy to make nice fullcitation in beamer !
# Then you can use input{citation} in a block

# Carefull, use it in a separate folder... 

echo_bibitem()
{
	echo "New bibfile : $2"

	echo "\\begin{thebibliography}{10}" > "${2}.tex"
	echo "\\footnotesize" >> ${2}.tex
	echo "$1" >> "${2}.tex"
	echo "\\end{thebibliography}" >> "${2}.tex"
}

if [ $# -ne 2 ]; then
  echo "usage: $0 bibtex_file.bib output_dir";
  exit 1;
fi

if ! [ -f $1 ]; then
  echo "File $1 does not exists";
  exit 1;
fi

if ! [[ $1 =~ ".bib" ]]; then
  echo "bibfile should end with .bib extension !";
  exit 1;
fi

OUTPUT=$2
BIB_FILE=$1
TMP_TEX="__bib_$(basename $BIB_FILE .bib)"
echo "\documentclass{article}
\begin{document}
  \nocite{*}
  \bibliographystyle{plain}
  \bibliography{$BIB_FILE}
\end{document}
" > $TMP_TEX.tex

pdflatex "$TMP_TEX"
bibtex "$TMP_TEX" 
pdflatex "$TMP_TEX"
pdflatex "$TMP_TEX"

if ! [ -f "$TMP_TEX.bbl" ]; then
  echo "(WTF) bbl file not generated !"
	exit 1;
fi

name="__dummy__"
tmp=""
while read -r line; do
	if [[ $line =~ '\bibitem' ]]; then
		echo_bibitem "$tmp" "$OUTPUT/$name"
		name=`echo "$line" | sed 's/.bibitem.\(.*\)./\1/'`
		tmp=""
	fi

  tmp=$(printf "%s\n%s" "$tmp" "$line")
done < "$TMP_TEX.bbl";


echo_bibitem "$tmp" "$OUTPUT/$name"
head -n-1 "$OUTPUT/${name}.tex" > __dummy__.tex
mv __dummy__.tex "$OUTPUT/${name}.tex"
rm -f "$OUTPUT/__dummy__.tex"

exit 0

