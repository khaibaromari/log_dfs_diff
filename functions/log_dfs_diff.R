log_dfs_diff <- function(raw_data, clean_data, uuid_col) {
  # Converting NAs to NA_value
  clean_data[is.na(clean_data)] <- "NA_value"
  raw_data[is.na(raw_data)] <- "NA_value"
  
  # getting intersect of columns that are available in both data sets
  qnames_intersect <- intersect(names(raw_data), names(clean_data))
  clean_data <- clean_data[qnames_intersect]
  raw_data <- raw_data[qnames_intersect]
  
  # getting intersect of 
  ids_intersect <- intersect(raw_data[[uuid_col]], clean_data[[uuid_col]])
  clean_data <- clean_data[clean_data[[uuid_col]] %in% ids_intersect, ]
  raw_data <- raw_data[raw_data[[uuid_col]] %in% ids_intersect, ]
  
  # setting rows arrangement according to first (raw) data set
  clean_data <- clean_data[match(raw_data[[uuid_col]], clean_data[[uuid_col]]), ]
  
  fun <- function(logical_vec, column) return(column[logical_vec])
  uuid <- apply(raw_data != clean_data, 2, fun, raw_data[[uuid_col]])
  
  question_names <- unlist(lapply(uuid, length))
  question_names <- question_names[question_names > 0]
  question.name <- rep(names(question_names), question_names)
  
  uuid <- unlist(uuid)
  old.value <- raw_data[raw_data != clean_data]
  new.value <- clean_data[raw_data != clean_data]
  logs <- data.frame(uuid, question.name, old.value, new.value, row.names = NULL)
  
  # turning NA_value to NA
  logs$new.value[logs$new.value == "NA_value"] <- "NA"
  logs$old.value[logs$old.value == "NA_value"] <- "NA"

  return(logs)
}


