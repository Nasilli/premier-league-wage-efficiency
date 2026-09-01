
# Player-Wage Efficiency in the Premier League

**Isolating and testing the persistence of performance unexplained by player wages (2019/20–2025/26)**

Money buys success in football, but not all of it. This study measures how much of a single season's points tally is explained by player wages, isolates the performance that *isn't*, and tests whether that unexplained performance persists season to season: the difference between a durable operational edge and simple good fortune.

## Key findings

- Player wages explain **under half** (R² = 0.465) of the variation in a single season's points across 140 club-seasons. Doubling a wage bill is associated with roughly **15 extra points**.
- The unexplained performance — "wage efficiency" — **persists**. An AR(1) model on 112 consecutive-season pairs gives a persistence coefficient of **0.383** (p < 0.001, cluster-robust): around 38% of a club's over- or under-performance carries into the following season.
- The persistence coefficient is significantly above zero, so it is **not pure chance**; but well below one, so it is **not pure skill** either. A durable, non-wage component genuinely exists, but transient factors still dominate any individual season.
- Over the period, **Brentford (+15.9 points/season), Manchester City (+13.7 points/season) and Liverpool (+13.5 points/season)** were the most wage-efficient clubs; **Southampton (−11.2 points/season), Manchester United (−8.8 points/season) and Everton (−8.2 points/season)** the least.

improve to: ![Average wage efficiency by club](figures/your-filename.png)
<img width="2842" height="1443" alt="Sheet 1-3" src="https://github.com/user-attachments/assets/2510ee94-06d7-46aa-8765-e627b806634f" />


## Method

Two stages:

1. **Points–wage regression.** OLS of league points on log annual player wages with season fixed effects, cluster-robust standard errors clustered by club. The residual (actual minus wage-predicted points) is the club-season's *wage efficiency*.
2. **Persistence test.** A pooled first-order autoregression of each residual on the same club's previous-season residual. Luck does not repeat; durable advantage does. The coefficient measures how much carries over, if persistence is significance, feel safe in the *wage efficiency* interpretation.

Design choices are set out in full in the write-up: log transformation (diminishing returns, leverage, interpretability), season fixed effects (removing league-wide drift), and clustering rather than club fixed effects (preserving the between-club differences that are the object of study, and avoiding Nickell bias in a short panel with a lagged dependent variable).

## Data

Seven Premier League seasons, 2019/20–2025/26, 140 club-seasons. Points from **FBref**; annual player wage bills from **Capology**.

The window starts at 2019/20 because that is when Capology began applying its salary verification method: earlier wage bills are fully estimated. Capology notes that accuracy correlates with league popularity, which is part of why this study is confined to the Premier League. All figures, including verified ones, remain estimates; results should be read as indicative of a relationship rather than exact measurements of it.

## Repository contents

```
[/data]        Raw league position and wage data (FBref, Capology)
[/scripts]     R script: cleaning, both regressions, diagnostics, charts
[/figures]     Exported charts (PNG) and the interactive persistence plot (HTML)
[write-up.pdf] Full formal write-up
```

## Charts

- **Points vs log wage bill** (interactive, Tableau Public) — [https://public.tableau.com/views/PremierLeagueWageEfficiency2019-2026/Dashboard1?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link]
- **Average wage efficiency by club** (interactive, Tableau Public) — [https://public.tableau.com/views/AverageWageEfficiencybyClubPremierLeague2019-2026/Sheet1?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link]
- **Season-to-season persistence** (interactive, plotly) — [https://nasilli.github.io/premier-league-wage-efficiency/persistence_interactive.html]

## Limitations

The explanatory variable is *player* wages, so non-player spending (coaching, facilities, infrastructure, et cetera) sits inside the residual rather than the model; some of what is measured as "efficiency" may be spending the model cannot see. Wage data is estimated, which dilutes the coefficient. Wages and success are mutually reinforcing, so the study is descriptive rather than causal. Two seasons were COVID-disrupted. And while persistence establishes that *something* durable exists, it cannot identify what that something is.

## Further work

Replicating the two-stage design across Europe's top five leagues separately, to compare how persistence varies with competitive and financial structure; substituting total staff cost for player wages, moving more of the financial dimension into the model and leaving a residual closer to genuinely non-financial drivers; and extending the panel as verified wage data allows.

## Built with

R (`lm`, `sandwich`, `lmtest`, `ggplot2`, `plotly`), Tableau.

---

Luca Nasillo: [https://www.linkedin.com/in/lucanasillo/]
