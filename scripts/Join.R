# Joining League Wages Tables & League Position Tables
library(readxl)
library(dplyr)

pos_dir  <- "League Pos Raw"
wage_dir <- "League Wages Raw"

# Get season from filenames
season_from <- function(f) sub("^(\\d{4}-\\d{4}).*", "\\1", basename(f))

# read every position file and stack them into one table
pos_files <- list.files(pos_dir, full.names = TRUE)
results <- bind_rows(lapply(pos_files, function(f) {
  d <- read_excel(f)
  d$season <- season_from(f)
  d
}))

# read every wage file and stack them into one table
wage_files <- list.files(wage_dir, full.names = TRUE)
wages <- bind_rows(lapply(wage_files, function(f) {
  d <- read_excel(f)
  d$season <- season_from(f)
  d
}))

glimpse(results)
glimpse(wages)

library(dplyr)

# 1. Pull the GBP annual wage out of the text: drop everything from "(" on,
#    then strip all non-digits, leaving the pound figure as a number
wages <- wages %>%
  mutate(wage_gbp_annual = as.numeric(gsub("[^0-9]", "", sub("\\(.*$", "", `Annual Wages`))))

# 2. Keep only what we need from each table, renaming to clean column names
wages_clean <- wages %>%
  select(club = Squad, season, wage_gbp_annual)

results_clean <- results %>%
  select(club = Squad, season, points = Pts, ppg = `Pts/MP`, rank = Rk)

# 3. Join on club + season
merged <- inner_join(results_clean, wages_clean, by = c("club", "season"))

# 4. Verify nothing dropped
nrow(merged)               # want 100
count(merged, season)      # want 20 in each of the 5 seasons
anti_join(results_clean, wages_clean, by = c("club", "season"))  # want 0 rows
