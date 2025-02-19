library(lubridate)
library(dplyr)

rm(expanded_multi_day_rides_df)
rm(filtered_df)
rm(midnight_df_filtered)
rm(multi_day_rides)
rm(nullendtimes_multi_day_rides)

split_multi_day_rides <- function(dataframe) {
  dataframe %>%
    rowwise() %>%
    mutate(
      days = list(seq(as.Date(start.time), as.Date(end.time), by = "day"))
    ) %>%
    unnest(days) %>%
    mutate(
      start.time = ifelse(
        days == as.Date(start.time), 
        start.time, 
        as.POSIXct(paste0(days, " 00:00:00"), tz = "UTC")
      ),
      end.time = ifelse(
        days == as.Date(end.time), 
        end.time, 
        as.POSIXct(paste0(days, " 23:59:59"), tz = "UTC")
      ),
      day.of.the.week = weekdays(days)
    ) %>%
    ungroup()
}


multi_day_rides$start.time_original <- multi_day_rides$start.time
multi_day_rides$end.time_orginal <- multi_day_rides$end.time

multi_day_rides$start.time <- as.POSIXct(multi_day_rides$start.time, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")
multi_day_rides$end.time <- as.POSIXct(multi_day_rides$end.time, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")

expanded_multi_day_rides_df <- split_multi_day_rides(multi_day_rides)

expanded_multi_day_rides_df$start.time <- as.POSIXct(expanded_multi_day_rides_df$start.time, origin = "1970-01-01", tz = "UTC")
expanded_multi_day_rides_df$end.time <- as.POSIXct(expanded_multi_day_rides_df$end.time, origin = "1970-01-01", tz = "UTC")


View(expanded_multi_day_rides_df)

expanded_multi_day_rides<- subset(expanded_multi_day_rides_df, select = c(location, ride_id, start.time, end.time, month, multi.day, day.of.the.week))

View(expanded_multi_day_rides)

combined_rides_common_timeframes <- rbind(single_day_rides, expanded_multi_day_rides)

View(combined_rides_common_timeframes)
