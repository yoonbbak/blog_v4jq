1. �Խ��� ���̺� ����
�� FOREIGN KEY (categoryno) REFERENCES category(categoryno)
    - pds4 ���̺��� categoryno �÷��� ���� category ���̺� ��ϵ�
      categoryno �÷��� ���鸸 �� �� �ֽ��ϴ�.
    - ���� Foreign Key(FK) ���̺� ��ϵ� ���ڵ��� FK �÷��� �̿��Ͽ�
      Primary Key(PK) ���̺� ��ϵ� PK �÷��� ���� ����(JOIN)�Ͽ�
      �׷�ȭ�� ó���� �������� �մϴ�. 
    
 
DROP TABLE pds4; 
 
CREATE TABLE pds4 ( 
  pdsno           INT                 NOT NULL AUTO_INCREMENT COMMENT '�� �Ϸ� ��ȣ', 
  categoryno INT              NOT NULL COMMENT 'ī�װ���ȣ',
  rname            VARCHAR(20)    NOT NULL COMMENT '�۾���',
  email               VARCHAR(100)          NULL COMMENT '�̸���',  
  title                  VARCHAR(200)  NOT NULL COMMENT '����', 
  content          VARCHAR(4000) NOT NULL COMMENT '�� ����', 
  passwd          VARCHAR(15)    NOT NULL COMMENT '�� �Ϸ� ��ȣ', 
  cnt                    INT                 DEFAULT 0 NOT NULL COMMENT '��ȸ��', 
  rdate                DATETIME        NOT NULL COMMENT '��� ��¥', 
  web                  VARCHAR(100)        NULL COMMENT 'URL',
  file1                   VARCHAR(100)         NULL COMMENT '���ϸ�',
  fstor1                VARCHAR(100)         NULL COMMENT '���� ���� ���ϸ�',
  thumb               VARCHAR(100)          NULL COMMENT 'preview',
  size1                  BIGINT            DEFAULT 0 NOT NULL COMMENT '���� ũ�� 1',
  map                    VARCHAR(1024)        NULL COMMENT '���� ����',
  youtube            VARCHAR(512)          NULL COMMENT 'Google Youtube',
  mp3                    VARCHAR(50)            NULL COMMENT 'MP3 ���ϸ�',
  mp4                    VARCHAR(50)            NULL COMMENT 'MP4 ����',  
  ip                          VARCHAR(15)    NOT NULL COMMENT '000.000.000.000', 
  visible                CHAR(1)            DEFAULT 'Y' NOT NULL COMMENT '�����',  
  PRIMARY KEY (pdsno),
  FOREIGN KEY (categoryno) REFERENCES category(categoryno)
) COMMENT='ī�װ�'; 
 
- Cannot add foreign key constraint: PK ���̺��� ����.
 
 
2. �� �߰�(C: Create) 
SELECT categoryno, title, seqno, visible, ids, cnt
FROM category
ORDER BY categoryno ASC;
 
 categoryno title seqno visible ids   cnt
 ---------- ----- ----- ------- ----- ---
          1 �ؿ� ��ȭ     1 Y       guest   0
          2 ���� ��ȭ     2 Y       guest   0
          3 �̵�        3 Y       guest   0
      
          
INSERT INTO pds4(categoryno, rname, email, title, content, passwd,
                  cnt, rdate, web, file1, fstor1, thumb, size1,
                  map, youtube, mp3, mp4, ip, visible)
VALUES(10, '�մ���', 'mail1', '�Ͼ� ���׶�� ����', '��ī������ �鹬��', '123',
           0, now(), 'http://art.incheon.go.kr', 'spring.jpg', 'spring01.jpg', 'spring_m.jpg', 1000,
           'daum map', 'http://', 'song.mp3', 'movie.mp4', '172.16.7.1', 'Y');
            
INSERT INTO pds4(categoryno, rname, email, title, content, passwd,
                  cnt, rdate, web, file1, fstor1, thumb, size1,
                  map, youtube, mp3, mp4, ip, visible)
VALUES(1, '�Ʒι�', 'mail1', '�Ͼ� ���׶�� ����', '��ī������ �鹬��', '123',
           0, now(), 'http://art.incheon.go.kr', 'spring.jpg', 'spring01.jpg', 'spring_m.jpg', 1000,
           'daum map', 'http://', 'song.mp3', 'movie.mp4', '172.16.7.1', 'Y');
            
INSERT INTO pds4(categoryno, rname, email, title, content, passwd,
                  cnt, rdate, web, file1, fstor1, thumb, size1,
                  map, youtube, mp3, mp4, ip, visible)
VALUES(2, '������', 'mail1', '�н�����2016', '���� �Ĺ����� ���� ����', '123',
           0, now(), 'http://art.incheon.go.kr', 'spring.jpg', 'spring01.jpg', 'spring_m.jpg', 1000,
           'daum map', 'http://', 'song.mp3', 'movie.mp4', '172.16.7.1', 'Y');
            
            
3. ��ü �� ���(S:Total Select List), �ֽű� ���� ��� 
   - ASC: ���� ����, DESC: ���� ���� 
   - substring(�÷���, ������ġ, ����), ������ġ 1���� ����: ���ڿ� �Ϻθ� ����
   - �Լ� ���� �÷����� �ſ� ��������� 
     'SUBSTRING(rdate, 1, 10)' ������ as Ű����� 'rdate' ��ȯ�մϴ�. 
 
SELECT pdsno, categoryno, rname, email, title, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1,
          thumb, size1, map, youtube, mp3, mp4, ip, visible
FROM pds4
ORDER BY pdsno DESC;
 
 pdsno categoryno rname email title      content   passwd cnt rdate      web                      file1      fstor1       thumb        size1 map      youtube mp3      mp4       ip         visible
 ----- ---------- ----- ----- ---------- --------- ------ --- ---------- ------------------------ ---------- ------------ ------------ ----- -------- ------- -------- --------- ---------- -------
     3          1 ȫ�浿   mail1 �Ͼ� ���׶�� ���� ��ī������ �鹬�� 123      0 2017-02-23 http://art.incheon.go.kr spring.jpg spring01.jpg spring_m.jpg  1000 daum map http:// song.mp3 movie.mp4 172.16.7.1 Y
     2          1 �Ʒι�   mail1 �Ͼ� ���׶�� ���� ��ī������ �鹬�� 123      0 2017-02-23 http://art.incheon.go.kr spring.jpg spring01.jpg spring_m.jpg  1000 daum map http:// song.mp3 movie.mp4 172.16.7.1 Y
     1          1 �մ���   mail1 �Ͼ� ���׶�� ���� ��ī������ �鹬�� 123      0 2017-02-23 http://art.incheon.go.kr spring.jpg spring01.jpg spring_m.jpg  1000 daum map http:// song.mp3 movie.mp4 172.16.7.1 Y
 
SELECT pdsno, categoryno, rname, email, title, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1,
          thumb, size1, map, youtube, mp3, mp4, ip, visible
FROM pds4
ORDER BY pdsno DESC;
 
-- ī�װ��� ���
SELECT pdsno, categoryno, rname, email, title, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1,
          thumb, size1, map, youtube, mp3, mp4, ip, visible
FROM pds4 
WHERE categoryno = 1
ORDER BY pdsno DESC;
 
SELECT pdsno, categoryno, rname, email, title, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1,
          thumb, size1, map, youtube, mp3, mp4, ip, visible
FROM pds4
WHERE categoryno = 2
ORDER BY pdsno DESC;
      
 
4. pds4 ��ȸ
 
1) ��ȸ�� ���� 
UPDATE pds4
SET cnt = cnt + 1
WHERE pdsno=51;
 
2) 1���� �� ����(R:Read, PK ���) 
SELECT pdsno, categoryno, rname, email, title, content, passwd,
          cnt, rdate, web, file1, fstor1, thumb, size1, map, youtube,
          mp3, mp4, ip, visible
FROM pds4
WHERE pdsno=51;

3) Mp4 �÷� Ȯ��
SELECT pdsno, mp4
FROM pds4
LIMIT 0, 5;

 
 pdsno categoryno rname email title      content   passwd cnt rdate                 web                      file1      fstor1       thumb        size1 map      youtube mp3      mp4       ip         visible
 ----- ---------- ----- ----- ---------- --------- ------ --- --------------------- ------------------------ ---------- ------------ ------------ ----- -------- ------- -------- --------- ---------- -------
     1          1 �մ���   mail1 �Ͼ� ���׶�� ���� ��ī������ �鹬�� 123      0 2017-02-23 15:06:21.0 http://art.incheon.go.kr spring.jpg spring01.jpg spring_m.jpg  1000 daum map http:// song.mp3 movie.mp4 172.16.7.1 Y
     
 
5. �н����� �˻�
   - COUNT(): �߻��� ���ڵ��� ���� ���, ���ڵ尡 ������ 0 ���
   
SELECT COUNT(*) as cnt 
FROM pds4
WHERE pdsno=1 AND passwd='123';
 
 cnt
 ---
   0
 
   
6. �� ����(U:Update), PK�� ���ڵ带 �����ϴ� ���� ����� ������ �������� 
   �����ϴ� ���� �������� ����. 
    
1) �۸� ���� 
UPDATE pds4
SET rname='����', email='mail1@mail.com', title='���񺯰�',
      content='���� ����', web='http://www.kma.go.kr',
      /*ip����ȵ˴ϴ�*/
WHERE pdsno=1;
  
2) Visible ����
UPDATE pds4
SET visible = 'Y'
WHERE pdsno=1;
 
3) ���� ����
UPDATE pds4
SET file1='', fstor1='', thumb='', size1=123
WHERE pdsno=1;

4) ���� ����
UPDATE pds4
SET file1='test.jpg', fstor1='test1.jpg', thumb='test_m.jpg', size1=123
WHERE pdsno=1;
 
5) MP3 ����
UPDATE pds4
SET mp3=''
WHERE pdsno=1;
 
6) MP4 ����
UPDATE pds4
SET mp4=''
WHERE pdsno=1;
 
7) ���� ����
UPDATE pds4
SET map=''
WHERE pdsno=1;
 
8) ���� ����
UPDATE pds4
SET map=''
WHERE pdsno=1;
 
7. �� ����(D:Delete) 
DELETE FROM pds4
WHERE pdsno = 1;
 
DELETE FROM pds4
WHERE pdsno <= 4;
 
DELETE FROM pds4
WHERE pdsno >= 11;
 
 
8. �˻� �� ���(S:Search List) 
    - ����� ���۽� �˻��� ������� �����ϸ� ��ü ������
      ��ü �˻����� �����ϴ�.
    - rname, title, content �÷� ���
 
1) ����: 
    - WHERE rname LIKE '�մ���'
       rname �÷��� ���� '�մ���'�� ���ڵ� ���� ���
 
    - WHERE rname LIKE '%�մ���%'
      rname �÷��� ���� '�մ���'�� �� ���ڵ� ���� ���
 
    - WHERE rname LIKE '�մ���%'
      rname �÷��� ���� '�մ���'�� �����ϴ� ���ڵ� ���� ���
 
    - WHERE rname LIKE '%�մ���'
      rname �÷��� ���� '�մ���'�� �����ϴ� ���ڵ� ���� ���
   
 
2) �˻��� ���� �ʴ� ��� ��� ���ڵ� ��� 
SELECT categoryno, rname, email, title, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1, thumb,
          size1, ip, visible
FROM pds4
ORDER BY pdsno DESC;
 
3) �̸� �˻�
SELECT categoryno, rname, email, title, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1, thumb,
          size1, ip, visible
FROM pds4
WHERE rname LIKE '%�Ʒι�%'
ORDER BY pdsno DESC;
     
4) �������� �˻�   
SELECT categoryno, rname, email, title, content, passwd, cnt, 
          SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1, thumb,
          size1, ip, visible
FROM pds4
WHERE title LIKE '%�н�����%'
ORDER BY pdsno DESC;
    
5) �������� �˻�
SELECT categoryno, rname, email, title, content, passwd, cnt, SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1, thumb, size1, ip, visible
FROM pds4
WHERE content LIKE '%����%'
ORDER BY pdsno DESC;
 
6) ����, �������� �˻�
SELECT categoryno, rname, email, title, content, passwd, cnt, SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1, thumb, size1, ip, visible
FROM pds4
WHERE title LIKE '%����%' OR content LIKE '%����%'
ORDER BY pdsno DESC;
 
 
9 ����¡
   - ����� ����¡ ������ �ʼ��� �մϴ�.
   
1) �˻��� ��ü ���ڵ� ��
SELECT COUNT(pdsno) as cnt 
FROM pds4
WHERE rname LIKE '%�մ���%';
 
 cnt
 ---
   1
   
2) ����¡
SELECT categoryno, rname, email, title, content, passwd, cnt, SUBSTRING(rdate, 1, 10) as rdate, web, file1, fstor1, thumb, size1, ip, visible 
FROM pds4
WHERE rname LIKE '%�մ���%'
ORDER BY pdsno DESC
LIMIT 0, 5;
 
 pdsno rname email          title content passwd cnt rdate                 web                 file1     size1  thumb       visible
 ----- ----- -------------- ----- ------- ------ --- --------------------- ------------------- --------- ------ ----------- -------
     1 �մ���   mail1@mail.com ��     �� ����    123      2 2016-04-07 12:09:17.0 http://www.daum.net fun04.jpg 106346 fun04_t.jpg Y
 
     
     
* �÷��� �߰�
ALTER TABLE pds4 
ADD COLUMN �߰��� �÷��� VARCHAR(100) AFTER visible;


 FK ���̺��� FK �÷����� ī��Ʈ ����
SELECT COUNT(pdsno) as cnt
FROM pds4
WHERE categoryno=1;
 cnt
 ---
   0