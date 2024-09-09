
library(ggplot2)
library(dplyr)
library(tidyr)

setwd("C:/Users/Admin/Downloads/RTest/")
ideal_data <- read.csv("unvoting.csv")

# 2 Average percentage

avg_agree_us <- tapply(ideal_data$PctAgreeUS, ideal_data$Year, mean)
avg_agree_russia <- tapply(ideal_data$PctAgreeRUSSIA, ideal_data$Year, mean)

plot_data <- data.frame(Year = names(avg_agree_us),
                        AvgAgreeUS = avg_agree_us,
                        AvgAgreeRussia = avg_agree_russia)

avg_agree_us_df <- data.frame(Year = as.integer(names(avg_agree_us)), AvgAgreeUS = avg_agree_us)
avg_agree_russia_df <- data.frame(Year = as.integer(names(avg_agree_russia)), AvgAgreeRussia = avg_agree_russia)

plot_data <- data.frame(Year = unique(ideal_data$Year))
plot_data <- plot_data %>% 
  left_join(avg_agree_us_df, by = "Year") %>% 
  left_join(avg_agree_russia_df, by = "Year")

# Identify top N
N <- 10  # Adjust N as needed
pro_us_countries <- names(head(sort(avg_agree_us, decreasing = TRUE), N))
pro_russia_countries <- names(head(sort(avg_agree_russia, decreasing = TRUE), N))

# percentage agreement over time
plot_result <- ggplot(plot_data, aes(x = Year)) +
  geom_line(aes(y = AvgAgreeUS, color = "United States"), linewidth = 1.5) +
  geom_line(aes(y = AvgAgreeRussia, color = "Russia"), linewidth = 1.5, linetype = "dashed") +
  labs(
    title = "Average Percentage Agreement Over Time",
    x = "Year",
    y = "Average Percentage Agreement"
  ) +
  scale_color_manual(values = c("United States" = "blue", "Russia" = "red")) +
  theme_minimal()

threshold <- 70
avg_agreement_per_country_us <- tapply(ideal_data$PctAgreeUS, ideal_data$CountryName, mean, na.rm = TRUE)
pro_us_countries <- names(avg_agreement_per_country_us[avg_agreement_per_country_us > threshold])
avg_agreement_per_country_russia <- tapply(ideal_data$PctAgreeRUSSIA, ideal_data$CountryName, mean, na.rm = TRUE)
pro_russia_countries <- names(avg_agreement_per_country_russia[avg_agreement_per_country_russia > threshold])

ggsave("plot2.1.jpg", plot = plot_result, width = 10, height = 6)
# Print 
cat("Top Pro-US Countries (Threshold > 30%): ", paste(pro_us_countries, collapse = ", "), "\n")
cat("Top Pro-Russian Countries (Threshold > 30%): ", paste(pro_russia_countries, collapse = ", "), "\n\n")

print("Average Percentage Agreement with the United States:")
print(avg_agreement_per_country_us)
print(pro_us_countries)

print("Average Percentage Agreement with Russia:")
print(avg_agreement_per_country_russia)
print(pro_russia_countries)

