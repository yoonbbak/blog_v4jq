-----------------------------------------------------------------------------------
1) news ���̺��� ���� 
   - ������ ���̺� ����
     DROP TABLE visitor;
   
   CREATE TABLE visitor( 
     visitorno  INT     NOT NULL AUTO_INCREMENT PRIMARY KEY, -- �������� ��ȣ
     content   VARCHAR(1000)  NOT NULL, -- ����, 1000 ��
     rname     VARCHAR(15)    NOT NULL, -- �����
     passwd   VARCHAR(15)    NOT NULL, -- �н�����
     home     VARCHAR(200)          NULL, -- Homepage
     email     VARCHAR(100)           NULL, -- Email
     rdate     DATETIME         NOT NULL  -- �����
   );  
 
    
2) ���̺� ����
   DROP TABLE visitor;
 
 
3) ���
   INSERT INTO visitor(content, rname, passwd, home, email, rdate)
   VALUES('������ ���� ����', '�մ���', '123', 'http://www.kma.go.kr', 'mail1', now());
 
   INSERT INTO visitor(content, rname, passwd, home, email, rdate)
   VALUES('�߿� ���� ����', '�մ���', '123', 'http://www.kma.go.kr', 'mail1', now());
 
   INSERT INTO visitor(content, rname, passwd, home, email, rdate)
   VALUES('��� �̺�', '�մ���', '123', 'http://www.kma.go.kr', 'mail1', now());
 
   select * from visitor;
    
4) ���
   SELECT visitorno, content, rname, passwd, home, email, rdate
   FROM visitor 
   ORDER BY visitorno ASC;
   
 visitorno content   rname passwd home                 email rdate
 --------- --------- ----- ------ -------------------- ----- ---------------------
         1 ������ ���� ���� �մ���   123    http://www.kma.go.kr mail1 2017-08-30 17:10:42.0
         2 �߿� ���� ����  �մ���   123    http://www.kma.go.kr mail1 2017-08-30 17:10:43.0
         3 ��� �̺�     �մ���   123    http://www.kma.go.kr mail1 2017-08-30 17:10:44.0
 
   SELECT visitorno, content, rname, passwd, home, email, rdate
   FROM visitor 
   ORDER BY visitorno DESC;
 
 visitorno content   rname passwd home                 email rdate
 --------- --------- ----- ------ -------------------- ----- ---------------------
         3 ��� �̺�     �մ���   123    http://www.kma.go.kr mail1 2017-08-30 17:10:44.0
         2 �߿� ���� ����  �մ���   123    http://www.kma.go.kr mail1 2017-08-30 17:10:43.0
         1 ������ ���� ���� �մ���   123    http://www.kma.go.kr mail1 2017-08-30 17:10:42.0
  
5) ��ȸ
   SELECT visitorno, content, rname, passwd, home, email, rdate
   FROM visitor 
   WHERE visitorno = 1;
   
 visitorno content   rname passwd home                 email rdate
 --------- --------- ----- ------ -------------------- ----- ---------------------
         1 ������ ���� ���� �մ���   123    http://www.kma.go.kr mail1 2017-08-30 17:10:42.0
 
6) �н����� �˻�
   SELECT COUNT(*)
   FROM visitor
   WHERE visitorno=1 AND passwd='123';
   
   COUNT(newsno) �� �÷���
   -------------------
            1
   
   -- cnt: �ӽ÷� ������� �÷��� 
   SELECT COUNT(*) as cnt  
   FROM visitor
   WHERE visitorno=1 AND passwd='123';
   
   cnt
   ----
     1    �� ���ڵ尡 ���ų� ��ġ���������� 0
         
7) ����
   UPDATE visitor
   SET content = '���� 2', rname = '�Ʒι�', home='http://~', email='maeil1' 
   WHERE visitorno = 1;
 
8) ����
�� �ϳ��� ���ڵ� ����
    DELETE FROM visitor
    WHERE visitorno = 1;
 
�� ��� ���ڵ� ����(����)
    DELETE FROM visitor;
     
 
  
-----------------------------------------------------------------------------------