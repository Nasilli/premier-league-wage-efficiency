# Persistence Visualisation
library(ggplot2)
library(plotly)

x_lim <- max(abs(persistence_df$efficiency_prev))
y_lim <- max(abs(persistence_df$efficiency))

quad_labels <- data.frame(
  x = c( x_lim*0.6, -x_lim*0.6,  x_lim*0.6, -x_lim*0.6),
  y = c( y_lim*0.95, y_lim*0.95, -y_lim*0.78, -y_lim*0.78),
  label = c("Stayed efficient",
            "Improved\n(inefficient → efficient)",
            "Declined\n(efficient → inefficient)",
            "Stayed inefficient"),
  hjust = c(1, 0, 1, 0)
)

p <- ggplot(persistence_df, aes(x = efficiency_prev, y = efficiency)) +
  geom_hline(yintercept = 0, linetype = "dashed", colour = "grey70") +
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey70") +
  geom_text(data = quad_labels,
            aes(x = x, y = y, label = label, hjust = hjust),
            vjust = 1, colour = "grey35", size = 4.2, alpha = 0.85,
            lineheight = 0.9, fontface = "italic", inherit.aes = FALSE) +
  geom_point(aes(text = paste0(club, " (", season, ")",
                               "<br>This season: ", round(efficiency, 1),
                               "<br>Last season: ", round(efficiency_prev, 1))),
             size = 2.5, alpha = 0.7, colour = "coral3") +
  geom_smooth(method = "lm", se = TRUE, colour = "grey50") +
  labs(
    title = "Wage Efficiency Persistence Season-to-Season",
    subtitle = "A club's points above/below wage prediction vs the prior season",
    x = "Season t-1 Wage Efficiency",
    y = "Season t Wage Efficiency"
  ) +
  theme_minimal()

persistence_widget <- ggplotly(p, tooltip = "text") %>%
  plotly::layout(
    xaxis = list(title = "Season <i>t</i>-1 Wage Efficiency"),
    yaxis = list(title = "Season <i>t</i> Wage Efficiency"),
    margin = list(b = 140)
  ) %>%
  plotly::add_annotations(
    x = 0.98, y = -0.22, xref = "paper", yref = "paper",
    text = "<i>Persistence coefficient = 0.38 (p < 0.001) | R² = 0.15 | n = 112</i>",
    showarrow = FALSE, xanchor = "right",
    font = list(size = 12, color = "grey30", family = "Courier New"),
    opacity = 0.6)

htmlwidgets::saveWidget(persistence_widget, "persistence_interactive.html", selfcontained = TRUE)
