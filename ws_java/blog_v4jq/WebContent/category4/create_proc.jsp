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

      <fieldset style='width: 70%; margin: 10px auto;'>
        <legend class="legend_basic">카테고리 등록</legend>
        <ul>
          <%
            String title = request.getParameter("title");
            int seqno = Integer.parseInt(request.getParameter("seqno"));
            String visible = request.getParameter("visible");
            String ids = request.getParameter("ids");

            CategoryVO categoryVO = new CategoryVO(); 
            categoryVO.setTitle(title);
            categoryVO.setSeqno(seqno);
            categoryVO.setVisible(visible);
            categoryVO.setIds(ids);

            // categoryDAO가 아닌 categoryProc    
            int count = categoryProc.insert(categoryVO);

            if (count == 1) {
              response.sendRedirect("./list.jsp"); // 등록 처리 성공하면 자동으로 페이지 이동
          %>
          <!--           <li class='li_none'>등록처리에 성공했습니다.</li> -->
          <%
            } else {
          %>
          <li class='li_none'>등록처리에 실패했습니다.</li>
          <li class='li_none'>다시한번 시도해주세요.</li>
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