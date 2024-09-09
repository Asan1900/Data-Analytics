library(ggplot2)
library(dplyr)
library(tidyr)
library(cluster)

setwd("C:/Users/Admin/Downloads/RTest/")
ideal_data <- read.csv("unvoting.csv")

cluster_data <- ideal_data %>%
  select(Year, idealpoint, PctAgreeUS)

cluster_data_1989 <- cluster_data %>% filter(Year == 1989)
cluster_data_2012 <- cluster_data %>% filter(Year == 2012)

k_means_1989 <- kmeans(cluster_data_1989[, c("idealpoint", "PctAgreeUS")], centers = 2)
k_means_2012 <- kmeans(cluster_data_2012[, c("idealpoint", "PctAgreeUS")], centers = 2)

cluster_data_1989$Cluster <- as.factor(k_means_1989$cluster)
cluster_data_2012$Cluster <- as.factor(k_means_2012$cluster)

# Results for 1989
plot6.1 <- ggplot(cluster_data_1989, aes(x = idealpoint, y = PctAgreeUS, color = Cluster)) +
  geom_point() +
  labs(
    title = "K-Means Clustering Results (1989)",
    x = "Ideal Point",
    y = "Proportion of Votes Agreeing with the United States"
  ) +
  theme_minimal()

# Results for 2012
plot6.2 <- ggplot(cluster_data_2012, aes(x = idealpoint, y = PctAgreeUS, color = Cluster)) +
  geom_point() +
  labs(
    title = "K-Means Clustering Results (2012)",
    x = "Ideal Point",
    y = "Proportion of Votes Agreeing with the United States"
  ) +
  theme_minimal()

ggsave("plot6.1.jpg", plot6.1, width = 8, height = 6)
ggsave("plot6.2.jpg", plot6.2, width = 8, height = 6)