# Exports: For the write up

# regression tables and key numbers, written to a text file
capture.output(summary(fit), summary(persist_fit), file = "model_outputs.txt")

library(dplyr)

# Exporting Tables as CSV

# top 10 over- and bottom 10 under-performers
model_df %>% arrange(desc(efficiency)) %>%
  select(club, season, points, wage_gbp_annual, efficiency) %>% head(10) %>%
  write.csv("top10_overperformers.csv", row.names = FALSE)

model_df %>% arrange(efficiency) %>%
  select(club, season, points, wage_gbp_annual, efficiency) %>% head(10) %>%
  write.csv("bottom10_underperformers.csv", row.names = FALSE)

# club-level average efficiency, for the bar chart
model_df %>% group_by(club) %>%
  summarise(mean_efficiency = mean(efficiency), seasons = n()) %>%
  arrange(desc(mean_efficiency)) %>%
  write.csv("club_avg_efficiency.csv", row.names = FALSE)

# Exporting Modeling datasets:
write.csv(model_df, "model_df_full.csv", row.names = FALSE)
write.csv(persistence_df, "persistence_pairs.csv", row.names = FALSE)
