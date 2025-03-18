# Load libraries
library(tidyverse)
library(afex) # for repeated measures ANOVA
library(lme4) # for linear mixed effects models

# Load data
data <- read_csv("data/martin-etal-2010-exp3a.csv")

# Checkout data
glimpse(data)

# The outcome of this script is simple. You should see that a mixed-effects model
# analysis is simpler than the previous repeated measures ANOVA analysis because:
# 1. We don't need to aggregate data.
# 2. We only need one model fit.

# You saw in the previous script how you can translate an ANOVA to a linear mixed
# effects model for by-participant data. Complete the model code below for
# two sources of error, participants and items.

# Model with two random intercepts terms
m_ris <- lmer(rt ~ nptype + ( 1 | --- ) + ( --- | --- ), data = ---)

# Check out the model coefficients
summary(m_ris)$coefficients

