# Load packages
library(tidyverse)
library(brms)
library(bayesplot) # <- might need installation

# Load posterior from earlier (should still be in your R's memory)
fit_brm <- readRDS("models/fit_brm.rda")


# To obtain a list list of every parameter that the model has estimated do:
names(fit_brm$fit)


# You can create an overview of parameter estimates; this is useful for models with many slopes.
# Add the name of the model object.
mcmc_plot(---)


# Here is how much faster or slower each participant was:
mcmc_plot(---, variable = "^r_ppt.*Intercept", regex = TRUE)
# using regular expression for the parameter names obtained above.


# Create a histogram of the posterior of the slope parameter "b_nptypesimple";
# type needs to be "hist" for histogram
mcmc_plot(fit_brm, variable = "---", type = "---")


# Can you create a histogram for the intercept estimate?
# the intercept parameter is called "b_Intercept"
stanplot(fit_brm, variable = "---", type = "---")


# Did the model converge?

# You can create traceplots using the "trace" model type:
mcmc_plot(---, type = "---")

# We're looking for fat hairy caterpillars, anything else is a problem.

# Create traceplots for the intercept and slope parameters:
mcmc_plot(fit_brm, variable = c("---", "---"), type = "---")

# If the chains for a parameter mixed nicely, we would expect that R-hat is smaller than 1.1
brms::rhat(---) # use the name of the model object

# Lets focus the parameters of interest called "b_Intercept" and "b_nptypesimple":
brms::rhat(---, pars = c("---", "---"))


# Compare the posterior predicted data y_rep against the real data y
# In every iteration the model predicted data (given the estimated parameter values).
# For the data from 10 (randomly picked) iterations (i.e. samples).
pp_check(---, nsamples = 10) # use the name of the model object


# Use 100 samples.
pp_check(fit_brm, nsamples = ---)


# Use 500 samples.
pp_check(fit_brm, nsamples = ---)

