# Load libraries
library(tidyverse)
library(brms) # for Bayesian inference

# Load data
data <- read_csv("data/martin-etal-2010-exp3a.csv")

# We will use the same random intercepts and random slopes model as before.

formula <- bf(rt ~ nptype + ( nptype | ppt ) + ( nptype | item ), family = shifted_lognormal())

# However, using this formula object we can view the priors that brms is going to use
# by default:
get_prior(formula, data)

# Important the priors are no longer on the msecs scale but are log-msecs


prior <- set_prior("normal(0, .1)", class = "b", coef = "nptypesimple") + # <- complete this
         set_prior("normal(6.9, 0.14)", class = "Intercept") +
         set_prior("lkj(2)", class = "cor")


# Fitting the model:

fit <- brm(formula = formula,
           data = data,
           prior = prior,
           sample_prior = "yes",
           cores = 4)


# Save new brms object as RDS file
saveRDS(fit, "models/fit_brm_shifted_lognormal.rds", compress = "xz")

