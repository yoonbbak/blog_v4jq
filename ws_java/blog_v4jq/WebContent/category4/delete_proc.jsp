<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="./ssi.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카테고리</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
  <DIV class='container'>
    <jsp:include page="/menu/top.jsp" flush='false' />
    <DIV class='content'>

      <fieldset class='fieldset_basic'>
        <legend class='legend_basic'>카테고리 삭제</legend>
        <ul>
          <%
            int categoryno = Integer.parseInt(request.getParameter("categoryno"));
//             CategoryVO categoryVO = new CategoryVO();
//             categoryVO.setCategoryno(categoryno);
            int count = categoryProc.delete(categoryno); // 처리된 레코드 갯수

            if (count == 1) {
              response.sendRedirect("./list.jsp");
            } else {
          %>
          <li class='li_none'>카테고리 삭제에 실패했습니다.</li>
          <li class='li_none'>다시한번 시도해주세요.</li>
          <%
            }
          %>
        </ul>
      </fieldset>

      <DIV class='bottom_menu'>
        <button type='button' onclick="history.back();">다시 시도</button>
        <!-- history객체: 이전 페이지로 가라 -->
        <button type='button' onclick="location.href='./list.jsp'">목록</button>
        <!-- location:  -->
      </DIV>

    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->

</body>
</html>