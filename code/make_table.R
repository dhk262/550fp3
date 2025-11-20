# Generate league-level KPI table using columns from Final Project (1).Rmd
# Inputs: data/football_matches_2024_2025.csv
# Output: tables/league_kpis.csv

infile  <- "data/football_matches_2024_2025.csv"
outcsv  <- "tables/league_kpis.csv"

dir.create("tables", showWarnings = FALSE, recursive = TRUE)

d <- read.csv(infile, stringsAsFactors = FALSE)

normalize <- function(n) tolower(gsub("\\.+", "_", gsub("\\s+", "_", n)))
names(d) <- normalize(names(d))

required <- c("competition_name","fulltime_home","fulltime_away")
missing <- setdiff(required, names(d))
if (length(missing) > 0) stop(paste("Missing required columns:", paste(missing, collapse=", ")))

# derive match_outcome if needed
if (!"match_outcome" %in% names(d)) {
  d$match_outcome <- ifelse(d$fulltime_home > d$fulltime_away, "Home Win",
                       ifelse(d$fulltime_home < d$fulltime_away, "Away Win", "Draw"))
}

# derive total_goals if missing
if (!"total_goals" %in% names(d)) {
  d$total_goals <- d$fulltime_home + d$fulltime_away
}

by_comp <- split(d, d$competition_name)

summarize_comp <- function(df) {
  total_matches <- nrow(df)
  avg_goals     <- mean(df$total_goals, na.rm = TRUE)
  home_win_pct  <- 100 * mean(df$match_outcome == "Home Win", na.rm = TRUE)
  away_win_pct  <- 100 * mean(df$match_outcome == "Away Win", na.rm = TRUE)
  draw_pct      <- 100 * mean(df$match_outcome == "Draw", na.rm = TRUE)
  data.frame(
    competition_name = df$competition_name[1],
    total_matches = total_matches,
    avg_goals = round(avg_goals, 2),
    home_win_pct = round(home_win_pct, 1),
    away_win_pct = round(away_win_pct, 1),
    draw_pct = round(draw_pct, 1),
    stringsAsFactors = FALSE
  )
}

res <- do.call(rbind, lapply(by_comp, summarize_comp))
res <- res[order(res$competition_name), ]

write.csv(res, outcsv, row.names = FALSE)
cat(sprintf("Wrote: %s\n", outcsv))