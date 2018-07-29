# build data sources document for viewing on github
## note that $< :: the filename of the first prereq
data/data-sources.md: data/data-sources.Rmd
	Rscript -e 'rmarkdown::render("$<")'

# clean eliminates all compiled files for a fresh start	
clean:
	rm -f data/data-sources.md