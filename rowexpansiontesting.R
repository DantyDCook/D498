install.packages("tidyr")
library(dplyr)
library(tidyr)


rm(expanded_filtered_q2_chi_2)

View(expanded_filtered_q2_chi)
expanded_filtered_q2_chi$number.of.days <- expanded_filtered_q2_chi$number.of.days -1
expanded_filtered_q2_chi$number.of.days <- expanded_filtered_q2_chi$number.of.days +3

# Step 1: Expand the rows based on 'number.of.days'
expanded_filtered_q2_chi_2 <- expanded_filtered_q2_chi %>%
  uncount(number.of.days)%>%
  mutate(
    row_number = rep(1:nrow(number.of.days), length.out = n())
  )# Expands rows by the 'number.of.days' column

# Step 2: Generate row numbers for each row in the expanded data
#expanded_filtered_q2_chi_2 <- expanded_filtered_q2_chi_2 %>%


head(expanded_filtered_q2_chi_2)

View(expanded_filtered_q2_chi_2)

