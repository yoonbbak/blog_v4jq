<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="nation.web.admin4.AdminProc"%>
<%@ page import="nation.web.admin4.Admin4VO"%>
<%@ page import="nation.web.notice3.NoticeDAO"%>
<%@ page import="nation.web.notice3.NoticeVO"%>
<%@ page import="nation.web.admin4.AdminTool"%>  

<%
  request.setCharacterEncoding("utf-8");
  String root = request.getContextPath(); // /blog_v3jq

  // DecimalFormat df = new DecimalFormat((char)65510 + " #,###,### " + (char)50896);
  // SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  // String date = sdf.format(new Date());
%>

<%
  NoticeDAO noticeDAO = new NoticeDAO();
%>