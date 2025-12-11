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

## 📦 Package Management with `renv`

This project uses **renv** to ensure reproducible R package environments.  
The `renv.lock` file records exact package versions so the environment can be reconstructed anywhere.

### 🔧 Initial Setup

To install the exact package versions used in this project:

**Option 1 — Using Make**
```bash
make install
```

**Option 2 — Using R**
```r
install.packages("renv")
renv::restore()
```
---

## Dockerized Reproducible Report

The project also includes a Docker image so the report can be built in a fully reproducible environment.

### 1. Build the Docker image

From the project root:

```bash
make docker_build
```

This runs:

```bash
docker build -t dhk262/550fp3:latest .
```

### 2. Generate the report using Docker

These targets run the container and write the compiled report to a local folder called `report`.

#### Mac / Linux / WSL

```bash
make docker_report
```

This:

1. Ensures a local `report/` directory exists.
2. Runs:

   ```bash
   docker run --rm      -v "$(pwd)/report":/project/report_out      dhk262/550fp3:latest
   ```

3. Inside the container, `Rscript code/render_report_docker.R` renders `Final-Project-1.Rmd`
   to `/project/report_out/Final-Project-1.html`.

After it finishes, you’ll have:

```text
report/Final-Project-1.html
```

on your machine.

#### Windows (Git Bash)

On Windows with Git Bash, use the Windows-specific target:

```bash
make docker_report_windows
```

This runs:

```bash
mkdir -p report
docker run --rm   -v /"$(pwd)/report":/project/report_out   dhk262/550fp3:latest
```

After it finishes, you will also have:

```text
report/Final-Project-1.html
```

in the local `report/` folder.

---

**Summary:**

- Local: `make install` then `make`
- Docker (Mac/Linux/WSL): `make docker_build` then `make docker_report`
- Docker (Windows Git Bash): `make docker_build` then `make docker_report_windows`



