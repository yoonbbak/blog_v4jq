[����] ��� ã�� ���� ver 1.0 (���� JSP�� ���), MySQL + JSP Model 1
- Eclipse Project Type: Dynamic Web Project 
  JSP    : /WebContent/urlv1
 
1. url ���̺� ���� 
�� /WebContent/WEB-INF/doc/url_v1jq.sql 
--------------------------------------------------------------------
2) url ���̺��� ����
   - ����� �����
   - PRIMARY KEY(urlno): urlno�÷��� ���� 2���̻� ��ϵǴ� ���� ����.
   
   CREATE TABLE url( 
     urlno  INT             NOT NULL AUTO_INCREMENT, -- URL ��ȣ
     title    VARCHAR(100)  NOT NULL, -- �� ����Ʈ ���� ��) ���û
     web    VARCHAR(200)    NOT NULL, -- URL �ּ� ��) http://www.weather.go.kr
     rdate  DATETIME        NOT NULL, -- �����
     PRIMARY KEY(urlno)
   );  
   
   
   select * from url;
