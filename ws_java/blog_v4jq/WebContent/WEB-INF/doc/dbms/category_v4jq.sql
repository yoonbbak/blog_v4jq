DROP TABLE IF EXISTS category;
 
/**********************************/
/* Table Name: ī�װ� */
/**********************************/
CREATE TABLE category (
		categoryno  INT              NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'ī�װ���ȣ',
		title            VARCHAR(30) NOT NULL COMMENT '�Խ��� ����',
		seqno         INT              DEFAULT 0 NOT NULL COMMENT '��� ����',
		visible         CHAR(1)        DEFAULT 'Y'      NOT NULL COMMENT '��� ����',
		ids             VARCHAR(200) DEFAULT 'admin' NOT NULL COMMENT '���� ����',
		cnt             INT              DEFAULT 0        NOT NULL COMMENT '��ϵ� �ڷ��' 
) COMMENT='ī�װ�';
 
2) ���̺� ����
DROP TABLE category;
DROP TABLE pds4;
 
 
3) ���
INSERT INTO category(title, seqno, visible, ids, cnt)
VALUES('�ؿ� ��ȭ', 1, 'Y', 'guest', 0);
INSERT INTO category(title, seqno, visible, ids, cnt)
VALUES('���� ��ȭ', 2, 'Y', 'guest', 0);
INSERT INTO category(title, seqno, visible, ids, cnt)
VALUES('�̵�', 3, 'Y', 'guest', 0);
 
 
4) ���
SELECT categoryno, title, seqno, visible, ids, cnt
FROM category
ORDER BY categoryno ASC;
 
 categoryno title seqno visible ids   cnt
 ---------- ----- ----- ------- ----- ---
          1 �ؿ� ��ȭ     1 Y       guest   0
          2 ���� ��ȭ     2 Y       guest   0
          3 �̵�        3 Y       guest   0
 
          
SELECT categoryno, title, seqno, visible, ids, cnt
FROM category
ORDER BY seqno ASC;          
 categoryno title    seqno visible ids   cnt
 ---------- -------- ----- ------- ----- ---
          1 ��ŷ����         1 Y       guest   0
          2 �Ǿ�� ��ŷ����     2 Y       guest   0
          3 ��ŸƮ��         3 Y       guest   0
          4 Gallery      4 Y       guest   0
          5 ����          9 Y       guest   0
 
 
           
5) ��ȸ
SELECT categoryno, title, seqno, visible, ids, cnt
FROM category
WHERE categoryno = 1;
 categoryno title seqno visible ids   cnt
 ---------- ----- ----- ------- ----- ---
          1 ��ŷ����      1 Y       guest   0
 
 
6) ����
UPDATE category
SET title = 'ABC', seqno=0, visible='N', ids='guest'
WHERE categoryno=3;
 
-- ��� ����(Y/N)
UPDATE category
SET visible='Y'
WHERE categoryno=6;
 
-- ���� ���� ����
UPDATE category
SET ids='guest'
WHERE categoryno=1;
 
-- ��ϵ� �� �� ����
UPDATE category
SET cnt = cnt + 1
WHERE categoryno=1;
 
-- ��ϵ� �� �� ����
UPDATE category
SET cnt = cnt - 1
WHERE categoryno=1;
 
-- ��� ������ ����(���߿� ���)
UPDATE category
SET seqno = seqno + 1
WHERE categoryno=3;
 
-- ��� ������ ����(���� ���)
UPDATE category
SET seqno = seqno - 1
WHERE categoryno=1;
 
-- ��ϵ� �� ���� �ʱ�ȭ
UPDATE category
SET cnt=0
WHERE categoryno=9;
 
-- [02] ��� ������ �ִ밪 �ڵ� ���
-- �ִ밪(�׷��Լ�: �������� ���ڵ带 ������� ���� ����)
SELECT MAX(seqno)+1 as seqno 
FROM category;
 
 seqno
 -----
     4
 
     
8) ����
-- ��� ����
DELETE FROM category;
 
-- Ư�� ���ڵ� ����
DELETE FROM category
WHERE categoryno=1;


-- �Ŀ� ����� �� ����
-- FK ���̺��� ���ȵǴ� ���ڵ��� ����
DELETE FROM category
WHERE categoryno=7;
 
 
9) �˻�
-- title �˻�
SELECT categoryno, title, seqno, visible, ids, cnt
FROM category
WHERE title LIKE '%fall%'
ORDER BY categoryno ASC;
 
-- visible �˻�
SELECT categoryno, title, seqno, visible, ids, cnt
FROM category
WHERE visible LIKE '%Y%'
ORDER BY categoryno ASC;
 
-- ���� ���̵� �˻�
SELECT categoryno, title, seqno, visible, ids, cnt
FROM category
WHERE ids LIKE '%admin%'
ORDER BY categoryno ASC;
 
 
10) ����¡
   - ����� ����¡ ������ �ʼ��� �մϴ�.
   
-- �˻��� ��ü ���ڵ� ��
SELECT COUNT(categoryno) as cnt 
FROM category
WHERE title LIKE '%fall%'
 
 cnt
 ---
   1
   
-- ����¡
SELECT categoryno, title, seqno, visible, ids, cnt
FROM category
WHERE title LIKE '%fall%'
ORDER BY seqno ASC
LIMIT 0, 5;