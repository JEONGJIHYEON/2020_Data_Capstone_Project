# 기본 환경 조성 (경로 설정 및 라이브러리 설치 & 불러오기)
.libPaths("C:/Users/jjh99/바탕 화면/capstone_data")
setwd("C:/Users/jjh99/바탕 화면/capstone_data")
install.packages("dplyr")
library(dplyr)

install.packages("data.table")
library(data.table)

# 2분기 매출 데이터 파일 불러오기
sale_2_b = read.csv(file = "estimated_sale_2.csv", header = TRUE)

## SALES GROUP BY CODE
sale_2 <- data.frame(aggregate(sale_2_b$당월_매출_금액, by=list(sale_2_b$상권_코드), FUN=sum))

# COLUMN명 변경
names(sale_2) <- c("상권_코드", "총_매출_금액")
head(sale_2_bb)

# 새로운 csv 파일로 저장(파일명: sale_2.csv)
write.csv(sale_2, file = "sale_2.csv", row.names = FALSE)


## 합치기 작업 = 최종 데이터 파일 생성

# 기존 독립변수 데이터 파일 불러오기
comb_2_b = read.csv(file = "comb_2.csv", header = TRUE)

# NA를 포함하고 있는 데이터가 있으므로 이에 대한 처리를 위해 개수 파악
sum(!complete.cases((comb_2_b))) # NA 포함 행 개수 (총 1496행 중) 193행

# # NA 포함하고 있는 열 파악
# 상결빈 <- table(상권_코드_결측치 <- is.na(comb_2_b$상권_코드))
# head(상결빈)

# comb_2_b 데이터 중 NA 포함한 행 제거
comb_2_b <- comb_2_b[complete.cases(comb_2_b), ]
sum(!complete.cases(comb_2_b)) # 0 확인
 
# 같은 상권 코드에 대해 열 결합 inner join
final_data <- merge(x = sale_2, y = comb_2_b, by = '상권_코드')
write.csv(final_data, file = "final_data_2.csv", row.names = FALSE)
