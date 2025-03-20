# Load libraries
library(tidyverse)
library(brms) # for Bayesian inference

# In this script we will fit a lognormal model with shift to account for
# the non-decision time in responses

# Load data
data <- read_csv("data/martin-etal-2010-exp3a.csv")

# We will use the same random intercepts and random slopes model as before but
# the family needs to be changed to shifted_lognormal():
formula <- bf(rt ~ nptype + ( nptype | ppt ) + ( nptype | item ), family = ---)

# Using this formula object we can view the priors that brms is going to use
# by default. These are largely similar to the lognormal model but we have a new
# parameter of class ndt (non-decision time) with a uniform distribution that ranges from
# 0 to the minimum value of the outcome variable.
get_prior(---, ---)

# A uniform prior (all values are equally likely) is probably never a good choice,
# but we'll leave it for now.

# Other than that, lets use the same priors as for the lognormal model.
prior <- set_prior("normal(---, ---)", class = "b", coef = "---") + # <- complete this
         set_prior("normal(6.9, 0.14)", class = "---") +
         set_prior("lkj(2)", class = "---")


# Fitting the shifted lognormal model:
fit <- brm(formula = ---,
           data = data,
           prior = ---,
           sample_prior = "yes",
           cores = ---)


# Save new brms object as RDS file
saveRDS(---, "models/fit_brm_shifted_lognormal.rds", compress = "xz")

