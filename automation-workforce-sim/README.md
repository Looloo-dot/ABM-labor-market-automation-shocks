# Automation Workforce Simulation

Agent-based model of a labor market under automation shocks, focused on worker mobility, retraining, and wage dynamics.

## Goals
- Simulate how automation adoption affects employment, wages, and skill composition.
- Compare scenarios: baseline vs. automation shocks vs. retraining policy.
- Produce summary metrics and plots suitable for a short technical report.

## Project Structure
- `R/` reusable R functions
- `src/` analysis scripts
- `data/raw/` raw inputs (if any)
- `data/processed/` derived datasets
- `figures/` plots
- `outputs/` tables and model outputs
- `notebooks/` optional RMarkdown or Quarto

## Quickstart
1. Open the R project: `automation-workforce-sim.Rproj`
2. Run `src/01_simulate.R` to generate baseline outputs
3. Run `src/02_analyze.R` to generate figures and summary tables

## Roadmap
- [ ] Define agent state and transition rules
- [ ] Implement automation shock scenarios
- [ ] Add retraining policy variants
- [ ] Add network structure (optional)
- [ ] Write brief report
