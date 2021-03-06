
# load packages
library(tidyverse)

# load data set
sds_df <- read_rds("data/sds.rds") %>%
  glimpse()

# plot the SD for each party across time in each state
gg <- ggplot(sds_df, aes(x = year, y = sd, color = party)) +
  facet_wrap(~ state) +
  geom_line() + 
  theme_bw()

# save plot
ggsave(filename = "doc/figs/sds.pdf", plot = gg, height = 10, width = 10)

# see https://github.com/tidyverse/ggplot2/issues/2787
if(file.exists("Rplots.pdf")) {
  file.remove("Rplots.pdf")  
}
