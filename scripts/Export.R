# Exports: For the write up
library(dplyr)

dir.create("output", showWarnings = FALSE)

# regression tables and key numbers, written to a text file
capture.output(summary(fit), summary(persist_fit), file = "output/model_outputs.txt")

# Exporting Tables as CSV
# top 10 over- and bottom 10 under-performers
model_df %>% arrange(desc(efficiency)) %>%
  select(club, season, points, wage_gbp_annual, efficiency) %>% head(10) %>%
  write.csv("output/top10_overperformers.csv", row.names = FALSE)

model_df %>% arrange(efficiency) %>%
  select(club, season, points, wage_gbp_annual, efficiency) %>% head(10) %>%
  write.csv("output/bottom10_underperformers.csv", row.names = FALSE)

# club-level average efficiency, for the bar chart
model_df %>% group_by(club) %>%
  summarise(mean_efficiency = mean(efficiency), seasons = n()) %>%
  arrange(desc(mean_efficiency)) %>%
  write.csv("output/club_avg_efficiency.csv", row.names = FALSE)

# Exporting Modeling datasets:
write.csv(persistence_df, "output/persistence_pairs.csv", row.names = FALSE)
