.libPaths("C:/Users/jjh99/바탕 화면/capstone_data")
setwd("C:/Users/jjh99/바탕 화면/capstone_data")

data = read.csv("final_data_2.csv")

normalize <- function(x)
{
  return ((x-min(x))/(max(x)-min(x)))
}

head(data)
dim(data) # 1301(행) 608(열)

# normalization 필요한 열만 추출
data_need <- data[, 3:608]

normalize <- function(x)
{
  return ((x-min(x))/(max(x)-min(x)))
}

data_norm <- normalize(data_need)
head(data_norm)

new_data <- cbind(data[, 1:2], data_norm)


# 새로운 csv 파일로 저장(파일명: normalized_2.csv)
write.csv(new_data, file = "normalized_2.csv", row.names = FALSE)