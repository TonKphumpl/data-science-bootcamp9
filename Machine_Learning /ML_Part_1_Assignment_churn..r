library(tidyverse)
library(caret)
library(mlbench)
library(MLmetrics)

churn <- read.csv("churn.csv")

## Preview data
head(churn)

## 1. Split data
Split_data <- function(df, size=0.8) {
  n <- nrow(df)
  train_id <- sample(1:n, 0.8*n)
  train_df <- df[train_id, ]
  test_df <- df[-train_id, ]
  return( list(train_df, test_df) )
} 

prep_df <- Split_data(churn, size=0.8)

## 2. train model
Resampling_ctrl <- trainControl(method = "cv",
                                number = 10)

train_data <- train(churn ~ totaldayminutes + totaldaycalls + totalnightminutes + totalnightcalls,
                          data = prep_df[[1]],
                          method = "glm",
                          trControl = Resampling_ctrl)

## 3. score model
pred_data <- predict(train_data, newdata=prep_df[[2]])

## 4. Evaluate model
actual_churn <- prep_df[[2]]$churn

accuracy <- mean(pred_data == actual_churn)
