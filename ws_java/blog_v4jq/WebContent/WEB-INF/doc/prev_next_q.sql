-- ������(��) ������(��)�� �����ϴ� ��ȸ �������� 3���� SQL ������ �ʿ��մϴ�. 
DROP TABLE prenext;
 
CREATE TABLE prenext(
  prenextno INT NOT NULL AUTO_INCREMENT,
  grp          INT NOT NULL,
  title          VARCHAR(100) NOT NULL,
  PRIMARY KEY(prenextno)
);
 
INSERT INTO prenext(grp, title)
VALUES(1, '���� �� ���� �ɴϴ�.');
 
INSERT INTO prenext(grp, title)
VALUES(1, 'ũ���� ���� Ʈ�� ����');
 
INSERT INTO prenext(grp, title)
VALUES(1, '���� �ʰ��� ������ �ɴϴ�.');
 
INSERT INTO prenext(grp, title)
VALUES(2, '���� ������ ���Դϴ�.');
 
INSERT INTO prenext(grp, title) 
VALUES(2, '���� ���� ���� ���ϴ�.');
 
INSERT INTO prenext(grp, title)
VALUES(2, '�� ķ�ΰ��ϴ�.');
 
SELECT prenextno, grp, title 
FROM prenext 
ORDER BY prenextno ASC;
 
 PRENEXTNO GRP TITLE
 --------- --- ---------------
         1   1 ���� �� ���� �ɴϴ�.
         2   1 ũ���� ���� Ʈ�� ����
         3   1 ���� �ʰ��� ������ �ɴϴ�.
         4   2 ���� ������ ���Դϴ�.
         5   2 ���� ���� ���� ���ϴ�.
         6   2 �� ķ�ΰ��ϴ�.
 
-- �����
SELECT prenextno, grp, title
FROM prenext
WHERE prenextno=4;
 
 prenextno grp title
 --------- --- ------------
         2   1 ũ���� ���� Ʈ�� ���� 
        
 
-- ������
-- 2���� ���� �ʿ���: grp = 1, prenextno = 2;
SELECT MAX(prenextno) as prenextno
FROM prenext
WHERE grp = 2 AND prenextno < 5;
 
 PRENEXTNO
 ---------
         1
 
-- ������
SELECT MIN(prenextno) as prenextno
FROM prenext
WHERE grp = 2 AND prenextno > 5;
 
 PRENEXTNO
 ---------
         3