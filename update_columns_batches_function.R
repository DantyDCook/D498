update_columns_batches <- function(df, start.col.name, end.col.name, prefix = "active_hour.", batch_size = 100) {
  
  total_rows <- nrow(df)
  
  for (batch_start in seq(1, total_rows, by = batch_size)) {
    batch_end <- min(batch_start + batch_size - 1, total_rows)
  
    for (i in batch_start:batch_end) {
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
  }
  return(df)
}
