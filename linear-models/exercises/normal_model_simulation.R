# Load library
library(tidyverse)
library(emmeans)

# Tasks:
# Go through and complete the script
# Observe how the coefficients are changing.
# Change beta_1 to 200. Which model coefficient uncovers beta_1?

# Set parameter values
n <- 1000      # number of simulated data
beta_0 <- 600  # population average
beta_1 <- 30   # population change in the outcome variable
sigma <- 50    # population standard deviation

# Generate data
sim_data <- tibble(group_1 = rnorm(n = n/2,
                                  mean = ---, # needs to be the population average
                                  sd = sigma),
                   group_2 = rnorm(n = n/2,
                                  mean = beta_0 + beta_1,
                                  sd = ---)) # needs to be the standard deviation

# Preview data
glimpse(---)

# Transform data
sim_data <- pivot_longer(sim_data,
                         cols = c(group_1, group_2),
                         names_to = "x",
                         values_to = "y")

# Preview data
glimpse(---)
# Make sure you understand how the transformation affected the data frame.

# Normal linear model of simulated data
model <- lm(--- ~ ---, data = sim_data)

# Model coefficients
coef(---)

# Standard deviation
sigma(---)

