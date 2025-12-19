# flutter_movie_search_app

플러터 영화 검색 앱

## 주요 기능

1. 영화 리스트
2. 영화 검색
3. 영화 상세 정보
4. 좋아요 설정
5. 좋아요 설정된 영화만 모아보는 화면

## 패키지 구조

feature-first와 Layer 기반 구조 섞어서 안드로이드 MVVM과 비슷한 패키지 구조 설계

1. core

- constants : api key, base url, 앱 전역 상수 위치
- router : GoRouter의 라우팅 설정, 전체 화면 경로 정의
- utils : 확장, 헬퍼 함수 모음

2. data

- models : JSON (역)직렬화에 쓸 데이터 모델 보관
- data_sources/remote : retrofit + dio로 api 통신
- data_sources/local : shared_preferences 써서 로컬에 데이터 저장
- repository : 데이터 소스 추상화해서 비즈니스 로직에 활용

3. domain

- entity : 비즈니스 로직에 쓰일 객체
- repository : 인터페이스 추상 클래스 보관

4. presentation

- screens : 화면 별 폴더 나눔
- widgets : 여러 화면에서 재사용될 공통 위젯 보관

5. providers

- riverpod provider 기능 별 그룹화
- api 호출, 상태 관리, DI 중앙 집중화

## 기술 스택

- 상태 관리 : riverpod
- 네트워크 : retrofit + dio
- 네비게이션 : GoRouter
- 로컬 저장 : shared_preferences
- 기타 : velocity_x