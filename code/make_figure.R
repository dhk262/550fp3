# Create distribution figure matching Final Project (1).Rmd style:
# Histogram of total_goals by competition_name
# Output: figs/total_goals_hist.png

infile  <- "data/football_matches_2024_2025.csv"
outfile <- "figs/total_goals_hist.png"

dir.create("figs", showWarnings = FALSE, recursive = TRUE)

d <- read.csv(infile, stringsAsFactors = FALSE)

normalize <- function(n) tolower(gsub("\\.+", "_", gsub("\\s+", "_", n)))
names(d) <- normalize(names(d))

required <- c("competition_name","fulltime_home","fulltime_away")
missing <- setdiff(required, names(d))
if (length(missing) > 0) stop(paste("Missing required columns:", paste(missing, collapse=", ")))

if (!"total_goals" %in% names(d)) {
  d$total_goals <- d$fulltime_home + d$fulltime_away
}

# Base R: overlay histograms per competition (draw sequentially)
png(outfile, width = 1400, height = 800, res = 120)
par(mar = c(5,5,3,2))

brks <- seq(min(d$total_goals, na.rm = TRUE), max(d$total_goals, na.rm = TRUE), by = 1)
if (length(brks) < 2) brks <- seq(0, max(5, max(d$total_goals, na.rm = TRUE)), by = 1)

comps <- sort(unique(d$competition_name))
cols <- c(
  rgb(0,0,1,0.4), rgb(1,0,0,0.4), rgb(0,1,0,0.4),
  rgb(1,0.5,0,0.4), rgb(0.5,0,0.5,0.4), rgb(0,0.5,0.5,0.4),
  rgb(0.6,0.6,0,0.4)
)

# Draw first histogram
hist(d$total_goals[d$competition_name == comps[1]], breaks = brks,
     main = "Distribution of Total Goals per Match by Competition",
     xlab = "Total Goals", ylab = "Frequency",
     col = cols[1], border = NA, xlim = range(brks), ylim = c(0, max(table(d$total_goals))))

# Overlay remaining ones
for (i in 2:length(comps)) {
  ci <- (i - 1) %% length(cols) + 1
  hist(d$total_goals[d$competition_name == comps[i]], breaks = brks,
       col = cols[ci], border = NA, add = TRUE)
}

legend("topright", legend = comps, bty = "n", cex = 0.9,
       fill = cols[1:length(comps)])
dev.off()

cat(sprintf("Wrote: %s\n", outfile))