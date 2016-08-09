library(data.table)
library(car)

recoderFunc <- function(data, oldvalue, newvalue) {
  # convert any factors to characters
  if (is.factor(data))     data     <- as.character(data)
  if (is.factor(oldvalue)) oldvalue <- as.character(oldvalue)
  if (is.factor(newvalue)) newvalue <- as.character(newvalue)
  # create the return vector
  newvec <- data
  # put recoded values into the correct position in the return vector
  for (i in unique(oldvalue)) newvec[data == i] <- newvalue[oldvalue == i]
  newvec
}

features <- fread("./UCI_HAR_Dataset/features.txt")
feature_names <- features$V2

descriptive_labels <- fread("./UCI_HAR_Dataset/activity_labels.txt")

#train data
train_subjects <- fread("./UCI_HAR_Dataset/train/subject_train.txt")
names(train_subjects) <- "subject_number"

train_labels <- fread("./UCI_HAR_Dataset/train/y_train.txt")
names(train_labels) <- "labels"
train_labels <- recoderFunc(train_labels, descriptive_labels$V1, descriptive_labels$V2)

train_data <- fread("./UCI_HAR_Dataset/train/X_train.txt")
train_old_names <- names(train_data)
setnames(train_data, old = train_old_names, new = feature_names)
train_data <- subset(train_data, select = grep("(mean|std)([^Freq])", names(train_data)))

train <- cbind(train_subjects, train_labels, train_data)

#test data
test_subjects <- fread("./UCI_HAR_Dataset/test/subject_test.txt")
names(test_subjects) <- "subject_number"

test_labels <- fread("./UCI_HAR_Dataset/test/y_test.txt")
names(test_labels) <- "labels"
test_labels <- recoderFunc(test_labels, descriptive_labels$V1, descriptive_labels$V2)

test_data <- fread("./UCI_HAR_Dataset/test/X_test.txt")
test_old_names <- names(test_data)
setnames(test_data, old = test_old_names, new = feature_names)
test_data <- subset(test_data, select = grep("(mean|std)([^Freq])", names(test_data)))

test <- cbind(test_subjects, test_labels, test_data)

data <- rbind(train, test)

library(dplyr)
groupData <- data %>%
  group_by(subject_number, labels) %>%
  summarise_each(funs(mean))

write.csv(data,file = "clean_data.csv")
write.csv(groupData,file = "average_data.csv")