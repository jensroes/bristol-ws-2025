# Preamble ----------------------------------------------------------------
# For demo purposes please restart your RSession:
# From the menu click on: Session > Restart R


# Actual exercise is starting here ----------------------------------------
# Load libraries
library(tidyverse)
library(lme4) # for linear mixed effects models

# Load data
data <- read_csv("data/martin-etal-2010-exp3a.csv")

# Checkout data
glimpse(data)

# You saw in the previous script how you fit a linear mixed-effects model with
# random intercepts for participants and items. Complete the model below by
# adding by-participants and by-items random slopes for np type

# Model with two random intercepts terms
m_rirs <- lmer(rt ~ nptype + ( --- | --- ) + ( --- | --- ), data = data)
# Hint: the random intercepts term is on the right of "|" and the random
# slopes term is on the left of "|"

# Check out the model coefficients. You will see that by default there is no
# p-value associated with the nptype effect
summary(---)$coefficients # replace "---" with model name

# There are different ways to run null-hypothesis significance tests on the basis
# of this model:

# Obtain a significance test using a likelihood ratio test:
# Is the variance accounted for by the fixed effect nptype more than
# relative to a model with random effects only.
# Fit another random effects model with random effects only that is nested in
# the model with the fixed effect above:
m_null <- lmer(rt ~ 1 + ( --- | --- ) + ( --- | --- ), data = data)

# Compare both models using a likelihood ratio test
anova(---, ---) # add both model names starting with the simpler (i.e. the nested) model

# Add p-values using the Satterthwaite's approximation for degrees of freedom
# check ?lmerTest for reference
library(lmerTest) # load library

# Rerun model
m_rirs <- lmer(rt ~ nptype + ( --- | --- ) + ( --- | --- ), data = data)

# Check out the model coefficients again
summary(---)$coefficients # et voila! you got your p-value for the nptype effect

# Obtain the 95% confidence interval for nptype
confint(---, parm = "nptypesimple", level = .95) # replace "---" with model name

# Obtain the 99% confidence interval for nptype
confint(---, parm = "nptypesimple", level = ---) # what does the level need to be for 99% CIs?

# It is useful to understand what the random effects coefficients represent.
# Have a look at the estimates for the random effects, represented in the variance co-variance matrix
summary(m_rirs)$varcor

# One way to understand what's going on is to plot the random effects.

# Let's start with the random effects for participants:

# Extract the random effects for participants
ranef(m_rirs)$ppt # this is what we're going to use

# Create a data frame
rirs_ppt <- ranef(m_rirs)$ppt %>%
  as_tibble() %>%
  rename(nptype = nptypesimple) %>%
  rownames_to_column("ppt") %>%
  pivot_longer(-ppt, names_to = "fe")

# Plot for participant random intercepts and random slopes
ggplot(rirs_ppt, aes(y = reorder(ppt, value), x = value)) +
  geom_point(position = position_dodge(.25)) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  facet_wrap( ~ fe, scales = "free_x") +
  labs(y = "Participants",
       x = "Random effects") +
  theme_bw()

# It looks like overall slower participants have the larger np-type effects
# (shorter rts for simple than conjoined NPs) and faster participants have the
# have smaller effects.

# Can you create a similar plot for the random effects of items?
