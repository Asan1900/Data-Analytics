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

# Plot 1: Ideal Point vs. Proportion of Votes Agreeing with the United States
plot4.1 <- ggplot(ideal_data, aes(x = PctAgreeUS, y = idealpoint, color = CountryName)) +
  geom_point() +
  labs(
    title = "Ideal Point vs. Proportion of Votes Agreeing with the United States (2012)",
    x = "Proportion of Votes Agreeing with the United States",
    y = "Ideal Point"
  ) +
  theme_minimal() +
  theme(legend.position = "none")  # Optional: Hide legend for clarity

ggsave("plot4.1.jpg", plot4.1, width = 8, height = 6)

# Plot 2: Ideal Point vs. Proportion of Votes Agreeing with the United States with custom colors
plot4.2 <- ggplot(ideal_data, aes(x = PctAgreeUS, y = idealpoint, color = CountryName)) +
  geom_point() +
  labs(
    title = "Ideal Point vs. Proportion of Votes Agreeing with the United States (2012)",
    x = "Proportion of Votes Agreeing with the United States",
    y = "Ideal Point"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom") + 
  scale_color_manual(
    values = rainbow(length(unique(ideal_data$CountryName)))  
  )


ggsave("plot4.2.jpg", plot4.2, width = 8, height = 6)

