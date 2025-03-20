# Load packages
library(tidyverse)
library(brms)
library(polspline) # <- you might need to install this

# Load posterior from earlier (should still be in your R's memory)
fit_brm <- readRDS(file = "models/fit_brm_with_normalprior.rds")

# Check the priors that were used.
# Task: apply the function below to the model object, you loaded above.
prior_summary(---)

# Find the name of the slope parameter (our parameter of interest)
names(fit_brm$fit)

# but ignore the prefix b_ for the below.
# Calculate BF for the null hypothesis being true
hypothesis(---, "nptypesimple = 0")

# Evid.Ratio and Post.Prob are NA.
# Reason is, we didn't save the prior when fitting the model (panic now!).
# So we have to get our own hands dirty.

# Extract posterior for beta
# Task: complete the name of the slope coefficient
beta <- as_draws_df(fit_brm) %>% pull(---)

# This is described in Nicenboim and Vasishth (2016): to determine the height
# of the posterior at 0 we use logspline:
fit_posterior <- logspline(---) # determine log-density of the beta coefficient
(posterior <- dlogspline(0, ---)) # determine the posterior density at 0 from the fit_posterior object
(prior <- dnorm(0, mean = ---, sd = ---)) # simulate the height of the prior at 0.
# For the last line use the slope prior you saw above in line 11.

# Tada, a Savage Dickey Bayes Factor for the alternative hypothesis vs the null hypothesis
BF10 <- posterior/prior
BF10 # This isn't identical but reasonably close.

# To test the evidence in favour of the null, you can swap numerator and denominator. Try yourself:
BF01 <- --- / ---
BF01

# or do
1 / BF10

# Observe how the BF is sensitive to the prior, certainly in situations when
# the posterior is not much affected by the prior.

# Task 1: change the mean of the prior to 150
prior <- dnorm(0, mean = ---, sd = 100)
prior / posterior

# How did the BF change?
# Are we still testing against the null hypothesis?

# Task 2: change the sd of the prior to 10000
prior <- dnorm(0, mean = 0, sd = ---)
prior / posterior

# How did the BF change?
# The prior is more diffuse and the BF is (10 times) smaller.

# Task 3: change the sd of the prior to 1
prior <- dnorm(0, mean = 0, sd = ---)
prior / posterior

# How did the BF change?
# The prior is very specific. In fact the prior says the effect is something between
# -2 and 2 msecs which is very small. So it's not surprising that the resulting BF
# is massive. It just doesn't make sense :)
