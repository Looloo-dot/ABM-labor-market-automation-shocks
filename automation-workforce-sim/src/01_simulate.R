source("R/abm.R")

params <- list(
  automation_base = 0.05,
  automation_rate = 0.03,
  automation_impact = 0.8,
  automation_productivity = 0.4,
  automation_wage_pressure = 0.3,
  shock_start = 10,
  base_employment_low = 0.92,
  base_employment_high = 0.96,
  retrain_prob = 0.08,
  wage_low = 22,
  wage_high = 38
)

agents <- init_agents(n_agents = 2000, seed = 42, share_high_skill = 0.35)

sim <- simulate_market(agents, params, n_steps = 60)

if (!dir.exists("outputs")) dir.create("outputs", recursive = TRUE)
write.csv(sim$metrics, "outputs/metrics.csv", row.names = FALSE)

# Save final agent state for optional analysis
write.csv(sim$agents, "outputs/agents_final.csv", row.names = FALSE)
