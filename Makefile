# build data sources document for viewing on github
## note that $< :: the filename of the first prereq
data/data-sources.md: data/data-sources.Rmd data/raw/shor_mccarty_1993-2016_individual_legislator_data_May_2018_release_(Updated_July_2018).dta
	Rscript -e 'rmarkdown::render("$<")'

# clean eliminates all compiled files for a fresh start	
clean:
	rm -f data/data-sources.md