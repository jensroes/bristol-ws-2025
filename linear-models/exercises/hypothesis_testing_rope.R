# Load packages
library(tidyverse)
library(brms)
library(bayestestR) # <- you might need to install this one

# Load posterior from earlier (should still be in your R's memory)
fit_brm <- readRDS(file = "models/fit_brm_with_normalprior.rds")

# List of everything the model has estimates for (we only worry about the first two starting with "b_")
names(fit_brm$fit)

# Extract slope parameter beta (difference between groups)
beta <- as_draws_df(fit_brm) %>% pull(b_nptypesimple)

# Calculate ROPE
rope(beta) # default is a ROPE of -0.1 to 0.1

# Calculate ROPE for range -10 to 0
rope(beta, range = c(---,---))

# Calculate ROPE with no upper bound (an upper bound of Inf) and a lower bound of -5
# This is similar to a one-tailed hypothesis: we don't predict a positive effect
# and believe that values of -5 msecs or larger are against hypothesis.
rope(beta, range = c(---,---))

# Calculate ROPE (with standardised effect size)
# The standardised effect is delta = beta / sigma
# Extract the standard deviation sigma (replace ---)
sigma <- as_draws_df(fit_brm) %>% pull(sigma)

# Calculate the standardised effect of all posterior samples
delta <- beta / sigma

# Summarise the standardised effect size
posterior_summary(abs(delta))

# Calculate ROPE for negligible effects (i.e. inside of -0.1 and 0.1)
rope(---)

