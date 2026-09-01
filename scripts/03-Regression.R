# Regression Script: log wages & fit regression with fixed effects. Wage slope = money to points conversion rate. Residuals = wage efficiency (performance not explained by player wages)

library(dplyr)
library(sandwich)
library(lmtest)

model_df <- read.csv("data/merged_panel.csv") %>%
  mutate(ln_wage = log(wage_gbp_annual)) #adds log wage column

#fitting model
fit <- lm(points ~ ln_wage + factor(season), data = model_df)
summary(fit)
coeftest(fit, vcov = vcovCL, cluster = ~club)

#attach each club's season residual (actual points - fitted points)
model_df$efficiency <- resid(fit)

# top 10 overperformers vs payroll
model_df %>% arrange(desc(efficiency)) %>%
  select(club, season, points, wage_gbp_annual, efficiency) %>% head(10)

# bottom 10 underperformers
model_df %>% arrange(efficiency) %>%
  select(club, season, points, wage_gbp_annual, efficiency) %>% head(10)

write.csv(model_df, "data/efficiency_panel.csv", row.names = FALSE)
