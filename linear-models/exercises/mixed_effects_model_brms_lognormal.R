# Load libraries
library(tidyverse)
library(brms) # for Bayesian inference

# Load data
data <- read_csv("data/martin-etal-2010-exp3a.csv")

# We will use the same random intercepts and random slopes model as before except,
# we now use lognormal as distribution family. That's the only change.
formula <- bf(rt ~ nptype + ( nptype | ppt ) + ( nptype | item ), family = lognormal())

# However, it's important to notice that we have to think about the parameter value
# slightly different from before. For example, check the prior mean on the intercept:
get_prior(formula, data)

# This value is very different from the mean of the rt distribution
mean(data$rt)
# as in *very* different. That's because the model now thinks in terms of log scale.
# The mean of the intercept prior is the mean of the log rt:
mean(log(data$rt))

# Useful to know here is that the exp() is the the opposite of the log(), so to convert
# from log values back to msecs you can do
exp(6.9) # in msecs

# This is how we have to think about values for priors which isn't quite simple for slopes.

# For example, if we have an intercept of 6.9 and a slope value of 0.5, this would render a
# difference of
exp(6.9 + 0.5) - exp(6.9) # msecs
# which is massive.

# What would this be for a log slope of 0.25?
exp(6.9 + 0.25) - exp(6.9) # msecs

# In the Gaussian model before we used 100 msecs as SD for our prior. What would that
# on the log scale
log(100 + exp(6.9)) - 6.9
# So lets use 0.1 as prior for the SD too keep our models similar

prior <- set_prior("normal(0, 0.1)", class = "b", coef = "nptypesimple") + # <- complete this
         set_prior("normal(6.9, 0.14)", class = "Intercept") +
         set_prior("lkj(2)", class = "cor")


# Fitting the model:

fit <- brm(formula = formula,
           data = data,
           prior = prior,
           sample_prior = "yes",
           cores = 4)


# Save new brms object as RDS file
saveRDS(fit, "models/fit_brm_lognormal.rds", compress = "xz")

