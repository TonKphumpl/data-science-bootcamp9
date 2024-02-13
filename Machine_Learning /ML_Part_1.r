library(tidyverse)

library(caret)

## preview data
head(mtcars)

## 1. split data
train_test_split <- function(data, size=0.8) {
    set.seed(42)
    n <- nrow(data) # จำนวน Row or Datapoints
    train_id <- sample(1:n, size*n)
    train_df <- data[train_id, ]
    test_df <- data[-train_id, ]
    return( list(train_df, test_df) )
}

prep_df <- train_test_split(mtcars, size=0.8)
# prep_df[[1]] = train data
# prep_df[[2]] = test data

## 2. train model
## cv stands for K-Fold CV
train_control <- trainControl(method ="cv",
                              number = 5)
	# method : bootstrap
			trainControl(method ="boot",
                   number = 25)
	# method : Leave one out CV
			trainControl(method ="LOOCV")
	# method : K-Fold Validation
			trainControl(method ="cv",
                   number = 5)

model <- train(mpg ~ hp + wt+ am,
               data = prep_df[[1]],
               method = "lm",
               trControl = train_control)

## 3. score model
pred_mpg <- predict(model, newdata=prep_df[[2]])

## 4. evaluate model
actual_mpg <- prep_df[[2]]$mpg

## error = actual - prediction
test_mae <- mean(abs(pred_mpg - actual_mpg))
test_rmse <- sqrt(mean((pred_mpg - actual_mpg)**2))

print(test_mae) # Mean Absolute Error
print(test_rmse) # Root Mean Square Error
