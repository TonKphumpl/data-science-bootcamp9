## find the best hyperparameter that improve model 
## performance

library(tidyverse)
library(caret)
library(mlbench)

data("BostonHousing")
data("PimaIndiansDiabetes")

## review train
clean_df <- mtcars %>%
  # select(mpg, hp, wt, am) %>%
  # median imputation
  mutate(hp = replace_na(hp, 146.68),
         wt = replace_na(wt, 3.21)) %>%
  ## rule of thumb: NA < 3-5%
  drop_na()

## Linear Regression
(lm_model <- train(
  mpg ~ ., 
  data = clean_df,
  method = "lm"
))

## KNN : k-nearest neighbors
## Experimentation
set.seed(42)

# grid search (dataframe)
k_grid <- data.frame(k = c(3,5,7) )

ctrl <- trainControl(
  method = "cv",
  number = 3,
  verboseIter = TRUE # progress bar
)
  
(knn_model <- train(
  mpg ~ ., 
  data = clean_df,
  method = "knn",
  metric = "RMSE",
  trControl = ctrl,
  tuneGrid = k_grid
))

## Random K, 4 values
(knn_model <- train(
  mpg ~ ., 
  data = clean_df,
  method = "knn",
  metric = "RMSE",
  trControl = ctrl,
  tuneLength = 4
))

## save model
## .RDS extension
saveRDS(knn_model, "knnModel.RDS")

## normalization
## 1. min-max (feature scaling 0-1)
## 2. standardization

x <- c(5 ,10 ,12 ,15 ,20)

minmaxNorm <- function(x) {
  (x-min(x)) / ( max(x)-min(x) )
}

# center and scale
# standardization
zNorm <- function(x) {
  (x-mean(x)) / sd(x)
}

## preProcess()
train_df <- mtcars[1:20, ]
test_df <- mtcars[21:32, ]

## compute x_bar, x_sd
tranformer <- preProcess(train_df,
                         method=c("center", "scale"))

## min max scaling [0,1]
tranformer <- preProcess(train_df,
                         method=c("range"))

train_df_z <- predict(tranformer, train_df)
test_df_z <- predict(tranformer, test_df)









