# Load libraries
library(tidyverse)
library(brms) # for Bayesian inference

# Load data
data <- read_csv("data/martin-etal-2010-exp3a.csv")

# We will use the same random intercepts and random slopes model as before.
# This time, though, we specify the model formula as a separate argument using the
# Bayesian formula function bf(). This is not doing much but create a formula string
# for the model fit later.

formula <- bf(rt ~ nptype + ( nptype | ppt ) + ( nptype | item ))

# However, using this formula object we can view the priors that brms is going to use
# by default:
get_prior(formula, data)

# Some priors have useful defaults.
# What really needs our attention are the priors that are indicated as "(flat)"
# because uninformative priors are not helpful or realistic.
# There is only one "(flat)" prior which is the slope coefficient "b", which also
# happens to be the parameter we are really interested in.
# "b" is listed two times, one as specifically for the "nptype" predictor and one
# time empty coef if a prior is applied to all fixed effects "b" (which doesn't make
# a difference in this case).

# So how do we specify a prior for the slope?
# The `set_prior` function does this job. It needs as input an appropriate
# distribution with the relevant parameters for the class of interest.
# The slope is class "b" and the coefficient is called "nptypesimple".
# As prior we want to use a normal distribution with a mean of 0 msecs and a standard
# deviation of 100 msecs (you need to add these below).

prior <- set_prior("normal(---, ---)", class = "b", coef = "nptypesimple") + # <- complete this
         set_prior("normal(1000, 150)", class = "Intercept") +
         set_prior("lkj(2)", class = "cor")

# Little tangent:
# I've also added two other priors mainly as examples (which you could ignore really).
# 1. I've used a normal distribution on the Intercept with a mean of 1000 msecs and
# a standard deviation of 150 msecs.
# 2. The lkj prior is a prior for correlation coefficients (here the correlation between
# random intercepts and slopes). A value of 1 is essentially flat and gives equal
# probability mass to a correlation of 1 and -1 as for a correlation of 0. Increasing
# this value add slightly more probability mass to 0. I prefer this cause
# correlations of -1 and 1 in this sort of design is really not realisitic.
# (in fact, this is what we found in the lmer fit earlier which is indicates
# ientifiability issues of the parameters if anything).


# Fitting the model:

# There are small changes to the model fit, I want you to make before running
# the code below.

# 1. We can now include the formula object we created above instead of writing
# out the model again.
# 2. We add the priors specified above as argument.
# 3. We save the prior using the `sample_prior` argument. This will be important
# to calculate the evidence ratio later on.

# And finally: The model is running 4 chains by default. These chains are serialised
# which means chain 2 can only start after chain 1 finished it's job. That's a waste of
# time, cause they could in principle run at the same time (in parallel). All you need
# to do, is to tell brm how many cores you have available (on your computer) for those 4 chains.
# So,
# 4. If you have at least 4 cores that brm can use, enter 4 for the `cores` argument. If you have less
# enter a lower number, so the chains can run semi-parallised. If you have more,
# good for you :) You will be able to do other stuff while brm is taking advantage of
# 4 of your cores. There is however no need to use more cores than chains.

# If you don't know how many cores your machine has, do not worry. Run this command
# (you might need to install the "parallel" package):
parallel::detectCores()

# Alright, now complete the code and run it:
fit_with_prior <- brm(formula = ---,
                       data = ---,
                       prior = ---,
                       sample_prior = "yes",
                       cores = ---)

# Lets check traceplots for convergence information for intercept and slope:
mcmc_plot(---,
          variable = c("b_Intercept", "b_nptypesimple"),
          type = "trace")

# And finally, check the estimates for intercept and slope coefficients
fixef(---)

# Save new brms object as RDS file
saveRDS(fit_with_prior, "models/fit_brm_with_normalprior.rds", compress = "xz")

