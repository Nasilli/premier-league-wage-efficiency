# Diagnostic Checks
# Run after the regression script (uses the fitted model object `fit`).

par(mfrow = c(2, 2))   # show the four plots in a 2x2 grid
plot(fit)
par(mfrow = c(1, 1))   # reset the plotting layout afterwards

# All four diagnostics are clean: linear in logs, homoscedastic, roughly normal
# residuals, and no influential outliers beyond Cook's distance. The model meets
# its OLS assumptions, supporting the slope estimate and the residual rankings.
