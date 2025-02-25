expand_time <- function(start, end, id) {
  start_hour <- as.POSIXct(format(start, "%Y-%m-%d %H:00:00"))  # Round Start.Time down to hour
  end_hour <- as.POSIXct(format(end, "%Y-%m-%d %H:00:00"))      # Round End.Time down to hour
  data.frame(ID = id, Hour = seq(start_hour, end_hour, by = "hour"))  # Generate hourly rows
}

# Apply this function to all rows in the dataset
