# code/render_report_docker.R

# Make sure an output directory exists (inside container)
if (!dir.exists("report_out")) {
  dir.create("report_out", recursive = TRUE)
}

# Render the report from the Rmd shipped in the image
rmarkdown::render(
  input         = "report/Final-Project-1.Rmd",
  output_dir    = "report_out",
  output_file   = "Final-Project-1.html",
  knit_root_dir = "report"
)
