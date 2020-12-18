.libPaths("C:/Users/jjh99/바탕 화면/capstone_data")
setwd("C:/Users/jjh99/바탕 화면/capstone_data")

data = read.csv("normalized_2.csv", encoding = "utf-8")

data$총_매출_로그 <- log(data$총_매출_금액)

data <- data[, -2]

head(data)

# 새로운 csv 파일로 저장(파일명: normalized_2.csv)
write.csv(data, file = "log_2.csv", row.names = FALSE)
