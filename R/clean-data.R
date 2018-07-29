
# load packages
library(tidyverse)
library(haven)

# load raw data
leg_df_raw <- read_dta("data/raw/shor_mccarty_1993-2016_individual_legislator_data_May_2018_release_(Updated_July_2018).dta")

# clean data
leg_df <- leg_df_raw %>%
  # convert chamber-year indicator variables into a single variable
  gather(chamber_year, observation, senate1993:house2016) %>%
  # drop legislators who don't appear if they don't appear in a champter-year
  filter(!is.na(observation)) %>%
  # separate the chamber-year colum into separate chamber and year
  # variables, see https://stackoverflow.com/questions/45591387/tidyr-separate-column-values-into-character-and-numeric-using-regex
  separate(chamber_year, 
           into = c("chamber", "year"), 
           sep = "(?<=[a-z])(?=[0-9])") %>%
  # keep only needed variables
  select(state = st, chamber, year, party, name, ideology = np_score) %>%
  mutate(year = as.numeric(year)) %>%
  # quick check
  glimpse() %>%
  # write cleaned data set to .csv (for github)
  write_csv("data/shor-mccarty.csv") %>%
  # write cleaned data set to .rds (for computing)
  write_rds("data/shor-mccarty.rds")

  