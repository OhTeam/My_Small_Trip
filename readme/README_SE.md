# 마이스몰트립 (MySmallTrip)
> - 팀 프로젝트 내에서 제가 수행한 역할을 정리한 문서입니다.

<br>

## Contents
1. [My Rule](#my-rule)   
    a. 기획  
    b. 디자인   
    c. 개발  
    d. 일정관리  

2. [Review](#review)  
    a. 배운점  
    b. 아쉬운점 및 보완할점  
3. [Contact](#contact)

<br>

## My Rule
### a. 기획
> - BackLog
>    ![BackLog](https://github.com/OhTeam/My_Small_Trip/blob/SE/Screenshot/SE/backlog.png)

> - AppFlow
>   ![AppFlow](https://github.com/OhTeam/My_Small_Trip/blob/SE/Screenshot/SE/app%20flow.png)

<br>

### b. 디자인
> - Sketch3
> ![Design](https://github.com/OhTeam/My_Small_Trip/blob/SE/Screenshot/SE/sketch%20design.png)

<br>

### c. 개발
- 시작페이지
> <img src = "https://github.com/OhTeam/My_Small_Trip/blob/SE/Screenshot/SE/dev/dev_root.png" height = 500>
>   
> - Login & SignUp 연결
>  - 페이스북 로그인

----------------------------------------------------------------

- Tab 1. Main(여행 상품 페이지)
> ![Main](https://github.com/OhTeam/My_Small_Trip/blob/SE/Screenshot/SE/dev/dev_main.png)
>
>    + Custom Tabbar
>    + a) 인기있는 여행 도시 목록 View
>    + b) 해당 도시의 전체 여행상품 목록 View
>    + c) 해당 여행상품의 Detail Info View
>    + d) 상품 예약하기

----------------------------------------------------------------

- Tab 2. Search
> <img src = "https://github.com/OhTeam/My_Small_Trip/blob/SE/Screenshot/SE/dev/dev_search.png" height = 500>
>
>    + 검색한 상품 보여주기
>    + 해당 상품 없을 경우 예외처리
    


----------------------------------------------------------------

- Tab 3. WishList
>  <img src = "https://github.com/OhTeam/My_Small_Trip/blob/SE/Screenshot/SE/dev/dev_wishlist.png" height = 500>
>
>    + 위시리스트 목록 보여주기
>    + 위시리스트 추가 / 삭제

----------------------------------------------------------------

- Tab 4. Profile - (b) My Trip
> ![dev_mytrip](https://github.com/OhTeam/My_Small_Trip/blob/SE/Screenshot/SE/dev/dev_mytrip.png)
>
>    + 예약한 여행 보여주기
>    + 추후 추가 예정) 예약 취소 / 취소한 여행 보여주기

<br>

### d. 일정관리
![Calendar1](https://github.com/OhTeam/My_Small_Trip/blob/SE/Screenshot/SE/calendar1.png)

![Calendar2](https://github.com/OhTeam/My_Small_Trip/blob/SE/Screenshot/SE/calendar2.png)

<br>

## Review
### a. 배운점
- Team   
    + Git & branch 관리. Merge시 Conflict 처리.
    + StoryBoard Reference 활용. 
    + 서버팀과 전달받을 데이터 값, 타입 등 의견 조율

- Develop  
    + 서버로부터 전달받은 파일을 원하는 형태로 가공하여 UI로 표현
    + 데이터 모델링. Codable 활용
    + TabBar, UIButton 등의 SubClassing 

- Personal
    + 비록 클론앱이기 때문에 출시할 수는 없었지만, 처음부터 끝까지 하나의 프로젝트를 완성했다는 점이 가장 뿌듯!
    + 기획과 디자인은 언제든 계속 변할 수 있음. 항상 그에 대응할 수 있도록 설계하고 개발해야 함.
    + 협업을 위해서는 서버에 대해서 기본 지식은 있어야 훨씬 수월해질 것. 안드로이드, 웹 등도 마찬가지일 것.

<br>

### b. 아쉬운점 및 보완할점
- 일정 관리
    + 초기 Git을 설정 및 협업 과정에서 예상보다 시간이 오래걸려 기획했던 부분을 모두 구현하지는 못함. 
    + 기능을 구현하는데 걸리는 시간을 예상하고 실제와 비교해서 예상-실제의 갭을 줄이기 위해 노력해야 할듯.

- 설계
    + 협업하기 위한 기초 설계 - 팀원과 함께 사용하는 파일의 생성(model, storyboard 등) 미흡
    + 나중에 맞추려고 하다보니 잦은 충돌 + 파일을 중복 생성하는 등 문제 발생
    + 개인 작업시에도 "일단 구현하고 보자"는 생각으로 만들다보니, "효율성" 측면에서 많이 부족했음.
    + `코드리뷰, 많은 리팩토링, 잘 만들어진 코드 참고하기, 디자인 패턴 적용`으로 보완하기

- 데이터 로딩시의 처리
    + 이미지를 받아오는데 걸리는 시간동안 UI가 비어있는 등의 처리가 미흡했음.
    + 한 번 서버에서 받아온 데이터는 캐시에 저장해 둬서 매번 불러올 필요가 없도록 처리
    + 로딩중 UI - Activity Indicator
    + 새로고침 시, 기존과 비교해서 변경된 부분만 받아온다면 시간이 덜 걸릴 것 같다는 생각.

- 코드리뷰
    + 하나의 sprint가 끝날때마다 진행하기로 했던 코드리뷰를 각자 개발 일정이 촉박해서 못함
    + 그나마 전체 프로젝트가 끝난 후, 각자의 파트를 코드를 보며 설명하며 보완함.

- 오픈소스
    + 최대한 모든 것을 직접 구현하고자 최대한 오픈소스의 사용을 자제함.
    + 덕분에 코드로 AutoLayout을 구현해 보는 등 성과도 있었지만, 추후 실무에서 일할 것을 생각하면 주요 오픈소스들은 한 번 활용해보면 좋았을걸 하는 아쉬움도 남음. 다음 프로젝트에서 보완해서 적용하는 걸로.


<br>

## Contact
- phone: +82 10.5835.0602
- mail: p.ssungnni@gmail.com
