# Persistence Regression
# Does a club's wage-efficiency residual predict its residual the following season? Persistence indicates a durable, non-wage factor; none indicates luck.

library(dplyr)
library(sandwich)
library(lmtest)

# Season strings ("2019-2020") sort chronologically, so lag() gives the previous season's residual within each club
persistence_df <- read.csv("data/efficiency_panel.csv") %>%
  arrange(club, season) %>%
  group_by(club) %>%
  mutate(efficiency_prev = lag(efficiency)) %>%
  ungroup() %>%
  filter(!is.na(efficiency_prev))

nrow(persistence_df)          # consecutive-season pairs available (expect 112)

# Pooled AR(1): no club fixed effects, to preserve between-club differences
# and avoid Nickell bias with a lagged dependent variable in a short panel
persist_fit <- lm(efficiency ~ efficiency_prev, data = persistence_df)
summary(persist_fit)

# Cluster-robust SEs adjust only the standard errors and p-values
coeftest(persist_fit, vcov = vcovCL, cluster = ~club)
