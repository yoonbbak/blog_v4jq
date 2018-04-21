[과제] 즐겨 찾기 제작 ver 1.0 (순수 JSP의 사용), MySQL + JSP Model 1
- Eclipse Project Type: Dynamic Web Project 
  JSP    : /WebContent/urlv1
 
1. url 테이블 구조 
▷ /WebContent/WEB-INF/doc/url_v1jq.sql 
--------------------------------------------------------------------
2) url 테이블의 생성
   - 저장소 만들기
   - PRIMARY KEY(urlno): urlno컬럼의 값이 2번이상 등록되는 것을 차단.
   
   CREATE TABLE url( 
     urlno  INT             NOT NULL AUTO_INCREMENT, -- URL 번호
     title    VARCHAR(100)  NOT NULL, -- 웹 사이트 제목 예) 기상청
     web    VARCHAR(200)    NOT NULL, -- URL 주소 예) http://www.weather.go.kr
     rdate  DATETIME        NOT NULL, -- 등록일
     PRIMARY KEY(urlno)
   );  
   
   
   select * from url;
