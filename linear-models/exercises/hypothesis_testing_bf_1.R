# Load packages
library(tidyverse)
library(brms)

# Load posterior from earlier (should still be in your R's memory)
fit_brm <- readRDS(file = "models/fit_brm_with_normalprior.rds")

# List of everything the model has estimates for (its useful to know what names
# brms is using for our parameters)
names(fit_brm$fit)

# We are only really interested in "b_nptypesimple".

# Let's start with a histogram of the posterior so we know what we're dealing with:
mcmc_plot(fit_brm, variable = "b_nptypesimple", type = "hist")
# As far as our histograom is concerned the nptype effect is somewhere between
# -150 msecs and 50 msecs with a higher posterior probability around 30 msecs.


# Let's test some hypotheses using the hypothesis() function.
# The logic for using the hypothesis() function is as follows.
# Use the name of the parameter in combination with a formula that is expressing
# the hypothesis you want to test, which will involve the symbols "<", ">", and "=".
# So if the name of the slope parameter is "b_slope" and you want to test the hypothesis that
# "b_slope" is 0 (null hypothesis test), you'd state "slope = 0" (I removed the "b_" on purpose).


# Task 1. Test the hypothesis that the difference between nptype conditions (i.e. the slope)
# is equal to zero (null hypothesis).
hypothesis(fit_brm, "---")
# The Bayes Factor is called Evid.Ratio (evidence ratio) in the output.


# 2. Test the hypothesis that the nptype effect is smaller than zero.
hypothesis(fit_brm, "---")


# 3. Test the hypothesis that the nptype effect is smaller than -10 msecs
# (a difference of -1 msecs is in principle akin to 0 so we might as well be
# more conservative).
hypothesis(fit_brm, "---")


# You can visualise how the height of the prior density at zero compares to
# the height of the posterior density.

# To do so, create an hypothesis object for any hypothesis from before:
h <- hypothesis(fit_brm, "---")

# Task: pass the hypothesis object to plot()
plot(---)


# Aside, Post.Prob in the hypothesis output is the posterior probability
# which is calculated like this:
beta <- as_draws_df(fit_brm) %>% pull(b_nptypesimple) # extract beta
mean(beta < 0) # for the hypothesis that the slope is < 0
# similar to what you did in the last script.
