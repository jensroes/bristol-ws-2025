# Load libraries
library(tidyverse)
library(afex) # for repeated measures ANOVA
library(lme4) # for linear mixed effects models

# Load data
data <- read_csv("data/martin-etal-2010-exp3a.csv")

# Checkout data
glimpse(data)

# For repeated measures ANOVA, people often do a by-participant analysis, or both
# a by-participant and by-items analsysis.

# First, we need to summarise the data by participants
data_ppt <- summarise(data, rt = mean(rt), .by = c(nptype, ppt))

# Convince yourself that each participant has now two rts, one for each nptype
arrange(data_ppt, ppt)

# Second, we fit a repeated measures ANOVA with ppt as error term
m_aov_ppt <- aov_car(rt ~ Error(ppt/nptype), data = data_ppt)

# Check out if there is evidence for an effect
summary(m_aov_ppt)

# Now we repeat the same but we perform a by-items analysis.
# But you have to complete the code:

# First, we need to summarise the data by items
data_item <- summarise(data, rt = mean(---), .by = c(---, ---))

# Convince yourself that each item has now two rts, one for each nptype
arrange(data_item, ---)

# Second, we fit a repeated measures ANOVA with item as error term
m_aov_item <- aov_car(rt ~ Error(--- / ---), data = ---)

# Check out if there is evidence for an effect
summary(---)

# Aside, we can obtain the same result using a mixed effects model:
m_lmer_ppt <- lmer(rt ~ nptype + (1|ppt), data = data_ppt)

# Compare the result of likelihood ratio test of this lmer model
anova(---)

# to the summary of our by-participants repeated-measures ANOVA:
summary(---)

# You should observe that these two provide identical results.

# Well, that was a lot of work, wasn't it. Now let's see how the by-participants
# and by-items analysis can be simplified in a mixed-effects model context:
# see script mixed_effects_model.R
