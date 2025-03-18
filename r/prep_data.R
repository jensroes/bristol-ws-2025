# Load packages
library(tidyverse)

# Get file names
file <- list.files(path = "data", pattern = "Martin", full.names = T)

# process data
read_csv(file) %>%
  filter(Exp == "3a") %>%
  mutate(nptype = recode(structure, complex = "conjoined")) %>%
  select(item, ppt = subj, rt = onset, nptype) %>%
  drop_na() %>%
  write_csv("data/martin-etal-2010-exp3a.csv")
