library(openxlsx)
source("functions/log_dfs_diff.R")

rawData <- read.xlsx("input/dummy_datasets/raw_data.xlsx")
cleanData <- read.xlsx("input/dummy_datasets/clean_data.xlsx")

difference_logs <- log_dfs_diff(rawData, cleanData, "_uuid")
