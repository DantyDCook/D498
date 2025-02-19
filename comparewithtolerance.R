
compare_with_tolerance_df <- function(dataframe, col1, col2, tolerance, prefer = "higher") {
  # Create an empty column to store the chosen values
  df$chosen_value <- NA
  
  # Loop through each row in the data frame
  for (i in 1:nrow(df)) {
    value1 <- df[i, col1]  # Get the first value
    value2 <- df[i, col2]  # Get the second value
    
    # Check if the values are within the allowed margin of error
    if (abs(value1 - value2) <= tolerance) {
      df$chosen_value[i] <- NA  # Store NA if the difference is within tolerance
    } else {
      # Choose the higher or lower value based on preference
      if (prefer == "higher") {
        df$chosen_value[i] <- max(value1, value2)  # Pick the higher value
      } else {
        df$chosen_value[i] <- min(value1, value2)  # Pick the lower value
      }
    }
  }
  
  return(df)  # Return the updated data frame
}