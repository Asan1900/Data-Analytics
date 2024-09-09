
# 1 Quantiles for 1980 and 2000

# Download if you don't have this library
#install.packages("ggplot2", repos = "http://cran.us.r-project.org")
#install.packages("dplyr", dependencies = TRUE, repos='http://cran.us.r-project.org')

library(ggplot2)
library(dplyr)
library(tidyr)

setwd("C:/Users/Admin/Downloads/RTest/")
ideal_data <- read.csv("unvoting.csv")

data_1980 <- ideal_data[ideal_data$Year == 1980, ]
data_2000 <- ideal_data[ideal_data$Year == 2000, ]

# 1980
ggplot(data_1980, aes(x = idealpoint)) +
  geom_density(fill = "skyblue", alpha = 0.7) +
  geom_vline(aes(xintercept = median(idealpoint)), color = "red", linetype = "dashed") +
  labs(title = "Distribution of State Ideal Points in 1980",
       x = "Ideal Points",
       y = "Density") +
  theme_minimal()

# 2000
ggplot(data_2000, aes(x = idealpoint)) +
  geom_density(fill = "skyblue", alpha = 0.7) +
  geom_vline(aes(xintercept = median(idealpoint)), color = "red", linetype = "dashed") +
  labs(title = "Distribution of State Ideal Points in 2000",
       x = "Ideal Points",
       y = "Density") +
  theme_minimal()

# Calculate quantiles for 1980 and 2000
quantiles_1980 <- quantile(data_1980$idealpoint, c(0.25, 0.5, 0.75))
quantiles_2000 <- quantile(data_2000$idealpoint, c(0.25, 0.5, 0.75))

# Print quantile results
cat(paste("Quantiles for 1980:\n", 
          "25th percentile:", quantiles_1980[1], "\n",
          "Median:", quantiles_1980[2], "\n",
          "75th percentile:", quantiles_1980[3], "\n"),
    "\n")

cat(paste("Quantiles for 2000:\n", 
          "25th percentile:", quantiles_2000[1], "\n",
          "Median:", quantiles_2000[2], "\n",
          "75th percentile:", quantiles_2000[3], "\n"),
    "\n")