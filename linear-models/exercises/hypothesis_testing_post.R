# Load packages
library(tidyverse)
library(brms)

# Load posterior from earlier (should still be in your R's memory)
fit_brm <- readRDS(file = "models/fit_brm_with_normalprior.rds")

# List of everything the model has estimates for (its useful to know what names
# brms is using for our parameters)
names(fit_brm$fit)

# Extract slope parameter beta (difference between groups)
beta <- as_draws_df(fit_brm) %>% pull(b_nptypesimple)

# Number of posterior samples
length(beta)

# Check histogram of beta
ggplot(data = NULL, aes(x = beta)) + geom_histogram()

# Calculate posterior mean
mean(---)

# Calculate 95% probability interval
quantile(beta, probs = c(.025, .975))

# Calculate 100% probability interval
quantile(beta, probs = c(---, ---))

# Short cuts
posterior_summary(beta)

posterior_summary(beta, robust = TRUE) # Median

posterior_summary(beta, probs = c(.005, .995)) # 99% PI

# Summarise the posterior of beta with the median AND the 89% PI
posterior_summary(beta, ---, ---)

# Calculate the posterior probability that the parameter value is ...
# negative (smaller than zero)
mean(beta < 0)

# positive (larger than zero)
mean(beta ---)

# smaller than 5
mean(---)

# Aside, this works cause beta < 0 turns beta into TRUEs (smaller than zero) and FALSEs (not smaller than zero)
# and mean() returns the proportion of TRUEs; 3 out of 4 in this:
mean(c(TRUE, TRUE, FALSE, TRUE))

