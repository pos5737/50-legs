
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

# create a table for Republicans
options(knitr.kable.NA = "")  # show NAs as empty
filter(sum_df, party == "R") %>%  # keep only Rs 
  ungroup() %>%  # unset groups
  select(-party) %>%  # drop party variable
  rename(State = state) %>%  # rename state variable for table
  spread(year, sd) %>%  # put years as columns
  kable(format = "latex", booktabs = TRUE, digits = 2) %>%  # create table 
  kable_styling(latex_options = c("striped", "scale_down")) %>%  # style table
  cat(file = "doc/tabs/republicans-sds.tex")  # write table to file
