# Make sure output dirs exist
if (!dir.exists("tables")) dir.create("tables", recursive = TRUE)
if (!dir.exists("figs")) dir.create("figs", recursive = TRUE)
if (!dir.exists("report_out")) dir.create("report_out", recursive = TRUE)

# Build table + figure
source("code/make_table.R")
source("code/make_figure.R")

# Knit from report/ so ../tables paths work
setwd("report")

rmarkdown::render(
  input       = "Final-Project-1.Rmd",
  output_dir  = "../report_out",
  output_file = "Final-Project-1.html",
  knit_root_dir = "."
)



