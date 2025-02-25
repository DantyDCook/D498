load("bikeshare_main_df.RData")

#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 
#### #### #### #### #### #### #### #### 

rider_age_df <- subset(bikeshare_main_df, select = c(location, ride_id, start.time, birth.year))


rider_age_df <- rider_age_df %>% 
  filter(location != "washington") %>% 
  filter(!is.na(birth.year) & birth.year != "") %>% 
  mutate(rider_age = year(start.time) - birth.year)

View(rider_age_df)


overall_rider_age_counts_df <- as.data.frame(table(sort(rider_age_df$rider_age))) %>%
  rename("rider_age" = "Var1" , "count" = "Freq") %>%
  arrange(desc(count))

View(overall_rider_age_counts_df)


outliers_df <- rider_age_df %>% 
  filter(rider_age > 85)

outlier_summary <- paste("Outliers (Age > 85): \n", nrow(outliers_df), "riders")


View(outliers_df)
View(outliner_summary)

ggplot(data = rider_age_df, aes(x = rider_age, fill= location)) +
  geom_bar(position='dodge') +
  theme(text = element_text(size = 15)) +
  scale_x_continuous(
    breaks = seq(15, 85, by = 5),  # Set the breaks
    limits = c(15, 85)  # Set the x-axis limit to 120
  ) +
  scale_y_continuous(
    breaks = seq(0, 15000, 1000)
  ) + 
  labs(x = "Age (Years)", 
       y = "Total Number of Riders", 
       title = "Total Number of Riders Per Age",
       fill = "Location") + 
  annotate("text", x = 85, y = 0, label = outlier_summary, hjust = 1, vjust = -1.5, size = 4, color = "red")



