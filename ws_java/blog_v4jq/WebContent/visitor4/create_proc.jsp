<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="./ssi.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>방명록</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
  <DIV class='container'>
    <jsp:include page="/menu/top.jsp" flush='false' />

    <DIV class='content'>

      <fieldset style='width: 70%; margin: 10px auto;'>
        <legend class="legend_basic">방명록 등록</legend>
        <ul>
          <%
            String content = request.getParameter("content");
            String rname = request.getParameter("rname");
            String passwd = request.getParameter("passwd");
            String email = request.getParameter("email");
            String home = request.getParameter("home");

            VisitorVO visitorVO = new VisitorVO();
            visitorVO.setContent(content);
            visitorVO.setRname(rname);
            visitorVO.setPasswd(passwd);
            visitorVO.setEmail(email);
            visitorVO.setHome(home);

            int count = visitorProc.insert(visitorVO);

            if (count == 1) {
              response.sendRedirect("./list.jsp");
          %>
          <!--           <li class='li_none'>방명록 등록에 성공했습니다.</li> -->
          <%
            } else {
          %>
          <li class='li_none'>방명록 등록에 실패했습니다.</li>
          <li class='li_none'>다시 시도해주세요.</li>
          <%
            }
          %>
        </ul>
      </fieldset>

      <DIV
        style='margin: 30px auto; text-align: center; background-color: #FFFFFF'>
        <button type='button'
          onclick="location.href='./create_form.jsp'">계속 등록</button>
        <button type='button' onclick="location.href='./list.jsp'">목록</button>
      </DIV>

    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->

</body>
</html>