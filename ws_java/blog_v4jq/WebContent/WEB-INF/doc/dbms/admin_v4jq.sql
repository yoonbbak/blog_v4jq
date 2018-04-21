[01] DBMS ���� 
 
- Eclipse Project Type: Dynamic Web Project 
  Package: nation.web.admin4
  Menu : /WebContent/menu/top.jsp, bottom.jsp 
  CSS   : /WebContent/css/style.css     
  JSP    : /WebContent/admin4
  ����������: /WebContent/index.jsp
  Library: /WEB-INF/lib/mysql-connector.jar,
            commons-fileupload-1.3.2.jar, commons-io-2.5.jar, javax.mail.jar
  SQL: /WebContent/WEB-INF/doc/dbms/admin_v4jq.sql 
 
  - �������� ��ȣ���� ���Ͽ� �ֹε�Ϲ�ȣ�� �������, �������,
    �̵���Ż���� �����ϰ� ���� �Ұ������� ����ȭ ��. 
        
�� /WebContent/WEB-INF/doc/dbms/admin_v4jq.sql 
-------------------------------------------------------------------------------------------
1. ���̺� ����
1) ���� ���Խ� Master�� ����, ���ĺ��� ������� ���� �����ϸ�
   Master������ �������ؾ� �α��� ����.
 
2) act: ��Ȱ�� ���� 
   M: ������, Y: �α��� ����, N: �α��� �Ұ�, H: ���� ���, G: �մ�
 
 
DROP TABLE admin4; 
 
CREATE TABLE admin4 (
  admin4no INT NOT NULL AUTO_INCREMENT, -- ������ ��ȣ, ���ڵ带 �����ϴ� �÷� 
  mname    VARCHAR(20)   NOT NULL, -- ����, �ѱ� 10�� ���� ����
  email       VARCHAR(50)  UNIQUE NOT NULL, -- �ѹ� ��ϵ� email�� �ߺ� �ȵ�   
  passwd    VARCHAR(60)  NOT NULL, -- �н�����, ������ ���� 
  tel          VARCHAR(14)   NOT NULL, -- ��ȭ��ȣ
  zipcode   VARCHAR(5)        NULL, -- �����ȣ, 12345
  address1  VARCHAR(80)       NULL, -- �ּ� 1
  address2  VARCHAR(50)       NULL, -- �ּ� 2
  auth         VARCHAR(20) NOT NULL, -- ����Ű, ABC + ����ð� 13��
  act           CHAR(1)         DEFAULT 'N' NOT NULL, -- M: ������, Y: �α��� ����, N: �α��� �Ұ�, H: ���� ���, G: �մ�
  confirm    CHAR(1)         DEFAULT 'N' NOT NULL, -- �̸��� ��ũ Ŭ�� ����, Y:Ŭ��, N:Ŭ������
  mdate      DATETIME       NOT NULL, -- ������
  PRIMARY KEY (admin4no)                
); 
 
 
�� ���� ���� 
- NOT NULL: INSERT SQL���� �÷��� �� �ʼ� �Է�. 
- UNIQUE  : �÷��� �ߺ��� ���� �� �� ����. 
- PRIMARY KEY (id): �⺻������ UNIQUE�� ������ �����ϸ鼭 
  ���ڵ带 �����ϴ� ���� �÷��� ��. 
 
 
 
2. INSERT, ���� ������ �߰� 
- Duplicate entry 'test1@mail.com' for key 'email': �̸��� �ߺ� ��� �Ұ���
 
1) �ߺ� �̸��� �˻� ���� SQL 
    -- 0: �ߺ� �ƴ�, 1: �ߺ�  
    SELECT COUNT(email) as cnt
    FROM admin4
    WHERE email = 'test1@mail.com';
 
    cnt
    ---
     1
 
2) MASTER ������ ��ȸ
    SELECT COUNT(admin4no) as cnt
    FROM admin4
    WHERE act = 'M';
 
    cnt
    ---
    0
 
3) ������ ���
   -- Master ����
   INSERT INTO admin4(mname, email, passwd, tel, zipcode,
                               address1, address2, 
                               auth, act, confirm, mdate)   
   VALUES('�մ���', 'test1@gmail.com', '1234', '010-0000-0000', '12345',
              '����� ���α� ��ö��', '13-13',
              'AXD0123456789012', 'M', 'Y', now());
 
   INSERT INTO admin4(mname, email, passwd, tel, zipcode,
                               address1, address2, 
                               auth, act, confirm, mdate)   
   VALUES('�Ʒι�', 'test2@gmail.com', '1234', '010-0000-0000', '12345',
              '����� ���α� ��ö��', '13-13',
              'AXD0123456789012', 'H', 'Y', now());
   
   INSERT INTO admin4(mname, email, passwd, tel, zipcode,
                               address1, address2, 
                               auth, act, confirm, mdate)   
   VALUES('ȫ�浿', 'test3@gmail.com', '1234', '010-0000-0000', '12345',
              '����� ���α� ��ö��', '13-13',
              'AXD0123456789012', 'H', 'Y', now());
               
4) �̸��� ����
  UPDATE admin4
  SET confirm = 'Y'
  WHERE email='test1@gmail.com' AND auth='AXD0123456789012';
 
  
 
    
3. ���
 
1) ȸ�� ��ü ��� 
   SELECT admin4no, mname, email, passwd, tel, zipcode, address1, address2,
             auth, act, confirm, mdate
   FROM admin4
   ORDER BY email ASC;
 
 admin4no mname email           passwd tel           zipcode address1    address2 auth             act confirm mdate
 -------- ----- --------------- ------ ------------- ------- ----------- -------- ---------------- --- ------- ---------------------
        1 �մ���   test1@gmail.com 1234   010-0000-0000 12345   ����� ���α� ��ö�� 13-13    AXD0123456789012 M   Y       2018-04-18 16:07:45.0
        2 �Ʒι�   test2@gmail.com 1234   010-0000-0000 12345   ����� ���α� ��ö�� 13-13    AXD0123456789012 N   Y       2018-04-18 16:08:45.0
        3 ȫ�浿   test3@gmail.com 1234   010-0000-0000 12345   ����� ���α� ��ö�� 13-13    AXD0123456789012 M   Y       2018-04-18 16:08:46.0
 
        
2) ������ ����(admin4DAO: int updateAct(int admin4no, String act))
UPDATE admin4 
SET  act='Y'
WHERE admin4no=1;
 
 
4. ȸ�� ���� ���� 
   SELECT admin4no, mname, email, passwd, tel, zipcode, address1, address2,
             auth, act, confirm, mdate
   FROM admin4
   WHERE admin4no = 1;
   
 
5. �н����� ����
1) ���� �н����� �˻�
- DAO: public int countPasswd(int admin4no, String passwd){ ... }
SELECT count(*) as cnt
FROM admin4
WHERE admin4no = 1 AND passwd='123';
 
2) �н����� ����
- DAO: public int updatePasswd(int admin4no, String passwd){ ... }
UPDATE admin4
SET passwd=''
WHERE admin4no=1;
 
 
6.  ȸ�� ���� ���� 
 
UPDATE admin4
SET mname='', email='', tel='', zipcode='', address1='', address2=''
WHERE admin4no = 1;
 
 
7. 'admin4' ȸ�� ���� 
DELETE FROM admin4;
 
DELETE FROM admin4
WHERE admin4no = 6;
 
 
8. �α��� ���� SQL 
- DAO: public int login(String email, String passwd){ ... }
 
- �α��� üũ
SELECT count(*) as cnt
FROM admin4
WHERE email = 'yoonbbak@gmail.com' AND passwd='1234;
 
- Email ������ �̿��� ��ȸ
SELECT admin4no, email, passwd, auth, act, confirm, mdate
FROM admin4
WHERE email = 'test1@gmail.com';
 
     
9. �˻��� ��ü ���ڵ� ��
   - LIKE    : ��Ȯ�ϰ� ��ġ���� �ʾƵ� ��� 
   - =(equal): ��Ȯ�ϰ� ��ġ�ؾ� ��� 
   - �˻��� ���� �ʴ� ���, ��ü ��� ��� 
 
      
10. �˻� ���(S:Search List)  
 
 
11. ����¡
   - ����� ����¡ ������ �ʼ��� �մϴ�.