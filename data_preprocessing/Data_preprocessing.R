.libPaths("C:/Users/jjh99/바탕 화면/capstone_data")
setwd("C:/Users/jjh99/바탕 화면/capstone_data")
# 1. 집객 시설 (facilities_before.csv) 데이터에 존재하는 NA 값 0으로 대체

# 이전 데이터 파일 불러오기
before_data = read.csv(file = "C:/Users/jjh99/바탕 화면/capstone_data/facilities_before.csv", header = TRUE)

# NA (결측치) 개수 확인
sum(is.na(before_data)) # 501258

# 모든 행의 결측값 NA -> 0으로 대체 및 결과 확인
before_data[is.na(before_data)] <- 0
sum(is.na(before_data)) # 0

# 결측값 처리된 데이터 새로운 csv 파일로 저장(파일명: facilities_b.csv)
write.csv(before_data, file = "C:/Users/jjh99/바탕 화면/capstone_data/facilities_b.csv", row.names = FALSE)

# 각 데이터 2, 3, 4분기로 분류

# 1) 데이터 불러오기
apartment_b = read.csv(file = "C:/Users/jjh99/바탕 화면/capstone_data/apartment_b.csv", header = TRUE)
estimated_floating_population_b = read.csv(file = "C:/Users/jjh99/바탕 화면/capstone_data/estimated_floating_population_b.csv", header = TRUE)
settled_population_b = read.csv(file = "C:/Users/jjh99/바탕 화면/capstone_data/settled_population_b.csv", header = TRUE)
facilities_b = read.csv(file = "C:/Users/jjh99/바탕 화면/capstone_data/facilities_b.csv", header = TRUE)
working_population_b = read.csv(file = "C:/Users/jjh99/바탕 화면/capstone_data/working_population_b.csv", header = TRUE)


# 각 데이터 분기별로 분류 + 2019년 데이터만 추출해서 저장
apartment_b[is.na(apartment_b)] <- 0
apartment_2 <- apartment_b[apartment_b$기준_분기_코드 == 2 & apartment_b$기준_년_코드 == 2019, ]
apartment_3 <- apartment_b[apartment_b$기준_분기_코드 == 3 & apartment_b$기준_년_코드 == 2019, ]
apartment_4 <- apartment_b[apartment_b$기준_분기_코드 == 4 & apartment_b$기준_년_코드 == 2019, ]

write.csv(apartment_2, file = "C:/Users/jjh99/바탕 화면/capstone_data/apartment_2.csv", row.names = FALSE)
write.csv(apartment_3, file = "C:/Users/jjh99/바탕 화면/capstone_data/apartment_3.csv", row.names = FALSE)
write.csv(apartment_4, file = "C:/Users/jjh99/바탕 화면/capstone_data/apartment_4.csv", row.names = FALSE)

estimated_floating_population_2 <- estimated_floating_population_b[estimated_floating_population_b$기준_분기_코드 == 2 & estimated_floating_population_b$기준.년코드 == 2019, ]
estimated_floating_population_3 <- estimated_floating_population_b[estimated_floating_population_b$기준_분기_코드 == 3 & estimated_floating_population_b$기준.년코드 == 2019, ]
estimated_floating_population_4 <- estimated_floating_population_b[estimated_floating_population_b$기준_분기_코드 == 4 & estimated_floating_population_b$기준.년코드 == 2019, ]

write.csv(estimated_floating_population_2, file = "C:/Users/jjh99/바탕 화면/capstone_data/estimated_floating_population_2.csv", row.names = FALSE)
write.csv(estimated_floating_population_3, file = "C:/Users/jjh99/바탕 화면/capstone_data/estimated_floating_population_3.csv", row.names = FALSE)
write.csv(estimated_floating_population_4, file = "C:/Users/jjh99/바탕 화면/capstone_data/estimated_floating_population_4.csv", row.names = FALSE)


settled_population_2 <- settled_population_b[settled_population_b$기준_분기_코드 == 2 & settled_population_b$기준_년_코드 == 2019, ]
settled_population_3 <- settled_population_b[settled_population_b$기준_분기_코드 == 3 & settled_population_b$기준_년_코드 == 2019, ]
settled_population_4 <- settled_population_b[settled_population_b$기준_분기_코드 == 4 & settled_population_b$기준_년_코드 == 2019, ]

write.csv(settled_population_2, file = "C:/Users/jjh99/바탕 화면/capstone_data/settled_population_2.csv", row.names = FALSE)
write.csv(settled_population_3, file = "C:/Users/jjh99/바탕 화면/capstone_data/settled_population_3.csv", row.names = FALSE)
write.csv(settled_population_4, file = "C:/Users/jjh99/바탕 화면/capstone_data/settled_population_4.csv", row.names = FALSE)

working_population_2 <- working_population_b[working_population_b$기준_분기_코드 == 2 & working_population_b$기준_년월_코드 == 2019, ]
working_population_3 <- working_population_b[working_population_b$기준_분기_코드 == 3 & working_population_b$기준_년월_코드 == 2019, ]
working_population_4 <- working_population_b[working_population_b$기준_분기_코드 == 4 & working_population_b$기준_년월_코드 == 2019, ]

write.csv(working_population_2, file = "C:/Users/jjh99/바탕 화면/capstone_data/working_population_2.csv", row.names = FALSE)
write.csv(working_population_3, file = "C:/Users/jjh99/바탕 화면/capstone_data/working_population_3.csv", row.names = FALSE)
write.csv(working_population_4, file = "C:/Users/jjh99/바탕 화면/capstone_data/working_population_4.csv", row.names = FALSE)

facilities_2 <- facilities_b[facilities_b$기준_분기_코드 == 2 & facilities_b$기준_년_코드 == 2019, ]
facilities_3 <- facilities_b[facilities_b$기준_분기_코드 == 3 & facilities_b$기준_년_코드 == 2019, ]
facilities_4 <- facilities_b[facilities_b$기준_분기_코드 == 4 & facilities_b$기준_년_코드 == 2019, ]

write.csv(facilities_2, file = "C:/Users/jjh99/바탕 화면/capstone_data/facilities_2.csv", row.names = FALSE)
write.csv(facilities_3, file = "C:/Users/jjh99/바탕 화면/capstone_data/facilities_3.csv", row.names = FALSE)
write.csv(facilities_4, file = "C:/Users/jjh99/바탕 화면/capstone_data/facilities_4.csv", row.names = FALSE)

##################### OUTER JOIN 순차적으로 진행 #####################
# 2분기
a2 <- merge(apartment_2, estimated_floating_population_2, by = '상권_코드', all = TRUE)
b2 <- merge(a, settled_population_2, by = '상권_코드', all = TRUE)
c2 <- merge(b, working_population_2, by = '상권_코드', all=TRUE)
d2 <- merge(c, facilities_2, by = '상권_코드', all = TRUE)


# 쓸모 없는 데이터 + 중복 데이터 제거
d2 <- subset(d2, select = -c(기준_년_코드.x, 기준_분기_코드.x, 상권_구분_코드.x, 기준.년코드, 기준_분기_코드.y, X.상권_구분_코드, X.상권_구분_코드_명, 상권_코드_명.y, 기준_년_코드.y, 상권_구분_코드.y, 상권_구분_코드_명.y, 상권.코드.명, 기준_년월_코드, 기준_분기_코드.y, 기준_분기_코드.1, 상권_구분_코드_명.x, 상권_코드_명.x, 기준_년_코드,	기준_분기_코드, 상권_구분_코드, 상권_구분_코드_명.y, 상권_코드_명.y, 기준_분기_코드.y, 상권_구분_코드_명.x,상권_코드_명.x, 상권_구분_코드_명.y,상권_코드_명.y))
e2 <- subset(d2, select = -c(기준_분기_코드.x, 기준_분기_코드.y, 상권_구분_코드_명.x, 상권_코드_명.x, 상권_구분_코드_명.y, 상권_코드_명.y))
# 통합 2분기 데이터 csv 파일로 출력  
write.csv(e2, file = "C:/Users/jjh99/바탕 화면/capstone_data/comb_2.csv", row.names = FALSE)


# 3분기
a3 <- merge(apartment_3, estimated_floating_population_3, by = '상권_코드', all = TRUE)
b3 <- merge(a3, settled_population_3, by = '상권_코드', all = TRUE)
c3 <- merge(b3, working_population_3, by = '상권_코드', all=TRUE)
d3 <- merge(c3, facilities_3, by = '상권_코드', all = TRUE)


# 쓸모 없는 데이터 + 중복 데이터 제거
d3 <- subset(d3, select = -c(기준_년_코드.x, 기준_분기_코드.x, 상권_구분_코드.x, 기준.년코드, 기준_분기_코드.y, X.상권_구분_코드, X.상권_구분_코드_명, 상권_코드_명.y, 기준_년_코드.y, 상권_구분_코드.y, 상권_구분_코드_명.y, 상권.코드.명, 기준_년월_코드, 기준_분기_코드.y, 기준_분기_코드.1, 상권_구분_코드_명.x, 상권_코드_명.x, 기준_년_코드,	기준_분기_코드, 상권_구분_코드, 상권_구분_코드_명.y, 상권_코드_명.y, 기준_분기_코드.y, 상권_구분_코드_명.x,상권_코드_명.x, 상권_구분_코드_명.y,상권_코드_명.y))
e3 <- subset(d3, select = -c(기준_분기_코드.x, 기준_분기_코드.y, 상권_구분_코드_명.x, 상권_코드_명.x, 상권_구분_코드_명.y, 상권_코드_명.y))
# 통합 3분기 데이터 csv 파일로 출력  
write.csv(e3, file = "C:/Users/jjh99/바탕 화면/capstone_data/comb_3.csv", row.names = FALSE)

# 4분기
a4 <- merge(apartment_4, estimated_floating_population_4, by = '상권_코드', all = TRUE)
b4 <- merge(a4, settled_population_4, by = '상권_코드', all = TRUE)
c4 <- merge(b4, working_population_4, by = '상권_코드', all=TRUE)
d4 <- merge(c4, facilities_4, by = '상권_코드', all = TRUE)


# 쓸모 없는 데이터 + 중복 데이터 제거
d4 <- subset(d4, select = -c(기준_년_코드.x, 기준_분기_코드.x, 상권_구분_코드.x, 기준.년코드, 기준_분기_코드.y, X.상권_구분_코드, X.상권_구분_코드_명, 상권_코드_명.y, 기준_년_코드.y, 상권_구분_코드.y, 상권_구분_코드_명.y, 상권.코드.명, 기준_년월_코드, 기준_분기_코드.y, 기준_분기_코드.1, 상권_구분_코드_명.x, 상권_코드_명.x, 기준_년_코드,	기준_분기_코드, 상권_구분_코드, 상권_구분_코드_명.y, 상권_코드_명.y, 기준_분기_코드.y, 상권_구분_코드_명.x,상권_코드_명.x, 상권_구분_코드_명.y,상권_코드_명.y))
e4 <- subset(d4, select = -c(기준_분기_코드.x, 기준_분기_코드.y, 상권_구분_코드_명.x, 상권_코드_명.x, 상권_구분_코드_명.y, 상권_코드_명.y))
# 통합 4분기 데이터 csv 파일로 출력  
write.csv(e4, file = "C:/Users/jjh99/바탕 화면/capstone_data/comb_4.csv", row.names = FALSE)