process_active_hours <- function(dataframes) {
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
    group_by(day.of.the.week, hour) %>%
    summarise(total_active_users = n(), .groups = "drop")
  
  # Return the processed dataframe
  return(dataframes_processed)
}
