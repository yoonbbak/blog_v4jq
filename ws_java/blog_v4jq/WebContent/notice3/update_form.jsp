<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="./ssi.jsp"%>

<%
  // 수정할 레코드의 pk 컬럼의 값
  int noticeno = Integer.parseInt(request.getParameter("noticeno"));
  NoticeVO noticeVO = noticeDAO.read(noticeno);
%>

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

      <form name='frm' action='./update_proc.jsp' method='POST'>
        <input type='hidden' name='noticeno' id='noticeno'
          value='<%=noticeno%>'>

        <fieldset style='width: 70%; margin: 10px auto;'>
          <legend class="legend_basic">공지사항3 수정</legend>
          <ul>
            <li class="li_none">
              <label for="title"> 내용: </label>
              <input type="text" name="title" id="title"
                value="<%=noticeVO.getTitle()%>" style="width: 80%;">
            </li>
            <li class="li_none">
              <label for="name"> 성명: </label>
              <input type="text" name="name" id="name"
                value="<%=noticeVO.getRname()%>">
            </li>
          </ul>
        </fieldset>

        <DIV class='bottom_menu'>
          <button type='submit'>저장</button>
          <button type='button' onclick="location.href='./list.jsp'">취소</button>
        </DIV>
      </form>

    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->

</body>
</html>