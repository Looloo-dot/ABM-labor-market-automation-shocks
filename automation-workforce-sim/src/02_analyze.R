if (!requireNamespace("ggplot2", quietly = TRUE)) {
  stop("Package 'ggplot2' is required. Install with install.packages('ggplot2').")
}

library(ggplot2)

metrics <- read.csv("outputs/metrics.csv")

if (!dir.exists("figures")) dir.create("figures", recursive = TRUE)

p1 <- ggplot(metrics, aes(t, employment_rate)) +
  geom_line(linewidth = 1) +
  ylim(0, 1) +
  labs(title = "Employment Rate", x = "Time", y = "Employment")

ggsave("figures/employment_rate.png", p1, width = 7, height = 4)

p2 <- ggplot(metrics, aes(t, avg_wage)) +
  geom_line(linewidth = 1) +
  labs(title = "Average Wage", x = "Time", y = "Avg Wage")

ggsave("figures/avg_wage.png", p2, width = 7, height = 4)

p3 <- ggplot(metrics, aes(t, share_high_skill)) +
  geom_line(linewidth = 1) +
  ylim(0, 1) +
  labs(title = "Share High Skill", x = "Time", y = "Share")

ggsave("figures/share_high_skill.png", p3, width = 7, height = 4)
