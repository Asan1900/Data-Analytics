library(ggplot2)
library(dplyr)
library(tidyr)

setwd("C:/Users/Admin/Downloads/RTest/")
ideal_data <- read.csv("unvoting.csv")

soviet_union_countries <- c(
  "Estonia", "Latvia", "Lithuania", "Belarus", "Moldova", "Ukraine",
  "Armenia", "Azerbaijan", "Georgia", "Kazakhstan", "Kyrgyzstan",
  "Tajikistan", "Turkmenistan", "Uzbekistan", "Russia"
)

ideal_data <- ideal_data %>%
  mutate(Group = ifelse(CountryName %in% soviet_union_countries, "Soviet/Post-Soviet", "Other"))

median_ideal_points <- ideal_data %>%
  group_by(Year, Group) %>%
  summarise(MedianIdealPoint = median(idealpoint, na.rm = TRUE), .groups = 'drop')

plot5 <- ggplot(median_ideal_points, aes(x = Year, y = MedianIdealPoint, color = Group)) +
  geom_line(linewidth = 1.5) +
  labs(
    title = "Median Ideological Points Over Time",
    x = "Year",
    y = "Median Ideal Point"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom") +  
  geom_vline(xintercept = 1989, linetype = "dashed", color = "red") +  
  scale_color_manual(values = c("Soviet/Post-Soviet" = "blue", "Other" = "green", "1989" = "red"))

ggsave("plot5.jpg", plot5, width = 8, height = 6)