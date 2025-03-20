# Load packages
library(brms)
library(tidyverse)

# In this script we will see how to use leave-one-out cross-validation to
# compare models.

# To load models you need to remember what names you gave them:
dir("models")

# Load models using readRDS

# Load the Gaussian (normal) model:
fit_gaussian <- readRDS("models/fit_brm_with_normalprior.rds")

# Load the model with the lognormal distribution:
fit_lognormal <- readRDS("models/---")

# Load the model with the shifted lognormal distribution:
fit_shifted_lognormal <- readRDS("models/---")

# You can use loo to compare models:
# Task: Compare the gaussian and the lognormal models by adding the names as defined above:
loo(fit_gaussian, ---)

# These are the fit statistics. On the bottom is the *model comparison*.
# elpd_diff is the difference between your models with the better model in the first row
# and the worse model on the bottom row. A negative difference means that a model
# has a lower predictive performance relative to a reference model.
# So which model did better: ---

# Compare all models using leave-one-out cross validation.
# Task: there is one model missing in the call below.
model_comparisons <- loo(fit_gaussian, fit_lognormal, ---)

# Fit statistic for shifted lognormal might be too optimisitc.
# There is no need to refit the model though as its performance isn't different
# from the simpler lognormal model anyway.

# You can extract the differences from the model_compparisons object
---$diffs

# You can also extract the other stats (though elpd is related to looic; the latter
# is useful for if you're used to reporting deviance statistics).
model_comparisons$diff %>% as.data.frame() %>% round()

# You can also get all pairwise model comparisons of the leave-one-out information criteria
---$ic_diffs__

# ... and covert them to the elpd scale cause elpd = -looic / 2.
# Implement this formula:
- --- / --- # is elpd_diff of lognormal and gaussian
--- / --- # its SE (no minus is needed here)

# For all values you can do this:
model_comparisons$ic_diffs__ %>%
  as.data.frame() %>%
  mutate(across(LOOIC, ~ - . / 2),
         across(SE, ~ . / 2)) %>%
  rename_with(.fn = ~str_replace(., "LOOIC", "elpd_diff"))

# Save comparisons so you don't need to run it again.
saveRDS(model_comparisons, "models/model_comparison.rda")

# You might prefer a csv table you can open in excel with all the important bits.
# Here you go:
model_comparisons_df <- model_comparisons$diff %>% as.data.frame()
write_csv(model_comparisons_df, "models/model_comparison.csv")
# This will not store all information that was contained in `model_comparisons`


# Lastly if you're wondering about "statistical significance" between the
# best and second best model you can think of the differences between models
# as being normal distributed.
# If the distribution of the difference and its standard error doesn't contain 0,
# it's different from the reference model.

# For example, the difference between the normal and the lognormal model was -77.3 (SE = 22.2).
# Your values might be slightly different.
# We want to know to what extent the distribution of this difference includes 0.

# We can simulate n values from a normal distribution and calculate the proportion of values
# that is on the other side of 0.
n <- 1e5
diff <- rnorm(n, -77.3, 22.2) # simulate values

# Plot the simulated differences
ggplot(data = NULL, aes(x = diff)) +
  geom_histogram() +
  geom_vline(xintercept = 0, linetype = "dotted", colour = "red") +
  labs(x = "Difference in elpd between models") +
  theme_bw()

# Important is to what extent the distribution overlaps with the dotted line.

# On the basis of this we can calculate the proportion of differences that are
# on the right side of the dotted line.
mean(diff > 0)
# Which is the probability that elpd favours the more parsimonious model.

# Or calculate the probability that elpd favours the more complex model.
mean(--- < 0)

# Also, we can use the difference in elpd expressed in SEs (this is similar to a
# z-score where values more extreme than 2 are generally considered "significant").
abs(-77.3 / ---)
# which indicates the distance between models expressed in standard errors

# Task: Repeat these tests for the difference between the lognormal and the shifted lognormal model.

# Simulate n values from a normal distribution and calculate the proportion of values
# that is on the other side of 0.
diff <- rnorm(n, ---, ---)

# Plot histogram of simulated differences
ggplot(data = NULL, aes(x = diff)) +
  geom_histogram() +
  geom_vline(xintercept = 0, linetype = "dotted", colour = "red") +
  labs(x = "Difference in elpd between models") +
  theme_bw()

# Calculate the proportion of values that have a difference larger than 0.
mean(---)

# Calculate the difference in elpd expressed in SEs
abs(--- / ---)

