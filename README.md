# 각 지역의 상권 형성에 미치는 영향 분석 
## 1. 과제 개요
### 가. 과제 선정 배경 및 필요성
  최근 우리나라에 소상공인의 수가 늘고 있다. 2019년에 통계청과 중소벤처기업부에서 공통 발표된 2018년 기준 소상공인 실태조사 결과에 따르면, 이들은 상권 쇠퇴와 경쟁 심화로 인해 경영에 어려움을 겪고 있다고 밝혔다. 실제로 우리나라는 자금 공급 및 골목 상권 전용 상품권 발행, 예비 창업자를 위한 신사업창업사관학교 운영 및 소상공인의 경제적 입지 보호를 위한 법 제정 등 여러 지원 정책을 추진하고 있다. 그러나 소상공인의 수가 늘어나면서 이쪽 분야가 레드오션이 됐을 뿐만 아니라 코로나로 인해 경제가 침체되고 사람들의 경제적 활동의 형태가 점차 변화함에 따라 업종을 영위하는 것이 어려워졌다. 이러한 상황에 소상공인들의 경제적 생존 문제를 해결하기 위해서는 데이터 분석을 통해 다양한 관점에서 상권을 분석하는 도구를 마련하여 소상공인과 예비 창업자에게 앞으로의 운영 및 창업 방향을 수립하고 계획하는 데 도움을 줄 수 있도록 하는 것이 바람직하다. 
  
### 나. 목표 및 기대 효과
  상권에 영향을 줄 수 있는 특성과 관련된 데이터 및 총 매출 데이터를 분석한다. 다중 선형 회귀 분석, 회귀 나무 분석, 라쏘 회귀 분석을 통해 특성과 총 매출 사이의 관계를 확인하고 이를 바탕으로 추후에 각 특성의 값을 알 수 있을 때 매출의 값을 예측하고 이를 바탕으로 창업의 실효성을 판단할 수 있다. 

## 2. 과제 수행 방법
1) 데이터셋 확보
2) 데이터 전처리
3) Multiple Regression Analysis
4) Regression Tree Analysis
5) Lasso Regression Analysis

## 3. 연구 과제 수행
### 1) 데이터셋 확보
- 데이터는 서울 열린 데이터 광장( http://data.seoul.go.kr/ )에서 수집하였다.
- 가장 최근 데이터인 2019년 데이터를 기준으로, 데이터의 매칭이 불가능한 경우(2019년도 데이터가 없는 경우, 종속 변수인 '총 매출' 데이터가 없는 경우)를 제외한 데이터를 사용했다.
- 각 데이터들은 분기/상권 코드별로 분류되어 있어 분석 시 매칭하기에 용이하다.
- 결론적으로 사용한 데이터는 크게 직장 인구, 아파트, 추정 유동 인구, 집객 시설,상주 인구, 그리고 추정 매출으로 총 6개의 범주가 있으며 각 데이터들은 대표값(총합)과 세분화된 값(카테고리별 분류)으로 이루어져 있다. 데이터가 수집된 시기는 2019년 2분기에 속한다.
- 종속 변수는 '총 매출', 나머지는 독립 변수에 해당한다. 
![image](https://user-images.githubusercontent.com/50713190/102567838-b028ee80-4125-11eb-9e26-353682424f30.png)
△ 데이터셋 중 하나인 '아파트' (가격, 면적별 세대 수 및 평균 면적, 평균 시가)

### 2) 데이터 전처리
- 총 6개의 csv 파일에 흩어져있는 데이터를 하나의 파일에 병합한다. 이때 병합 기준은 '2020년도', '2분기', 그리고 같은 상권 코드(지역 분할)로 지정했다.
- 집객 시설의 수와 같은 비교적 작은 수로 이루어진 데이터가 있는가 하면 아파트 가격, 유동 인구 수 등 큰 수로 이루어진 데이터도 있다. 이때 feature scale의 차이가 심하게 날 경우 특정 feature가 그 크기만으로도 종속 변수에 큰 영향을 미치는 문제가 발생하게 된다.
- 이를 해결하기 위해 정규화(Normalization) 과정을 거쳤으며, 이때 이상치(outlier)의 처리는 어려우나 모든 feature들을 동일한 scale로 만들어주는 Min-Max Normalization을 적용했다.
- 기존 1496개의 데이터 중 195개의 데이터가 결측치(NA)를 포함하고 있다. 이때 각 데이터마다 값이 존재하지 않는 이유가 다르기 때문에 (ex. 실제로는 데이터 값이 존재하지만 파일에는 누락되어 있는 경우, 실제로 값이 0이라 결측치로 표시되어 있는 경우 등) 다른 값(평균, 최대/최소, 중간값, 0 등)으로 대체할 경우 분석 결과에 영향을 미칠 수 있다. 이로 인해 195개의 결측치를 가지는 데이터는 제거하였다. 
- 위의 과정을 거치면 총 607개의 변수(종속 변수 포함)에 대한 1301개의 데이터를 가진다. 이는 데이터 수에 비해 feature의 수가 필요 이상으로 많음을 알 수 있다. 이를 해결하기 위해 각 feature들 중 대표값으로 대체할 수 있는 feature는 제거하였다. (ex. '유동 인구 수' 데이터 - 요일, 연령대, 성별, 시간대로 나뉘어 총 526개의 데이터를 차지함. 이와 같이 여러 기준이 엮여 다수의 feature를 생성하는 경우는 제거하고 하나의 기준을 갖는 feature만 분석에 사용)
- 최종적으로 78개의 독립 변수와 1개의 종속 변수, 그리고 1301개의 데이터를 가진다.

### 3-1) 군집 분석
- 초기 프로젝트 구상 방향: 현재 가지고 있는 데이터셋이 Supervised Learning을 적용해야 하는 형태이지만, 데이터셋을 약간 변형하여 각 지역구(상권)를 유사한 특성을 가지는 지역끼리 묶어 각 군집마다의 특성을 분석하는 것.
- K-means Clustering을 적용하여 군집화 시도
- K=3일 때
![image](https://user-images.githubusercontent.com/50713190/102584465-da8ca300-4149-11eb-9b6d-f29ed4b7bf7e.png)
- 3개의 군집으로 나눴을 때 한 군집에 몰리는 현상이 발생했다.
- K=5일 때
![image](https://user-images.githubusercontent.com/50713190/102584680-466f0b80-414a-11eb-97aa-14a5bec241df.png)
- 5개의 군집으로 나눴을 때에도 비교적 3개의 군집으로 나눴을 때보다는 잘 나뉘었지만 군집 간의 개수 차이가 너무 컸다.
- 군집 분석은 제외하고 회귀 분석만으로 여러 feature가 총 매출에 미치는 영향을 분석하는 것으로 방향을 수정했다.


### 3-2) 회귀 분석 
#### Ⅰ. 다중 회귀 분석 Multiple Regression Analysis
- 1301개의 데이터를 train set과 test set으로 나누어 다중 회귀를 적용했다. 이때, train set과 test set의 비율은 7:3으로 train set은 총 910개, test set은 총 391개이다.
![image](https://user-images.githubusercontent.com/50713190/102581100-3b64ad00-4143-11eb-8628-237221e012f8.png)
- 하나의 직선에 점들이 모여있을수록 예측이 잘 되었다고 볼 수 있다.
- RMSE (평균 제곱근 오차) = 5873435115.634151. 이 값이 작을수록 모델의 예측력이 높다. 그러나 종속 변수인 '총 매출'의 데이터 자체가 원래 큰 값임을 고려하면 판단이 어려울 수 있다.
- 상관 계수 R = 0.02404548906383753. 결정 계수 R²의 값이 클수록 모델의 예측력이 높다.
- Relative Error (상대 오차)
![image](https://user-images.githubusercontent.com/50713190/102581360-bfb73000-4143-11eb-8082-335735c16772.png)

- 최댓값 = -184.984 / 최솟값 = 0.001887
- model score: train set 0.9059856606025053 / test set 0.694154206656521

#### Ⅱ. 회귀 나무 분석 Regression Tree Analysis
- 위에서와 같이 1301개의 데이터를 train set과 test set으로 나누어 회귀 나무 분석을 진행했다. 이때, train set과 test set의 비율은 7:3으로 train set은 총 910개, test set은 총 391개이다.
- RMSE (평균 제곱근 오차) = 12069647783.79031
- Relative Error (상대 오차)
![image](https://user-images.githubusercontent.com/50713190/102582465-00b04400-4146-11eb-9d8d-05b820934ca2.png)

- 최댓값 = -34.06244803 / 최솟값 = 0.000333045
- model score: train set 1.0 / test set 0.497365778760118

#### Ⅲ. 라쏘 회귀 분석 Lasso Regression Analysis
- 라쏘는 다중 선형 회귀 모델에서 Train set의 feature 값과 label 값의 관계를 복잡하게 분석했을 때 발생하는 '과대적합'의 문제를 해결하기 위한 방법 중 하나로, 유의미하지 않은 변수들에 대해 계수를 0에 가깝게 추정하여 변수를 스스로 선택한다. 이를 통해 과대적합을 피하는 일반적인 모델을 만들 수 있다.
![image](https://user-images.githubusercontent.com/50713190/102587765-c21f8700-414f-11eb-9fb3-2dd10a8c5b9d.png)

- 라쏘는 위의 식에서 MSE와 penalty의 합이 최소가 되게 하는 파라미터 α를 찾는 것이 목적이다. 
- 이때 α는 복잡도를 의미하는 파라미터로 penalty의 정도를 조절해주는데, 값이 커지면 penalty의 영향력이 커지고 점점 작아져서 0에 가까워질수록 선형 회귀 모델과 같아진다. 복잡도를 높이고 싶으면 α의 값을 더 작게(ex. α = 1일 때보다 α= 0.001일 때 복잡도가 더 높음) 조절해주면 된다. 

- Default 라쏘 모델에 대한 Relative Error
![image](https://user-images.githubusercontent.com/50713190/102590212-91d9e780-4153-11eb-874b-fdfabfee1f87.png)
- 최댓값 = -220.554 / 최솟값 = 0.002466

- α = 1, max_iter = 1000일 때 (Default)
![image](https://user-images.githubusercontent.com/50713190/102589359-407d2880-4152-11eb-94f1-338c09291777.png)

- α = 0.1, max_iter = 100000일 때
![image](https://user-images.githubusercontent.com/50713190/102589435-5a1e7000-4152-11eb-90f4-913835c8455a.png)

 - α = 0.001, max_iter = 100000일 때
 ![image](https://user-images.githubusercontent.com/50713190/102589491-6dc9d680-4152-11eb-9295-3850e8a59adf.png)

- α = 0.0001, max_iter = 100000일 때
![image](https://user-images.githubusercontent.com/50713190/102589531-7a4e2f00-4152-11eb-8e53-fb801008004b.png)

- α의 값이 점점 작아질수록 사용하는 feature의 수가 늘어남과 동시에 train set의 점수는 높아지는 반면, test set의 점수는 점차 감소함을 볼 수 있다. 
 
![image](https://user-images.githubusercontent.com/50713190/102589746-c6996f00-4152-11eb-9438-8ae895deca1c.png)
- 위 그림에서 볼 수 있듯이 모두 0 근처에 모여 있다는 것은 α의 값과 거의 무관하게 계수 대부분이 0의 값을 가지며 나머지 계수들의 크기도 작다는 것을 알 수 있다. 
- 위의 α값의 변화에 따른 모델의 점수에서 볼 수 있듯이 α의 값이 점점 작아질수록 과대적합 문제가 발생하고 있다. 


## 4. 결과 분석
- 여러 가지를 비교해봤을 때, Regression Tree가 Multiple Regression과 Lasso Regression에서 나은 결과를 보이긴 했으나 Train set score는 높고 Test set score는 현저히 낮은 Overfitting의 문제가 발생하였기 때문에 이 또한 유의미한 분석이라고 보기는 어렵다. 
- 다중 회귀 분석을 통해 구한 기울기로 봤을 때 
- 총 매출과 음의 상관관계를 가지는 변수(45개): 가격에 따른 아파트 세대 수, 아파트 평균 면적, 평균 시가, 연령·시간·요일별 유동인구 수, 연령대별 상주 인구 수, 총 가구 수, 일반 병원 수, 유치원, 초등학교, 중학교, 대학교, 극장, 숙박 시설, 공항 수
- 총 매출과 상관관계가 없는 변수(2개): 철도역, 버스 터미널 수
- 총 매출과 양의 상관관계를 가지는 변수(31개)
- 이 중 백화점의 수가 가장 큰 기울기를 가지며 이는 총 매출에 가장 큰 영향을 미친다는 것을 의미한다.
- 랏쏘 회귀 분석을 통해 구한 결과로 봤을 때 (α = 1 기준)
- 사용된 Feature(총 53개): 아파트 단지 수, 아파트 면적 66m² 미만 세대 수, 아파트 면적 66m² 세대 수, 	아파트 면적 99m² 세대 수, 아파트 면적 132m² 세대 수,	아파트 가격 1억 미만 세대 수, 아파트 가격 1억 세대 수, 아파트 가격 3억 세대 수, 아파트 가격 4억 세대 수, 아파트 가격 6억 이상 세대 수, 아파트 평균 시가, 총 유동인구 수, 성별·연령대·시간대·요일별 유동인구 수, 성별·연령대별 상주인구 수, 총 가구 수, 아파트 가구 수, 총 직장 인구 수, 성별·연령대별 직장 인구 수, 집객시설 수 
- 사용되지 않은 Feature(총 25개): 아파트 면적 165m² 세대 수, 아파트 가격 2억 세대 수, 아파트 가격 5억 세대 수, 아파트 평균 면적, 총 상주인구 수, 비 아파트 가구 수, 관공서 수, 은행 수, 종합병원 수, 일반 병원 수, 약국 수, 유치원 수, 초등학교 수, 중학교 수, 고등학교 수, 대학교 수, 백화점 수, 슈퍼마켓 수, 극장 수, 숙박 시설 수, 공항 수, 철도역 수, 버스 터미널 수, 지하철 역 수, 버스 정거장 수
- 위의 결과를 보면 랏쏘 회귀 분석에서는 집객 시설 관련 데이터는 '집객시설 수'를 제외하고는 사용되지 않았다. 

## 5. 결론 및 프로젝트 회고
- 이 프로젝트에서 사용한 데이터는 극히 일부에 불과하다. 2019년 2분기의 데이터만 사용했기 때문에 데이터 수도 그만큼 적었다. 이로 인해 상권에 영향을 미치는 요인을 거시적 관점에서 분석할 수 없었고 유의 변수를 추출하는 과정도 미비했기 때문에 의미있는 결과를 도출하는 데에도 한계가 있었다. 이는 유의미한 변수를 상권별로 나타내는 시각 매체 구현 계획에도 영향을 미쳤다. 또한 프로젝트 계획과 동시에 스터디를 진행하여 데이터 특성에 걸맞는 머신러닝 기법을 찾는 데 어려움이 있었다. 
- 데이터 수집 기간을 늘리고(예. 1년 단위) 데이터 전처리 과정에 있어 같은 상권 구역으로 묶는 기존의 방법에서 벗어나 분류 대상을 다른 변수로 잡는 등 이번 프로젝트의 방향과 다른 방법을 선택하면 또다른 의미있는 결과를 얻을 수 있을 것이다. 예를 들어, 패스트푸드점, 카페, 독서실, 의류 매장 등 업종별로 묶어 각 업종의 총 매출에 영향을 미치는 요인을 분석하면 좀 더 뚜렷한 분석 결과를 얻을 수 있을 것이라 생각한다.
- 이번 프로젝트에서는 Multiple Regression, Regression Tree, Lasso Regression 3가지의 분석 방법만 사용했지만 다른 방법들도 적용해보고 결과를 비교해봄과 동시에 데이터에 적합한 방법과 그 이유를 안다면 분석 결과의 신뢰성을 높일 수 있을 것이다.
- 위와 같이 더 다양한 방법으로 정밀한 분석 과정을 거친다면 같은 데이터로도 정확하고 무궁무진한 결과를 도출할 수 있고 이를 통해 소상공인들에게 도움을 줄 수 있을 것으로 기대된다. 

-----------------------------------------------------
## REPOSITORY GUIDE
- code: data_preprocess.R (데이터 전처리 파일), multiple_regression.ipynb(다중 회귀), regression_tree(회귀 나무), Lasso_regression.ipynb(랏쏘 회귀) (K-means Clustering 실제로 분석에 사용되진 않았으므로 제외)
- 데이터 파일의 경우 제한 용량인 10MB를 넘기는 경우가 발생하여 업로드하지 않았으며, 웹 사이트 (서울 열린 데이터 광장)에서 다운로드할 수 있다.
