library(tidyverse)
library(caret)
library(mlbench)
library(MLmetrics)

churn <- read.csv("churn.csv")

head(churn)

## explore dataset
glimpse(churn)

## no missing values
mean(complete.cases(churn))

## Split clean_churn
n <- nrow(churn)
id <- sample(1:n, size=0.8*n)
train_df <- churn[id, ]
test_df <- churn[-id, ]

## preProcess : Normalization
transformer <- preProcess(train_df,
                         method=c("range"))

train_df_z <- predict(transformer, train_df)
test_df_z <- predict(transformer, test_df)

## Train model
## KNN : k-nearest neighbors
myGrid <- data.frame(k = 1:10)
set.seed(49)

ctrl <- trainControl(method="cv", 
                     number=5,
                     ## pr = precision + recall
                     summaryFunction = prSummary,
                     classProbs = TRUE)
  
knn_model <- train(churn ~ .,
                   data = train_df_z,
                   tuneGrid = myGrid,
                   method = "knn",
                   metric = "AUC",
                   trControl = ctrl)

logis_model <- train(churn ~ .,
                     data = train_df_z,
                     method = "glm",
                     metric = "AUC",
                     trControl = ctrl)

## Scoring Churn
pred_knn <- predict(knn_model, newdata = test_df_z)
pred_logis <- predict(logis_model, newdata = test_df_z)

## Evaluate Model
pred_knn <- factor(pred_knn, levels=c("No","Yes"), labels=c(0, 1))
pred_logis <- factor(pred_logis, levels=c("No","Yes"), labels=c(0, 1))
test_df_z$churn <- factor(test_df_z$churn, levels=c("No","Yes"), labels=c(0, 1))

## Confusion Matrix
ConM_knn <- confusionMatrix(pred_knn, 
                            test_df_z$churn, 
                            positive="1",
                            mode="prec_recall")

ConM_logis <- confusionMatrix(pred_logis, 
                              test_df_z$churn, 
                              positive="1",
                              mode="prec_recall")

  
