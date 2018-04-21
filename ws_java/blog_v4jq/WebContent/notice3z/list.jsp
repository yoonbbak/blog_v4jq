<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="./ssi.jsp" %>
<%-- <%@ page import="java.sql.Connection"%> --%>
<%-- <%@ page import="java.sql.DriverManager"%> --%>
<%-- <%@ page import="java.sql.PreparedStatement"%> --%>
<%-- <%@ page import="java.sql.ResultSet"%> --%>

<!-- import -->
<%-- <%@ page import="nation.web.tool.DBOpen" %>  --%>
<%-- <%@ page import="nation.web.tool.DBClose" %> --%>

<%
//   Connection con = null; // DBMS 연결   
//   PreparedStatement pstmt = null; // SQL 실행
//   ResultSet rs = null; // SELECT 결과를 저장
//   StringBuffer sql = null; // SQL 저장
//   int count = 0; // 처리된 레코드 갯수
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
      <DIV class='title_box'>공 지 사 항 3z</DIV>
      <TABLE class='table_basic'>
        <colgroup>
          <col style='width: 5%;'>
          <col style='width: 50%;'>
          <col style='width: 12%;'>
          <col style='width: 18%;'>
          <col style='width: 15%;'>
          <!-- %의 합이 100이 되도록 -->
        </colgroup>
        <thead>
          <TR>
            <TH class='th_basic'>NO</TH>
            <TH class='th_basic'>내용</TH>
            <TH class='th_basic'>성명</TH>
            <TH class='th_basic'>등록일</TH>
            <TH class='th_basic'>기타</TH>
          </TR>
        </thead>
        <tbody>
          <%
//             NoticeVO noticeVO = new NoticeVO();
//             ArrayList<NoticeVO> list = new ArrayList<NoticeVO>();
//             list.add(noticeVO); (x)

//             try {
//               con = new DBOpen().getConnection(); // 추가
              
//               sql = new StringBuffer();
//               sql.append(" SELECT noticeno, title, rname, rdate"); // 맨 앞에 공백 한 칸이 있어야함.
//               sql.append(" FROM notice");
//               sql.append(" ORDER BY noticeno DESC");

//               pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
//               rs = pstmt.executeQuery(); // SELECT SQL 실행
//               while (rs.next()) {
  
            ArrayList<NoticeVO> list = noticeDAO.list();
            
            int cnt = list.size();
            
            for (int i=0; i < cnt; i++){
              NoticeVO noticeVO = list.get(i);
              int noticeno = noticeVO.getNoticeno();
          %>
          <tr>
            <td class='td_basic'><%=noticeVO.getNoticeno()/* rs.getInt("noticeno") */%></td>
            <td class='td_left'><%=noticeVO.getTitle()/* rs.getString("title") */%></td>
            <td class='td_basic'><%=noticeVO.getRname()/* rs.getString("rname") */%></td>
            <td class='td_basic'><%=noticeVO.getRdate()/* rs.getString("rdate").substring(0, 10) */%></td>
            <td class='td_basic'><a
              href='./update_form.jsp?noticeno=<%=noticeVO.getNoticeno()/* rs.getInt("noticeno") */%>'>수정</a>
              / <a
              href='./delete_form.jsp?noticeno=<%=noticeVO.getNoticeno()/* rs.getInt("noticeno") */%>'>삭제</a></td>
          </tr>
          <%
            }
//             }
//             } catch (Exception e) {
//               e.printStackTrace();
//             } finally {
//               new DBClose().close(con, pstmt, rs); // 추가
//             }
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