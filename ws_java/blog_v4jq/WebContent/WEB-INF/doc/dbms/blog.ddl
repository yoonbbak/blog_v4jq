DROP TABLE IF EXISTS category;

/**********************************/
/* Table Name: ī�װ� */
/**********************************/
CREATE TABLE category(
		categoryno                    		INT		 NOT NULL		 PRIMARY KEY AUTO_INCREMENT COMMENT 'ī�װ� ��ȣ',
		title                         		VARCHAR(30)		 NOT NULL COMMENT '�Խ��� ����',
		seqno                         		INT		 DEFAULT 0		 NOT NULL COMMENT '��� ����',
		visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL COMMENT '��� ����',
		ids                           		VARCHAR(200)		 DEFAULT 'admin'		 NOT NULL COMMENT '���� ����',
		cnt                           		INT		 DEFAULT 0		 NOT NULL COMMENT '��ϵ� �ڷ��'
) COMMENT='ī�װ�';

select * from category;