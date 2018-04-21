<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="nation.web.tool.Upload" %> 
<%@ page import="nation.web.pds4.Pds4VO" %> 
<%@ page import="nation.web.tool.Tool"%>
<%@ page import="nation.web.admin4.AdminTool"%>  

<%@ page import="nation.web.category4.CategoryProc"%>
<%@ page import="nation.web.category4.CategoryVO"%>
<%@ page import="nation.web.pds4.Pds4Proc"%>
 
<%
  String root = request.getContextPath(); 
  request.setCharacterEncoding("utf-8");

  DecimalFormat df = new DecimalFormat((char) 65510 + " #,###,### " + (char) 50896);
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  String date = sdf.format(new Date());
  Pds4Proc pds4Proc = new Pds4Proc();
%>

<%
  // DAO가 아닌 Proc
  // Layer Architecture Style
  CategoryProc categoryProc = new CategoryProc();
  
 
%>