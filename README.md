# 각 지역의 상권 형성에 미치는 영향 분석 
## 1. 과제 개요
### 가. 과제 선정 배경 및 필요성
  최근 우리나라에 소상공인의 수가 늘고 있다. 2019년에 통계청과 중소벤처기업부에서 공통 발표된 2018년 기준 소상공인 실태조사 결과에 따르면, 이들은 상권 쇠퇴와 경쟁 심화로 인해 경영에 어려움을 겪고 있다고 밝혔다. 실제로 우리나라는 자금 공급 및 골목 상권 전용 상품권 발행, 예비 창업자를 위한 신사업창업사관학교 운영 및 소상공인의 경제적 입지 보호를 위한 법 제정 등 여러 지원 정책을 추진하고 있다. 그러나 소상공인의 수가 늘어나면서 이쪽 분야가 레드오션이 됐을 뿐만 아니라 코로나로 인해 경제가 침체되고 사람들의 경제적 활동의 형태가 점차 변화함에 따라 업종을 영위하는 것이 어려워졌다. 이러한 상황에 소상공인들의 경제적 생존 문제를 해결하기 위해서는 보다 정밀한 ? 상권 분석을 통해 업종과 적절한 입지를 예비 창업자에게 제공해줄 수 있는 도구를 마련하는 것이 바람직하다. 
  ((소상공인에게 경제적인 지원뿐만 아니라 정보와 관련된 지원을 제공하고 있는데, 대표적인 예가 '서울시 우리마을가게 상권분석 서비스'이다. 이 서비스에서는 상권 관련 빅데이터를 분석하여 업종별 다양한 정보를 상권 단위로 제공하고 있다. 소상공인 및  예비 창업자들은 이 서비스를 통해 앞으로의 운영 및 창업 방향을 수립하고 계획할 수 있다. ))
  
### 나. 목표
  상권에 영향을 줄 수 있는 특성과 관련된 데이터 및 총 매출 데이터를 분석한다. 다중 선형 회귀 분석, 의사 결정 회귀 나무 분석을 통해 각 특성이 총 매출에 미치는 영향을 확인하고 이를 바탕으로 추후에 각 특성의 값을 알 수 있을 때 매출의 값을 예측하고 이를 바탕으로 창업의 실효성?을 판단할 수 있다. 

## 2. 과제 수행 방법
1) 데이터셋 확보
2) 데이터 전처리
3) 주성분 분석을 통한 차원 축소
4) 다중 회귀 분석
5) Regression Tree를 통한 회귀 분석

## 3. 연구 과제 수행
### 1) 데이터셋 확보
- 데이터는 서울 열린 데이터 광장( http://data.seoul.go.kr/ )에서 수집하였다.
- 가장 최근 데이터인 2019년 데이터를 기준으로, 데이터의 매칭이 불가능한 경우(2019년도 데이터가 없는 경우, 종속 변수인 '총 매출' 데이터가 없는 경우)를 제외한 데이터를 사용했다.
- 각 데이터들은 분기/상권 코드별로 분류되어 있어 분석 시 매칭하기에 용이하다.
- 결론적으로 사용한 데이터는 크게 직장 인구, 아파트, 추정 유동 인구, 집객 시설,상주 인구, 그리고 추정 매출으로 총 6개의 범주가 있으며 각 데이터들은 대표값(총합)과 세분화된 값(카테고리별 분류)으로 이루어져 있다. 데이터가 수집된 시기는 2019년 2, 3, 4분기에 속한다.
- 종속 변수는 '총 매출', 나머지는 독립 변수에 해당한다. 
![image](https://user-images.githubusercontent.com/50713190/102567838-b028ee80-4125-11eb-9e26-353682424f30.png)
△ 데이터셋 중 하나인 '아파트' (가격, 면적별 세대 수 및 평균 면적, 평균 시가)

### 2) 데이터 전처리
- 총 6개의 csv 파일에 흩어져있는 데이터를 하나의 파일에 병합한다. 이때 병합 기준은 '2020년도', '2분기', 그리고 같은 상권 코드(지역 분할)로 지정했다.
- 집객 시설의 수와 같은 비교적 작은 수로 이루어진 데이터가 있는가 하면 아파트 가격, 유동 인구 수 등 큰 수로 이루어진 데이터도 있다.
- feature scale의 차이가 심하게 날 경우 특정 feature가 그 크기만으로도 종속 변수에 큰 영향을 미치는 문제가 발생하게 된다.
- 이를 해결하기 위해 정규화(Normalization) 과정을 거쳤으며, 이때 이상치(outlier)의 처리는 어려우나 모든 feature들을 동일한 scale로 만들어주는 Min-Max Normalization을 적용했다.
- 총 매출 데이터.... 그건 어떡하지 아무튼
- 위의 과정을 거치면 총 607개의 변수(종속 변수 포함)에 대한 1301개의 데이터를 가진다. 이는 데이터 수에 비해 feature의 수가 필요 이상으로 많음을 알 수 있다. 이 문제를 해결하기 위해 각 feature들 중 대표값으로 대체할 수 있는 feature는 제거하였다. (ex. '유동 인구 수' 데이터 - 요일, 연령대, 성별, 시간대로 나뉘어 총 526개의 데이터를 차지함. 이와 같이 여러 기준이 엮여 다수의 feature를 생성하는 경우는 제거하고 하나의 기준을 갖는 feature만 분석에 사용)
- 최종적으로 78개의 독립 변수와 1개의 종속 변수, 그리고 1301개의 데이터를 가진다.

### 3) 다중 회귀 분석
