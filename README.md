# Football KPIs — Final Project 

This repository contains my final project for **Football Matches 2024/2025 KPI Analysis**
It uses **base R** and `rmarkdown` to generate tables, figures, and my final report.

---

## 🗂 Project Structure
```
.
├── code/
│   ├── make_table.R           # Builds league_kpis.csv (league summary)
│   ├── make_figure.R          # Builds total_goals_hist.png (distribution plot)
│   └── report.Rmd             # Small scaffold Rmd (optional)
├── data/
│   └── football_matches_2024_2025.csv
├── figs/                      # Generated (git-ignored)
├── tables/                    # Generated (git-ignored)
├── report/
│   └── Final-Project-1.Rmd    # Your main R Markdown file
├── Makefile
└── README.md
```

---

## 🧰 Build Instructions
This workflow is driven by **Make** and **Rscript**.

### Prerequisites
Install required R packages:
```r
install.packages(c("rmarkdown", "knitr"))
```

### Build Everything
```bash
make
```
This will:
1. Run `code/make_table.R` → creates `tables/league_kpis.csv`
2. Run `code/make_figure.R` → creates `figs/total_goals_hist.png`
3. Render `report/Final-Project-1.Rmd` → produces `report/Final-Project-1.html`

### Build Individual Parts
```bash
make tables     # only the KPI table
make figs       # only the figure
make report     # only render the final report
make clean      # remove all generated outputs
```

---

## 🧮 Scripts Overview
| File | Purpose |
|------|----------|
| `code/make_table.R` | Calculates league-level KPIs (avg goals, win %, draw %). |
| `code/make_figure.R` | Generates a histogram of total goals per match by competition. |
| `report/Final-Project-1.Rmd` | Your main analysis report that combines the outputs. |

---




