<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="./ssi.jsp" %>
<%-- <%@ page import="java.sql.Connection"%> --%>
<%-- <%@ page import="java.sql.DriverManager"%> --%>
<%-- <%@ page import="java.sql.PreparedStatement"%> --%>

<!-- import -->
<%-- <%@ page import="nation.web.tool.DBOpen"%> --%>
<%-- <%@ page import="nation.web.tool.DBClose"%> --%>

<%
//   request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항3z</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
  <DIV class='container'>
    <jsp:include page="/menu/top.jsp" flush='false' />
    <DIV class='content'>

      <fieldset style='width: 70%; margin: 10px auto;'>
        <legend class="legend_basic">공지사항3z 삭제</legend>
        <ul>
          <%
            int noticeno = Integer.parseInt(request.getParameter("noticeno"));

            NoticeVO noticeVO = new NoticeVO(); 
            
            // ***noticeno를 받아야 함.
            noticeVO.setNoticeno(noticeno);
            
            int count = noticeDAO.delete(noticeVO);
//             Connection con = null; // DBMS 연결   
//             PreparedStatement pstmt = null; // SQL 실행
//             StringBuffer sql = null; // SQL 저장
//             int count = 0; // 처리된 레코드 갯수

//             con = new DBOpen().getConnection();
//             //       String className = "org.gjt.mm.mysql.Driver"; // MySQL 연결 Drvier 
//             //       String url = "jdbc:mysql://localhost:3306/javadb?useUnicode=true&characterEncoding=euckr"; 
//             //       String user = "root"; 
//             //       String pass = "1234";

//             try {
//               //         Class.forName(className); // memory로 클래스를 읽어옴, 객체는 생성하지 않음.
//               //         con = DriverManager.getConnection(url, user, pass);  // MySQL 연결
//               sql = new StringBuffer();
//               sql.append(" DELETE FROM notice");
//               sql.append(" WHERE noticeno = ?");

//               pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
//               pstmt.setInt(1, noticeno);

//               count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행

              if (count == 1) {
          %>
          <li class='li_none'>삭제 처리에 성공했습니다.</li>
          <%
            } else {
          %>
          <li class='li_none'>공지사항 삭제에 실패했습니다.</li>
          <li class='li_none'>다시한번 시도해주세요.</li>
          <%
            }

//             } catch (Exception e) {
//               e.printStackTrace();
//             } finally {
              
//               new DBClose().close(con, pstmt);
//               //         try {
//               //           pstmt.close();
//               //         } catch (Exception e) {
//               //         }

//               //         try {
//               //           con.close();
//               //         } catch (Exception e) {
//               //         }
//             }
          %>
        </ul>
      </fieldset>

      <DIV class='bottom_menu'>
        <button type='button' onclick="location.href='./list.jsp'">목록</button>
      </DIV>

    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->

</body>
</html>