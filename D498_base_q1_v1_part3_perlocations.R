process_active_hours_per_location <- function(dataframes) {
  # Reshape and process the data
  dataframes_processed <- dataframes %>%
    # Reshape from wide to long format
    pivot_longer(cols = starts_with("active_hour"),
                 names_to = "hour", 
                 values_to = "active",
                 names_prefix = "active_hour.") %>%
    # Convert hour to numeric
    mutate(hour = as.numeric(hour)) %>%
    # Filter only active hours (active == 1)
    filter(active == 1) %>%
    # Group by day of the week and hour, then count total active users
    group_by(location, day.of.the.week, hour) %>%
    summarise(total_active_users = n(), .groups = "drop")
  
  # Return the processed dataframe
  return(dataframes_processed)
}


sunday_crct_processed_df_per_location <- process_active_hours_per_location(sunday_crct_df)

monday_crct_processed_df_per_location <- process_active_hours_per_location(monday_crct_df)

tuesday_crct_processed_df_per_location <- process_active_hours_per_location(tuesday_crct_df)

wednesday_crct_processed_df_per_location <- process_active_hours_per_location(wednesday_crct_df)

thursday_crct_processed_df_per_location <- process_active_hours_per_location(thursday_crct_df)

friday_crct_processed_df_per_location <- process_active_hours_per_location(friday_crct_df)

saturday_crct_processed_df_per_location <- process_active_hours_per_location(saturday_crct_df)


peak_users_dow_crct_processed_df_per_location <- rbind(sunday_crct_processed_df_per_location, monday_crct_processed_df_per_location)

peak_users_dow_crct_processed_df_per_location <- rbind(peak_users_dow_crct_processed_df_per_location, tuesday_crct_processed_df_per_location)

peak_users_dow_crct_processed_df_per_location <- rbind(peak_users_dow_crct_processed_df_per_location, wednesday_crct_processed_df_per_location)

peak_users_dow_crct_processed_df_per_location <- rbind(peak_users_dow_crct_processed_df_per_location, thursday_crct_processed_df_per_location)

peak_users_dow_crct_processed_df_per_location <- rbind(peak_users_dow_crct_processed_df_per_location, friday_crct_processed_df_per_location)

peak_users_dow_crct_processed_df_per_location <- rbind(peak_users_dow_crct_processed_df_per_location, saturday_crct_processed_df_per_location)

ggplot(peak_users_dow_crct_processed_df_per_location, aes(x = hour, y = total_active_users, color = location)) +
  geom_line() +
  labs(x = "Hour of the Day", y = "Total Active Users", title = "Active Users by Hour and Location") +
  scale_x_continuous(breaks = 0:23) + 
  theme_minimal()


ggplot(peak_users_dow_crct_processed_df_per_location, aes(x = hour, y = total_active_users, color = location)) +
  geom_line() +
  labs(x = "Hour of the Day", y = "Total Active Users", title = "Active Users by Hour, Location, and Day of the Week") +
  scale_x_continuous(breaks = 0:23) + 
  theme_minimal() +
  facet_wrap(~ day.of.the.week)

peak_users_dow_crct_processed_df_per_location <- peak_users_dow_crct_processed_df_per_location %>%
  mutate(day.of.the.week = factor(day.of.the.week, 
                                  levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")))



ggplot(peak_users_dow_crct_processed_df_per_location, aes(x = hour, y = total_active_users, color = location)) +
  geom_line() +
  labs(x = "Hour of the Day", y = "Total Active Users", title = "Active Users by Hour, Location, and Day of the Week") +
  scale_x_continuous(breaks = 0:23) + 
  theme_minimal() +
  # One Column Layout - USE ONE ONLY
  facet_wrap(~ day.of.the.week, ncol = 1)
  # One Row Layout - USE ONE ONLY
  #facet_wrap(~ day.of.the.week, nrow = 1)
