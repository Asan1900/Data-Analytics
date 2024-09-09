library(ggplot2)
library(dplyr)
library(tidyr)

setwd("C:/Users/Admin/Downloads/RTest/")
ideal_data <- read.csv("unvoting.csv")

us_data <- ideal_data %>% filter(CountryAbb == "USA")
russia_data <- ideal_data %>% filter(CountryAbb == "RUS")

median_ideal_point <- tapply(ideal_data$idealpoint, ideal_data$Year, median, na.rm = TRUE)

median_ideal_point_us <- tapply(us_data$idealpoint, us_data$Year, median, na.rm = TRUE)
median_ideal_point_russia <- tapply(russia_data$idealpoint, russia_data$Year, median, na.rm = TRUE)

plot_data_ideals <- data.frame(
  Year = as.integer(names(median_ideal_point)),
  MedianIdealPoint = median_ideal_point,
  IdealPointUS = median_ideal_point_us,
  IdealPointRussia = median_ideal_point_russia
)

plot_result <- ggplot(plot_data_ideals, aes(x = Year)) +
  geom_line(aes(y = IdealPointUS, color = "United States"), linetype = "dashed", linewidth = 1.5) +
  geom_line(aes(y = IdealPointRussia, color = "Russia"), linetype = "dashed", linewidth = 1.5) +
  geom_line(aes(y = MedianIdealPoint, color = "Median Ideal Point"), linewidth = 1.5) +
  labs(
    title = "Evolution of Ideological Positions Over Time",
    x = "Year",
    y = "Ideal Point"
  ) +
  scale_color_manual(values = c("United States" = "blue", "Russia" = "red", "Median Ideal Point" = "green")) +
  theme_minimal()

# Save the plot
ggsave("plot3.1.jpg", plot = plot_result, width = 10, height = 6)
