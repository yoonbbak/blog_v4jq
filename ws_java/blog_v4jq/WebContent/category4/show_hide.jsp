<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="./ssi.jsp"%>

<%
  int categoryno = Integer.parseInt(request.getParameter("categoryno"));
  String visible = request.getParameter("visible");

  if (visible.equals("Y")) {
    categoryProc.hide(categoryno);
  } else {
    categoryProc.show(categoryno);
  }
  response.sendRedirect("./list.jsp");
%>

