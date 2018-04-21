<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="./ssi.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">
</head>
<body>
  <DIV class='container'>
    <jsp:include page="/menu/top.jsp" flush='false' />
    <DIV class='content'>
      <%
        ArrayList<Pds4VO> list = pds4Proc.list();
      %>
      <DIV class='title_box'>게시판(전체 목록)</DIV>
      <TABLE class='table_basic'>
        <colgroup>
          <col style='width: 10%;' />
          <col style='width: 40%;' />
          <col style='width: 10%;' />
          <col style='width: 10%;' />
          <col style='width: 20%;' />
          <col style='width: 10%;' />
        </colgroup>
        <thead>
          <TR>
            <TH class='th_basic'>번호</TH>
            <TH class='th_basic'>제목</TH>
            <TH class='th_basic'>성명</TH>
            <TH class='th_basic'>조회</TH>
            <TH class='th_basic'>등록일</TH>
            <TH class='th_basic'>기타</TH>
          </TR>
        </thead>
        <tbody>
          <%
            int cnt = list.size();
            // 자바에 있는 DB를 HTML로 출력
            for (int index = 0; index < cnt; index++) {
              Pds4VO pds4VO = list.get(index);
              int pdsno = pds4VO.getPdsno(); //PK
          %>
          <tr>
            <td class='td_basic'><%=pdsno%></td>
            <td class='td_left'><%=pds4VO.getTitle()%></td>
            <td class='td_basic'><%=pds4VO.getRname()%></td>
            <td class='td_basic'><%=pds4VO.getCnt()%></td>
            <td class='td_basic'><%=pds4VO.getRdate()%></td> 
            <td class='td_basic'>
              <a href='./update_form.jsp?pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>'> <IMG src='./images/update.png' style='width: 16px;' title="수정"></a>
              <a href='./delete_form.jsp?pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>'> <IMG src='./images/delete.png' style='width: 16px;' title="삭제"></a>
            </td>
          </tr>
          <%
            }
          %>
        </tbody>
        <tfoot>
        </tfoot>
      </TABLE>
      <DIV class='bottom_menu'>
        <button type='button' onclick="location.href='./create_form.jsp?categoryno=7'">등록</button>
      </DIV>
    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->
</body>
</html>
