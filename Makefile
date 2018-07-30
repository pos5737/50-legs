all: doc/50-legs.pdf data/data-sources.md README.md

# clean the raw data; this builds .rds and .csv versions
## note that $< :: the filename of the first prereq
data/shor-mccarty.rds: R/clean-data.R data/raw/shor_mccarty_1993-2016_individual_legislator_data_May_2018_release_(Updated_July_2018).dta
	Rscript $<

# build data sources document for viewing on github
data/data-sources.md: data/data-sources.Rmd data/shor-mccarty.rds data/raw/shor_mccarty_1993-2016_individual_legislator_data_May_2018_release_(Updated_July_2018).dta
	Rscript -e 'rmarkdown::render("$<")'

# create data frame of SDs by party-state-year
data/sds.rds: R/calc-sds.R data/shor-mccarty.rds
	Rscript $<

# create plot of SDs by party-state-year
doc/figs/sds.pdf: R/plot-sds.R data/sds.rds
	Rscript $<

# compile manuscript	
doc/50-legs.pdf: doc/50-legs.tex doc/bibliography.bib doc/figs/sds.pdf 
  # cd into doc so that pdflatex runs in the doc directory
	cd doc; pdflatex 50-legs.tex; pdflatex 50-legs.tex; 
	cd doc; bibtex 50-legs.tex; pdflatex 50-legs.tex
	cd doc; rm -f *.bbl *.log *.synctex.gz *.aux *.out
	
# render README
README.md: README.Rmd
	Rscript -e 'rmarkdown::render("$<")'	

# clean eliminates all compiled files for a fresh start	
clean:
	rm -f data/shor-mccarty.csv data/shor-mccarty.rds
	rm -f data/data-sources.md 
	rm -f data/sds.csv data/sds.rds
	rm -f doc/figs/sds.pdf
	rm -f doc/50-legs.pdf
	rm -f README.md file-dag-1.png

