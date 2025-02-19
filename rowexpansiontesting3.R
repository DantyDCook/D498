expanded_q2_chi <- q2_chi %>%
  
  mutate(
    End.Hour = ifelse(day_change == TRUE, End.Hour == 23, End.Hour)
  ) %>%
  
  filter(day_change == TRUE) %>%
    
  slice(rep(1:n(), 1)) %>%
    
  mutate(
    Start.Hour = ifelse(day_change == TRUE, Start.Hour == 0, Start.Hour)
    End.Hour = ifelse(day_change == TRUE, End.Hour == hour(End.Time), End.Hour)
    day.of.week = weekday(End.Time)
  ) %>%
  bind_rows(q2_chi %>% filter(day_change == FALSE))
