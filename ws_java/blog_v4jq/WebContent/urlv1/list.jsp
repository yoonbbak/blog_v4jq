<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<%
  Connection con = null; // DBMS 연결   
  PreparedStatement pstmt = null; // SQL 실행
  ResultSet rs = null; // SELECT 결과를 저장
  StringBuffer sql = null; // SQL 저장
  int count = 0; // 처리된 레코드 갯수

  String className = "org.gjt.mm.mysql.Driver"; // MySQL 연결 Drvier 
  String url = "jdbc:mysql://localhost:3306/javadb?useUnicode=true&characterEncoding=euckr";
  String user = "root";
  String pass = "1234";
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>즐겨찾기</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
  <DIV class='container'>
    <jsp:include page="/menu/top.jsp" flush='false' />

    <DIV class='content'>
      <DIV class='title_box'>즐 겨 찾 기</DIV>
      <TABLE class='table_basic'>
        <colgroup>
          <col style='width: 5%;'>
          <col style='width: 31%;'>
          <col style='width: 31%;'>
          <col style='width: 18%;'>
          <col style='width: 15%;'>
          <!-- %의 합이 100이 되도록 -->
        </colgroup>
        <thead>
          <TR>
            <TH class='th_basic'>NO</TH>
            <TH class='th_basic'>제목</TH>
            <TH class='th_basic'>주소</TH>
            <TH class='th_basic'>등록일</TH>
            <TH class='th_basic'>기타</TH>
          </TR>
        </thead>
        <tbody>
          <%
            try {
              Class.forName(className); // memory로 클래스를 읽어옴, 객체는 생성하지 않음.
              con = DriverManager.getConnection(url, user, pass); // MySQL 연결
              sql = new StringBuffer();
              sql.append(" SELECT urlno, title, web, rdate"); // 맨 앞에 공백 한 칸이 있어야함.
              sql.append(" FROM url");
              sql.append(" ORDER BY urlno DESC");

              pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
              rs = pstmt.executeQuery(); // SELECT SQL 실행
              while (rs.next()) {
          %>
          <tr>
            <td class='td_basic'><%=rs.getInt("urlno")%></td>
            <td class='td_left'><%=rs.getString("title")%></td>
            <td class='td_left'><a href="<%=rs.getString("web")%>"><%=rs.getString("web")%></a></td>
            <td class='td_basic'><%=rs.getString("rdate").substring(0, 10)%></td>
            <td class='td_basic'><a
              href='./update_form.jsp?urlno=<%=rs.getInt("urlno")%>'>수정</a>
              / <a
              href='./delete_form.jsp?urlno=<%=rs.getInt("urlno")%>'>삭제</a></td>
          </tr>
          <%
            }
            } catch (Exception e) {
              e.printStackTrace();
            } finally {
              try {
                rs.close();
              } catch (Exception e) {
              }

              try {
                pstmt.close();
              } catch (Exception e) {
              }

              try {
                con.close();
              } catch (Exception e) {
              }
            }
          %>
        </tbody>
      </TABLE>
      <DIV class='bottom_menu'>
        <button type='button'
          onclick="location.href='./create_form.jsp'">등록</button>
      </DIV>

    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->
</body>
</html>