# Load packages
library(tidyverse)
library(brms)

# Load data
data <- read_csv("data/martin-etal-2010-exp3a.csv")

# Specify mixture model
mixture_of_lognormals <- mixture(lognormal(), lognormal(), order = "mu")

# Specify model
formula <- bf(rt ~ 1 + ( nptype | ppt ) + ( nptype | item ),
              theta2 ~ nptype,
              family = mixture_of_lognormals)

# Check out the priors for this model (some have defaults, others are flat
get_prior(formula, data)

# Setup priors
prior <- set_prior("lkj(2)", class = "cor") +
         set_prior("normal(0, 1)", class = "Intercept", dpar = "theta2") +
         set_prior("normal(6.5, 1)", class = "Intercept", dpar = "mu1") +
         set_prior("normal(7.5, 1)", class = "Intercept", dpar = "mu2") +
         set_prior("normal(0, 1)", class = "b", dpar = "theta2")

# Run model
fit <- brm(formula,
           data = data,
           prior = prior,
           cores = 4,
           init = 0,
           iter = 10000,
           warmup = 5000,
           sample_prior = "yes",
           seed = 265)

# Check out the estimates
fixef(fit)

# Save model
saveRDS(fit,
        file = "models/fit_brm_mixture.rds",
        compress = "xz")

mcmc_plot(fit, type = "trace", variable = c("^b_", "^sigma"), regex = T)
