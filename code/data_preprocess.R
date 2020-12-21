#.libPaths("C:/Users/jjh99/바탕 화면/capstone_data")
#setwd("C:/Users/jjh99/바탕 화면/capstone_data")
# 필요한 라이브러리 설치 및 부착
#install.packages("dplyr")
library(dplyr)

#install.packages("data.table")
library(data.table)


# 각 데이터별 2019년 2분기 데이터 추출 및 결측치 처리 
# 집객시설
facilities_b= read.csv(file = "facilities_before.csv", header = TRUE)
facilities_b[is.na(facilities_b)] <- 0
facilities_2 <- facilities_b[facilities_b$기준_분기_코드 == 2 & facilities_b$기준_년_코드 == 2019, ]

# 아파트
apartment_b = read.csv(file = "apartment_b.csv", header = TRUE)
apartment_b[is.na(apartment_b)] <- 0
apartment_2 <- apartment_b[apartment_b$기준_분기_코드 == 2 & apartment_b$기준_년_코드 == 2019, ]

# 유동 인구
estimated_floating_population_b = read.csv(file = "estimated_floating_population_b.csv", header = TRUE)
estimated_floating_population_2 <- estimated_floating_population_b[estimated_floating_population_b$기준_분기_코드 == 2 & estimated_floating_population_b$기준.년코드 == 2019, ]

# 상주 인구
settled_population_b = read.csv(file = "settled_population_b.csv", header = TRUE)
settled_population_2 <- settled_population_b[settled_population_b$기준_분기_코드 == 2 & settled_population_b$기준_년_코드 == 2019, ]

# 직장 인구
working_population_b = read.csv(file = "working_population_b.csv", header = TRUE)
working_population_2 <- working_population_b[working_population_b$기준_분기_코드 == 2 & working_population_b$기준_년월_코드 == 2019, ]


# OUTER JOIN
a2 <- merge(apartment_2, estimated_floating_population_2, by = '상권_코드', all = TRUE)
b2 <- merge(a2, settled_population_2, by = '상권_코드', all = TRUE)
c2 <- merge(b2, working_population_2, by = '상권_코드', all=TRUE)
d2 <- merge(c2, facilities_2, by = '상권_코드', all = TRUE)


# 쓸모 없는 데이터 + 중복 데이터 제거
d2 <- subset(d2, select = -c(기준_년_코드.x, 기준_분기_코드.x, 상권_구분_코드.x, 기준.년코드, 기준_분기_코드.y, X.상권_구분_코드, X.상권_구분_코드_명, 상권_코드_명.y, 기준_년_코드.y, 상권_구분_코드.y, 상권_구분_코드_명.y, 상권.코드.명, 기준_년월_코드, 기준_분기_코드.y, 기준_분기_코드.1, 상권_구분_코드_명.x, 상권_코드_명.x, 기준_년_코드,	기준_분기_코드, 상권_구분_코드, 상권_구분_코드_명.y, 상권_코드_명.y, 기준_분기_코드.y, 상권_구분_코드_명.x,상권_코드_명.x, 상권_구분_코드_명.y,상권_코드_명.y))

comb_2_b <- subset(d2, select = -c(기준_분기_코드.x, 기준_분기_코드.y, 상권_구분_코드_명.x, 상권_코드_명.x, 상권_구분_코드_명.y, 상권_코드_명.y))


###### 2분기 매출 데이터 전처리
sale_2_b = read.csv(file = "estimated_sale_2.csv", header = TRUE)

## SALES GROUP BY CODE
sale_2 <- data.frame(aggregate(sale_2_b$당월_매출_금액, by=list(sale_2_b$상권_코드), FUN=sum))

# COLUMN명 변경
names(sale_2) <- c("상권_코드", "총_매출_금액")


##### 병합을 통한 최종 데이터 생성

# comb_2_b 데이터 중 NA 포함한 행 제거
sum(!complete.cases((comb_2_b))) # NA 포함 행 개수 193개
comb_2_b <- comb_2_b[complete.cases(comb_2_b), ]
sum(!complete.cases(comb_2_b)) # 0
 
# 같은 상권 코드에 대해 열 결합 inner join
data <- merge(x = sale_2, y = comb_2_b, by = '상권_코드')


##### min-max normalization

normalize <- function(x)
{
  return ((x-min(x))/(max(x)-min(x)))
}

dim(data) # 1301 608

# (필요한 행에 대해) normalization
data_need <- data[, 3:608]

data_norm <- normalize(data_need)

new_data <- cbind(data[, 1:2], data_norm)

# 필요 없는 데이터 제거
new_data<-new_data[, -c((40:543), (553:564), (577:588))]

dim(new_data) # 1301 80

# 최종 데이터 파일
write.csv(new_data, file = "real_data_no_log.csv", row.names = FALSE)