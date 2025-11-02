install.packages("randomForest")
install.packages("dplyr")       
# importing package    
library(randomForest)
library(dplyr)
# reading data set

data <- read.csv("formula1_dataset.csv")
data$tyre_type <- as.factor(data$tyre_type)

set.seed(42)
sample_idx <- sample(1:nrow(data), 0.8 * nrow(data))
train_data <- data[sample_idx, ]
test_data <- data[-sample_idx, ]

model <- randomForest(as.factor(win) ~ ., data = train_data, ntree = 100)
print(model)

new_car <- data.frame(
  tyre_degradation = 35,
  track_temp = 42,
  fuel_level = 30,
  driver_performance = 8.5,
  team_strategy_score = 9,
  tyre_type = factor("Soft", levels = c("Soft", "Medium", "Hard")),
  laps_remaining = 15,
  pit_stop_count = 1
)

prediction <- predict(model, newdata = new_car, type = "prob")

cat("=============================================\n")
cat("Formula One Car Winning Chance Prediction\n")
cat("=============================================\n")
cat("Winning Probability:", round(prediction[2] * 100, 2), "%\n")
cat("Losing Probability :", round(prediction[1] * 100, 2), "%\n")
