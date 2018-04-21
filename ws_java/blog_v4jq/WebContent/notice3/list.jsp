<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="./ssi.jsp"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항3</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
  <DIV class='container'>
    <jsp:include page="/menu/top.jsp" flush='false' />

    <DIV class='content'>
      <DIV class='title_box'>공 지 사 항 3</DIV>
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
            ArrayList<NoticeVO> list = noticeDAO.list();
            AdminProc adminProc_auth = new AdminProc();
            int cnt = list.size();

            // 자바에 있는 DB를 HTML로 출력
            for (int index = 0; index < cnt; index++) {
              NoticeVO noticeVO = list.get(index);
              int noticeno = noticeVO.getNoticeno(); // PK는 참조할 일이 많으므로 독립 변수로 선언해 준다.
          %>
          <tr>
            <td class='td_basic'><%=noticeno%></td>
            <td class='td_left'><%=noticeVO.getTitle()%></td>
            <td class='td_basic'><%=noticeVO.getRname()%></td>
            <td class='td_basic'><%=noticeVO.getRdate()%></td>
            <td class='td_basic'>
              <a <%if (AdminTool.isMaster(request) || AdminTool.isAdmin(request)) {%>
                href='./update_form.jsp?noticeno=<%=noticeno%>'>수정</a> / <a <%}%>
                <%if (AdminTool.isMaster(request) || AdminTool.isAdmin(request)) {%>
                href='./delete_form.jsp?noticeno=<%=noticeno%>'>삭제</a>
            </td>
            <%
              }
            %>
          </tr>
          <%
            }
          %>
        </tbody>
      </TABLE>
      <%
        if (AdminTool.isMaster(request) || AdminTool.isAdmin(request)) {
      %>
      <DIV class='bottom_menu'>
        <button type='button' onclick="location.href='./create_form.jsp'">등록</button>
      </DIV>
      <%
        }
      %>
    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->
</body>
</html>