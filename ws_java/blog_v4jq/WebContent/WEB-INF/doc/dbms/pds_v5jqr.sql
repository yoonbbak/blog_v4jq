1. 게시판 테이블 구조
① FOREIGN KEY (categoryno) REFERENCES category(categoryno)
    - pds4 테이블의 categoryno 컬럼의 값은 category 테이블에 등록된
      categoryno 컬럼의 값들만 올 수 있습니다.
    - 현재 Foreign Key(FK) 테이블에 등록된 레코드중 FK 컬럼을 이용하여
      Primary Key(PK) 테이블에 등록된 PK 컬럼과 서로 연결(JOIN)하여
      그룹화된 처리를 목적으로 합니다. 
    
 
DROP TABLE pds4; 
 
CREATE TABLE pds4 ( 
  pdsno           INT                 NOT NULL AUTO_INCREMENT COMMENT '글 일련 번호', 
  categoryno INT              NOT NULL COMMENT '카테고리번호',
  rname            VARCHAR(20)    NOT NULL COMMENT '글쓴이',
  email               VARCHAR(100)          NULL COMMENT '이메일',  
  title                  VARCHAR(200)  NOT NULL COMMENT '제목', 
  content          VARCHAR(4000) NOT NULL COMMENT '글 내용', 
  passwd          VARCHAR(15)    NOT NULL COMMENT '글 일련 번호', 
  cnt                    INT                 DEFAULT 0 NOT NULL COMMENT '조회수', 
  rdate                DATETIME        NOT NULL COMMENT '등록 날짜', 
  web                  VARCHAR(100)        NULL COMMENT 'URL',
  file1                   VARCHAR(100)         NULL COMMENT '파일명',
  fstor1                VARCHAR(100)         NULL COMMENT '실제 저장 파일명',
  thumb               VARCHAR(100)          NULL COMMENT 'preview',
  size1                  BIGINT            DEFAULT 0 NOT NULL COMMENT '파일 크기 1',
  map                    VARCHAR(1024)        NULL COMMENT '지도 정보',
  youtube            VARCHAR(512)          NULL COMMENT 'Google Youtube',
  mp3                    VARCHAR(50)            NULL COMMENT 'MP3 파일명',
  mp4                    VARCHAR(50)            NULL COMMENT 'MP4 영상',  
  ip                          VARCHAR(15)    NOT NULL COMMENT '000.000.000.000', 
  visible                CHAR(1)            DEFAULT 'Y' NOT NULL COMMENT '숨기기',  
  grpno    INT        NOT NULL COMMENT '그룹 번호',
  indent   INT        DEFAULT 0       NOT NULL COMMENT '답변 차수',
  ansnum   INT       DEFAULT 0       NOT NULL COMMENT '답변 순서',
  
  PRIMARY KEY (pdsno),
  FOREIGN KEY (categoryno) REFERENCES category(categoryno)
) COMMENT='PDS4';   
 
- Cannot add foreign key constraint: PK 테이블이 없음.
 
 
2. 글 추가(C: Create) 
SELECT categoryno, title, seqno, visible, ids, cnt
FROM category
ORDER BY categoryno ASC;
 
 categoryno title seqno visible ids   cnt
 ---------- ----- ----- ------- ----- ---
          1 해외 영화     1 Y       guest   0
          2 국내 영화     2 Y       guest   0
          3 미드        3 Y       guest   0
      
 --IFNULL(null이 아닐 경우의 값, null일 경우의 값)
 --MAX(컬럼명): 최대값 레코드가 없으면 null이 발생됨.
SELECT MAX(grpno) as grpno FROM pds4;

--null + 1은 null임 의미없음;
SELECT MAX(grpno) + 1 as grpno FROM pds4;


SELECT IFNULL(MAX(grpno), 0) as grpno FROM pds4;
          
-- 새로운 글 등록
-- grpno : 최대값 + 1
-- indent = 0, 답변이 아니고 들여쓰기도 필요없음
-- ansnum = 0, 답변이 아니고 가장 먼저 출력
INSERT INTO pds4(categoryno, rname, email, title, content, passwd,
                  cnt, rdate, web, file1, fstor1, thumb, size1,
                  map, youtube, mp3, mp4, ip, visible, grpno, indent, ansnum)
VALUES(1, '왕눈이', 'mail1', '하얀 동그라미 재판', '코카서스의 백묵원', '123', 
           0, now(), 'http://art.incheon.go.kr', 'spring.jpg', 'spring01.jpg', 'spring_m.jpg', 1000,
           'daum map', 'http://', 'song.mp3', 'movie.mp4', '172.16.7.1', 'Y',
           (SELECT IFNULL(MAX(grpno), 0) + 1 FROM pds4 as grpno), 0, 0);
           
            
INSERT INTO pds4(categoryno, rname, email, title, content, passwd,
                  cnt, rdate, web, file1, fstor1, thumb, size1,
                  map, youtube, mp3, mp4, ip, visible)
VALUES(2, '아로미', 'mail1', '하얀 동그라미 재판', '코카서스의 백묵원', '123',
           0, now(), 'http://art.incheon.go.kr', 'spring.jpg', 'spring01.jpg', 'spring_m.jpg', 1000,
           'daum map', 'http://', 'song.mp3', 'movie.mp4', '172.16.7.1', 'Y');
            
INSERT INTO pds4(categoryno, rname, email, title, content, passwd,
                  cnt, rdate, web, file1, fstor1, thumb, size1,
                  map, youtube, mp3, mp4, ip, visible)
VALUES(3, '제니퍼', 'mail1', '패신저스2016', '우주 식민지를 위한 여행', '123',
           0, now(), 'http://art.incheon.go.kr', 'spring.jpg', 'spring01.jpg', 'spring_m.jpg', 1000,
           'daum map', 'http://', 'song.mp3', 'movie.mp4', '172.16.7.1', 'Y');
            
            
3. 전체 글 목록(S:Total Select List), 최신글 먼저 출력 
   - ASC: 오름 차순, DESC: 내림 차순 
   - substring(컬럼명, 시작위치, 길이), 시작위치 1부터 시작: 문자열 일부만 선택
   - 함수 사용시 컬럼명이 매우 길어짐으로 
     'SUBSTRING(rdate, 1, 10)' 문장을 as 키워드로 'rdate' 변환합니다. 
 
-- 카테고리별 목록 -- SELECT
SELECT pdsno, categoryno, rname, email, title, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1,
          thumb, size1, map, youtube, mp3, mp4, ip, visible, grpno, indent, ansnum
FROM pds4 
WHERE categoryno = 1
ORDER BY grpno DESC, ansnum ASC;
  
4. pds4 조회
 
1) 조회수 증가 
UPDATE pds4
SET cnt = cnt + 1
WHERE pdsno=51;
 
2) 1건의 글 보기(R:Read, PK 사용) 
SELECT pdsno, categoryno, rname, email, title, content, passwd,
          cnt, rdate, web, file1, fstor1, thumb, size1, map, youtube,
          mp3, mp4, ip, visible
FROM pds4
WHERE pdsno=51;

3) Mp4 컬럼 확인
SELECT pdsno, mp4
FROM pds4
LIMIT 0, 5;

 
 pdsno categoryno rname email title      content   passwd cnt rdate                 web                      file1      fstor1       thumb        size1 map      youtube mp3      mp4       ip         visible
 ----- ---------- ----- ----- ---------- --------- ------ --- --------------------- ------------------------ ---------- ------------ ------------ ----- -------- ------- -------- --------- ---------- -------
     1          1 왕눈이   mail1 하얀 동그라미 재판 코카서스의 백묵원 123      0 2017-02-23 15:06:21.0 http://art.incheon.go.kr spring.jpg spring01.jpg spring_m.jpg  1000 daum map http:// song.mp3 movie.mp4 172.16.7.1 Y
     
 
5. 패스워드 검사
   - COUNT(): 발생한 레코드의 수를 계산, 레코드가 없으면 0 출력
   
SELECT COUNT(*) as cnt 
FROM pds4
WHERE pdsno=1 AND passwd='123';
 
 cnt
 ---
   0
 
   
6. 글 수정(U:Update), PK는 레코드를 구분하는 고유 기능을 가지고 있음으로 
   수정하는 것은 권장하지 않음. 
    
1) 글만 수정 
UPDATE pds4
SET rname='투투', email='mail1@mail.com', title='제목변경',
      content='내용 변경', web='http://www.kma.go.kr',
      /*ip변경안됩니다*/
WHERE pdsno=1;
  
2) Visible 수정
UPDATE pds4
SET visible = 'Y'
WHERE pdsno=1;
 
3) 파일 삭제
UPDATE pds4
SET file1='', fstor1='', thumb='', size1=123
WHERE pdsno=1;

4) 파일 수정
UPDATE pds4
SET file1='test.jpg', fstor1='test1.jpg', thumb='test_m.jpg', size1=123
WHERE pdsno=1;
 
5) MP3 변경
UPDATE pds4
SET mp3=''
WHERE pdsno=1;
 
6) MP4 변경
UPDATE pds4
SET mp4=''
WHERE pdsno=1;
 
7) 지도 변경
UPDATE pds4
SET map=''
WHERE pdsno=1;
 
8) 지도 삭제
UPDATE pds4
SET map=''
WHERE pdsno=1;
 
7. 글 삭제(D:Delete) 
DELETE FROM pds4
WHERE pdsno = 1;
  
DELETE FROM pds4
WHERE pdsno <= 4;
 
DELETE FROM pds4
WHERE pdsno >= 11;
 
 
8. 검색 글 목록(S:Search List) 
    - 목록은 제작시 검색을 기반으로 제작하며 전체 내용은
      전체 검색과도 같습니다.
    - rname, title, content 컬럼 대상
 
1) 선언: 
    - WHERE rname LIKE '왕눈이'
       rname 컬럼의 값이 '왕눈이'인 레코드 전부 출력
 
    - WHERE rname LIKE '%왕눈이%'
      rname 컬럼의 값중 '왕눈이'가 들어간 레코드 전부 출력
 
    - WHERE rname LIKE '왕눈이%'
      rname 컬럼의 값중 '왕눈이'로 시작하는 레코드 전부 출력
 
    - WHERE rname LIKE '%왕눈이'
      rname 컬럼의 값중 '왕눈이'로 종료하는 레코드 전부 출력
   
 
2) 검색을 하지 않는 경우 모든 레코드 출력 
SELECT categoryno, rname, email, title, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1, thumb,
          size1, ip, visible
FROM pds4
ORDER BY pdsno DESC;
 
3) 이름 검색
SELECT categoryno, rname, email, title, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1, thumb,
          size1, ip, visible
FROM pds4
WHERE rname LIKE '%아로미%'
ORDER BY pdsno DESC;
     
4) 제목으로 검색   
SELECT categoryno, rname, email, title, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1, thumb,
          size1, ip, visible
FROM pds4
WHERE title LIKE '%패신저스%'
ORDER BY pdsno DESC;
    
5) 내용으로 검색
SELECT categoryno, rname, email, title, content, passwd, cnt, SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1, thumb, size1, ip, visible
FROM pds4
WHERE content LIKE '%우주%'
ORDER BY pdsno DESC;
 
6) 제목, 내용으로 검색
SELECT categoryno, rname, email, title, content, passwd, cnt, SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1, thumb, size1, ip, visible
FROM pds4
WHERE title LIKE '%우주%' OR content LIKE '%우주%'
ORDER BY pdsno DESC;
 
 
9 페이징
   - 목록은 페이징 구현을 필수로 합니다.
   
1) 검색된 전체 레코드 수
SELECT COUNT(pdsno) as cnt 
FROM pds4
WHERE rname LIKE '%왕눈이%';
 
 cnt
 ---
   1
   
2) 페이징
SELECT categoryno, rname, email, title, content, passwd, cnt, SUBSTRING(rdate, 1, 10) as rdate,
           web, file1, fstor1, thumb, size1, ip, visible, grpno, indent, ansnum
FROM pds4
WHERE categoryno = 1 AND rname LIKE '%왕눈이%'
ORDER BY grpno DESC, ansnum ASC
LIMIT 0, 5;
 
 pdsno rname email          title content passwd cnt rdate                 web                 file1     size1  thumb       visible
 ----- ----- -------------- ----- ------- ------ --- --------------------- ------------------- --------- ------ ----------- -------
     1 왕눈이   mail1@mail.com 봄     봄 여행    123      2 2016-04-07 12:09:17.0 http://www.daum.net fun04.jpg 106346 fun04_t.jpg Y
 
     
     
* 컬럼의 추가
ALTER TABLE pds4 
ADD COLUMN 추가할 컬럼명 VARCHAR(100) AFTER visible;


 FK 테이블에서 FK 컬럼관련 카운트 산출
SELECT COUNT(pdsno) as cnt
FROM pds4
WHERE categoryno=1;
 cnt
 ---
   0
   
   10. 답변
   
   1) 기존에 등록된 답변의 seqno 증가 처리
   UPDATE pds4
   SET ansnum = ansnum+1
   WHERE categoryno = 1 AND grpno = 1 AND ansnum > 부모의 ansnum 컬럼의 값;
   
   UPDATE pds4
   SET ansnum = ansnum+1
   WHERE categoryno = 1 AND grpno = 1 AND ansnum > 0;
  
   2) 답변 등록
   INSERT INTO pds4(categoryno, rname, email, title, content, passwd,
                  cnt, rdate, web, file1, fstor1, thumb, size1,
                  map, youtube, mp3, mp4, ip, visible, grpno, indent, ansnum)
   VALUES(1, '왕눈이', 'mail1', '하얀 동그라미 재판', '코카서스의 백묵원', '123', 
           0, now(), 'http://art.incheon.go.kr', 'spring.jpg', 'spring01.jpg', 'spring_m.jpg', 1000,
           'daum map', 'http://', 'song.mp3', 'movie.mp4', '172.16.7.1', 'Y',
           (SELECT IFNULL(MAX(grpno), 0) + 1 FROM pds4 as grpno), 0, 0);
   