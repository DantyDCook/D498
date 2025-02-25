library(dplyr)
library(stringdist)

# Example data
my_streets <- c("Clark St", "Canal St")
osm_streets <- c("Clark Street", "North Canal Street", "Clark Rd")

# Find the best match using string distance
match_streets <- function(street, osm_list) {
  distances <- stringdist::stringdist(street, osm_list, method = "jw")  # Jaro-Winkler distance
  best_match <- osm_list[which.min(distances)]
  return(best_match)
}

# Apply function
matched_results <- sapply(my_streets, match_streets, osm_list = osm_streets)
matched_results




####


library(dplyr)
library(fuzzyjoin)

# Example data frames
df_my <- data.frame(street_name = c("Clark St", "Canal St"))
df_osm <- data.frame(osm_name = c("Clark Street", "North Canal Street", "Clark Rd"))

# Fuzzy join based on string distance
matched_df <- stringdist_left_join(df_my, df_osm, 
                                   by = c("street_name" = "osm_name"), 
                                   method = "jw", 
                                   max_dist = 0.2)  # Adjust threshold as needed

print(matched_df)