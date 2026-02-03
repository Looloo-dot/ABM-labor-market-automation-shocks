# Core agent-based model functions

init_agents <- function(n_agents, seed = 123, share_high_skill = 0.3) {
  set.seed(seed)
  skill <- ifelse(runif(n_agents) < share_high_skill, "high", "low")
  employed <- rep(TRUE, n_agents)
  wage <- ifelse(skill == "high", 35, 20)
  data.frame(
    id = seq_len(n_agents),
    skill = skill,
    employed = employed,
    wage = wage,
    stringsAsFactors = FALSE
  )
}

step_market <- function(agents, params, t) {
  # Automation schedule
  if (t < params$shock_start) {
    a_t <- params$automation_base
  } else {
    a_t <- min(1, params$automation_base + (t - params$shock_start) * params$automation_rate)
  }

  # Employment targets
  target_low <- params$base_employment_low * (1 - a_t * params$automation_impact)
  target_high <- params$base_employment_high

  # Update employment stochastically
  low_idx <- agents$skill == "low"
  high_idx <- agents$skill == "high"

  agents$employed[low_idx] <- runif(sum(low_idx)) < target_low
  agents$employed[high_idx] <- runif(sum(high_idx)) < target_high

  # Retraining for unemployed low-skill
  retrain_idx <- low_idx & !agents$employed
  retrain_draw <- runif(sum(retrain_idx)) < params$retrain_prob
  if (any(retrain_draw)) {
    ids <- which(retrain_idx)
    agents$skill[ids[retrain_draw]] <- "high"
  }

  # Wage update
  agents$wage <- ifelse(
    agents$skill == "high",
    params$wage_high * (1 + params$automation_productivity * a_t),
    params$wage_low * (1 - params$automation_wage_pressure * a_t)
  )
  agents$wage[!agents$employed] <- 0

  # Metrics
  metrics <- data.frame(
    t = t,
    automation = a_t,
    employment_rate = mean(agents$employed),
    avg_wage = mean(agents$wage),
    share_high_skill = mean(agents$skill == "high")
  )

  list(agents = agents, metrics = metrics)
}

simulate_market <- function(agents, params, n_steps = 50) {
  metrics <- vector("list", n_steps)
  for (t in seq_len(n_steps)) {
    step <- step_market(agents, params, t)
    agents <- step$agents
    metrics[[t]] <- step$metrics
  }
  list(
    agents = agents,
    metrics = do.call(rbind, metrics)
  )
}
