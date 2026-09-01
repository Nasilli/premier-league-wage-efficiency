# Data preparation
# Reads raw FBref league tables and Capology wage tables (one file per season),
# extracts annual GBP wage bills, and joins into a single club-season panel.
# Output: data/merged_panel.csv (140 club-seasons, 2019/20–2025/26)

library(readxl)
library(dplyr)

pos_dir  <- "data/league-position"
wage_dir <- "data/wages"

# Season label is the leading YYYY-YYYY in each filename
season_from <- function(f) sub("^(\\d{4}-\\d{4}).*", "\\1", basename(f))

# Stack all season files into one table
pos_files <- list.files(pos_dir, full.names = TRUE)
results <- bind_rows(lapply(pos_files, function(f) {
  d <- read_excel(f)
  d$season <- season_from(f)
  d
}))

wage_files <- list.files(wage_dir, full.names = TRUE)
wages <- bind_rows(lapply(wage_files, function(f) {
  d <- read_excel(f)
  d$season <- season_from(f)
  d
}))

# Extract the GBP annual wage: 
wages <- wages %>%
  mutate(wage_gbp_annual = as.numeric(gsub("[^0-9]", "", sub("\\(.*$", "", `Annual Wages`))))

wages_clean <- wages %>%
  select(club = Squad, season, wage_gbp_annual)

results_clean <- results %>%
  select(club = Squad, season, points = Pts, ppg = `Pts/MP`, rank = Rk)

merged <- inner_join(results_clean, wages_clean, by = c("club", "season"))

# Data integrity checks
nrow(merged)                                                     # expect 140
count(merged, season)                                            # expect 20 per season, 7 seasons
anti_join(results_clean, wages_clean, by = c("club", "season"))  # expect 0 rows

write.csv(merged, "data/merged_panel.csv", row.names = FALSE)
