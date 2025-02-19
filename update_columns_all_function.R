update_columns <- function(df, start.col.name, end.col.name, prefix = "active_hour.") {
  for (i in 1:nrow(df)) {
    starthour <- df[[start.col.name]][i]
    endhour <- df[[end.col.name]][i]
    
    # Ensure valid range
    if (starthour <= endhour) {
      # Generate the correct range of columns
      columns_to_update <- paste0(prefix, starthour:endhour)
      
      # Update those columns
      df[i, columns_to_update] <- 1
    }
  }
  
  return(df)
}

