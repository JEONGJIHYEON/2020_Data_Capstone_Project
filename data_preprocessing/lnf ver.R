# 기본 환경 조성 (경로 설정 및 라이브러리 설치 & 불러오기)
.libPaths("C:/Users/jjh99/바탕 화면/capstone_data")
setwd("C:/Users/jjh99/바탕 화면/capstone_data")
install.packages("dplyr")
library(dplyr)

# 2분기 매출 데이터 파일 불러오기
sale_2_b = read.csv(file = "C:/Users/jjh99/바탕 화면/capstone_data/estimated_sale_2.csv", header = TRUE)

# 쓸모 없는 데이터 제거...보다 필요한 데이터 뽑는 게 빠를 듯 sale_essential
sale_e = select(sale_2_b, c(상권_코드, 서비스_업종_코드_명, 당월_매출_금액, 점포수))
head(sale_e)

# 당월 매출 금액을 점포수로 나눈 값 = 업종별 평균 매출 금액 데이터 column 생성
sale_e <- transform(sale_e, 평균_매출_금액 = 당월_매출_금액 / 점포수)
head(sale_e)

# 새로운 csv 파일로 저장(파일명: sale_e_2_b.csv)
write.csv(sale_e, file = "C:/Users/jjh99/바탕 화면/capstone_data/sale_e_2_b.csv", row.names = FALSE)

# 행 추출
market_1000001 <- sale_e %>% filter(상권_코드 == 1000001)
market_1000001<- transform(market_1000001, 동일_상권_매출_금액 = mean(market_1000001$평균_매출_금액))
head(market_1000001)
mean(market_1000001$평균_매출_금액)

sale_e %>%
  group_by(상권_코드) %>%
  summarise(mean(평균_매출_금액))
