# Diagnostic Checks
par(mfrow = c(2, 2))   # show the four plots in a 2x2 grid
plot(fit)
par(mfrow = c(1, 1))   # reset the plotting layout afterwards

# all four diagnostics are clean. The model meets its assumptions — linear (in logs), homoscedastic, roughly normal residuals, no influential outliers. That's genuinely better than typical football data usually behaves, and it means you can state your slope and residual rankings with confidence rather than hedging.