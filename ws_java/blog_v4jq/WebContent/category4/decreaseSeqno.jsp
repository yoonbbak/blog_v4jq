<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="./ssi.jsp"%>

<%
  int categoryno = Integer.parseInt(request.getParameter("categoryno"));
  categoryProc.decreaseSeqno(categoryno);
  response.sendRedirect("./list.jsp");
%>

<!-- html에서는 바로 java코드에 호출, 접근할 수 없다. 대신 JSP를 호출한다 -->
<!-- 만약 model2의 핵심인 Servlet을 사용한다면 html에서 java코드를 바로 호출할 수 있다. -->