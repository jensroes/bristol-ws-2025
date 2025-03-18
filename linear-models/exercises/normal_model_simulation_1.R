# Load library
library(tidyverse)
theme_set(theme_bw()) # set my favourite ggplot theme

# Tasks:
# Run the scripts.
# Then, increase the number of simulated data from 10, 20, 50, 100, 200, 1000
# Observe how the distribution in the histogram is changing.

# Set parameters
n <- 10     # number of simulated data
mu <- 500   # population mean
sigma <- 10 # population standard deviation

# Generate data
x <- rnorm(n = n, mean = mu, sd = sigma)

# Plot data
ggplot(data = NULL, aes(x = x)) +
  geom_histogram()
