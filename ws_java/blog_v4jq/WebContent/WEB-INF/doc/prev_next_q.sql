-- 이전글(◀) 다음글(▶)이 등장하는 조회 페이지는 3번의 SQL 실행이 필요합니다. 
DROP TABLE prenext;
 
CREATE TABLE prenext(
  prenextno INT NOT NULL AUTO_INCREMENT,
  grp          INT NOT NULL,
  title          VARCHAR(100) NOT NULL,
  PRIMARY KEY(prenextno)
);
 
INSERT INTO prenext(grp, title)
VALUES(1, '내일 눈 많이 옵니다.');
 
INSERT INTO prenext(grp, title)
VALUES(1, '크리스 마스 트리 제작');
 
INSERT INTO prenext(grp, title)
VALUES(1, '내일 초강력 강추위 옵니다.');
 
INSERT INTO prenext(grp, title)
VALUES(2, '드디어 따뜻한 봄입니다.');
 
INSERT INTO prenext(grp, title) 
VALUES(2, '봄날 벗꽃 여행 갑니다.');
 
INSERT INTO prenext(grp, title)
VALUES(2, '봄 캠핑갑니다.');
 
SELECT prenextno, grp, title 
FROM prenext 
ORDER BY prenextno ASC;
 
 PRENEXTNO GRP TITLE
 --------- --- ---------------
         1   1 내일 눈 많이 옵니다.
         2   1 크리스 마스 트리 제작
         3   1 내일 초강력 강추위 옵니다.
         4   2 드디어 따뜻한 봄입니다.
         5   2 봄날 벗꽃 여행 갑니다.
         6   2 봄 캠핑갑니다.
 
-- 현재글
SELECT prenextno, grp, title
FROM prenext
WHERE prenextno=4;
 
 prenextno grp title
 --------- --- ------------
         2   1 크리스 마스 트리 제작 
        
 
-- 이전글
-- 2개의 값이 필요함: grp = 1, prenextno = 2;
SELECT MAX(prenextno) as prenextno
FROM prenext
WHERE grp = 2 AND prenextno < 5;
 
 PRENEXTNO
 ---------
         1
 
-- 다음글
SELECT MIN(prenextno) as prenextno
FROM prenext
WHERE grp = 2 AND prenextno > 5;
 
 PRENEXTNO
 ---------
         3