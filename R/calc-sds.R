
# load packages
library(tidyverse)
library(kableExtra)
library(formattable)

# load data
leg_df <- read_rds("data/shor-mccarty.rds") %>%
  filter(chamber == "house") %>%  # keep only house
  filter(party != "X") %>%  # keep only Ds and Rs
  glimpse()  # quick look

# find standard deviation for each party in each party-state-year
sum_df <- leg_df %>%
  group_by(state, party, year) %>%  # set groups at state-party-year
  summarize(sd = sd(ideology, na.rm = TRUE)) %>%  # calculate sd by group
  write_csv("data/sds.csv") %>%  # write to .csv file (for github)
  write_rds("data/sds.rds") %>%  # write to .rds file (for analysis)
  glimpse()  # quick look
