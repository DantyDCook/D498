corrected_trip_duration <- function(dataframe, starttimecolumn, endtimecolumn, durationcolumn) {
  
  dataframe$calculated_duration <- round(as.numeric(difftime(dataframe[[endtimecolumn]], dataframe[[starttimecolumn]], units = "secs")))
  
  dataframe$corrected_duration <- round(dataframe[[durationcolumn]])
  
  dataframe$adjusted_duration <- ifelse(abs(dataframe$calculated_duration - dataframe$corrected_duration) <= 1, 
                                        dataframe$corrected_duration, dataframe$calculated_duration)
  
  return(dataframe)
}
