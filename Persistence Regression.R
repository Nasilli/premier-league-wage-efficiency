# Persistence Regression:
# does a club's wage-efficiency residual (non-player-wage performance) predict its residual the following season? (persistence = skill, none = luck)

library(dplyr)

persistence_df <- model_df %>%
  arrange(club, season) %>%
  group_by(club) %>%
  mutate(efficiency_prev = lag(efficiency)) %>%
  ungroup() %>%
  filter(!is.na(efficiency_prev))

nrow(persistence_df)          # how many club-season pairs you have to work with
persist_fit <- lm(efficiency ~ efficiency_prev, data = persistence_df)
summary(persist_fit)

install.packages("sandwich")
install.packages("lmtest")
library(sandwich)
library(lmtest)

# Your clean, unbiased model
persist_fit <- lm(efficiency ~ efficiency_prev, data = persistence_df)

# Adjusts ONLY the standard errors/p-values for club-level clustering
coeftest(persist_fit, vcov = vcovCL, cluster = ~club) 