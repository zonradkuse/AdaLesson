if [ -f $1 ]; then
    pandoc $1 --latex-engine=xelatex -o "pdf/solution_$(date +%y-%m-%d).pdf"

else
    echo "You need to specify a valid input file!"
fi
