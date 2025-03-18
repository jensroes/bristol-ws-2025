# Load libraries
library(tidyverse)
library(lme4) # for linear mixed effects models
library(brms) # for Bayesian inference

# Load data
data <- read_csv("data/martin-etal-2010-exp3a.csv")

# Checkout data
glimpse(data)

# You saw in the previous script how you fit a maximal linear mixed-effects in lme4.
# As a reminder here it is:
fit_lmer <- lmer(rt ~ nptype + ( nptype | ppt ) + ( nptype | item ), data = data)

# Lets repeat this for a Bayesian mixed effects model. Heads up, this will take slighly longer
# to run. All you need to do is to use `brm` instead of `lmer`.
fit_brm <- ---(rt ~ nptype + ( nptype | ppt ) + ( nptype | item ), data = data)

# Check out parameter estimates and 95% probability intervals for
# intercept and nptype slope of the brm model:
fixef(---)

# Lets compare the model coefficients to our lme4 fit:
summary(---)$coefficients # replace "---" with model name

# Also obtain the 95% CIs of the lme4 model
confint(---, parm = c("Intercept", "nptypesimple"))

# Instead of rerunning models, it makes sense to save it for reuse. This saves time
# and is more sustainable.
dir.create("models") # create a directory for brms objects
saveRDS(fit_brm, "models/fit_brm.rds", compress = "xz") # save brms object as RDS file
