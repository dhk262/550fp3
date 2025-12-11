# Basic R final project Makefile (Final Project 1)

# Default target: build the final report
all: report/Final-Project-1.html

# Generate the KPI table
tables/league_kpis.csv: code/make_table.R data/football_matches_2024_2025.csv
	Rscript code/make_table.R

# Generate the figure
figs/total_goals_hist.png: code/make_figure.R data/football_matches_2024_2025.csv
	Rscript code/make_figure.R

# Render the final report using your Rmd directly
report/Final-Project-1.html: report/Final-Project-1.Rmd tables/league_kpis.csv figs/total_goals_hist.png
	Rscript -e "setwd('report'); rmarkdown::render('Final-Project-1.Rmd', output_dir='.', output_file='Final-Project-1.html', knit_root_dir='.')" || true



# Convenience targets
tables: tables/league_kpis.csv
figs: figs/total_goals_hist.png
report: report/Final-Project-1.html

# Clean up generated outputs
clean:
	rm -f tables/*.csv figs/*.png report/*.html

.PHONY: all tables figs report clean

install:
	R -e "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv'); renv::restore()"
	
# Build Docker image tagged with your DockerHub repo
docker_build:
	docker build -t dhk262/550fp3:latest .

# Run the containerized workflow and retrieve the report
docker_report_windows:
	mkdir -p report
	docker run --rm \
		-v /"$$PWD/report":/project/report_out \
		dhk262/550fp3:latest

.PHONY: all tables figs report clean install docker_build docker_report_windows