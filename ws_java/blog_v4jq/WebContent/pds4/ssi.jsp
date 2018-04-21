<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="nation.web.tool.Tool"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="nation.web.category4.CategoryProc"%>
<%@ page import="nation.web.category4.CategoryVO"%>
<%@ page import="nation.web.admin4.AdminProc" %>
<%@ page import="nation.web.admin4.AdminTool"%>  

<%@ page import="nation.web.tool.Upload"%>
<%@ page import="nation.web.pds4.Pds4VO"%>
<%@ page import="nation.web.pds4.Pds4DAO"%>
<%@ page import="nation.web.pds4.Pds4Proc"%>
<%@ page import="nation.web.pds4.Paging"%> 
<%@ page import="java.io.File"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
  request.setCharacterEncoding("utf-8");
  CategoryProc categoryProc = new CategoryProc();
  Pds4Proc pds4Proc = new Pds4Proc();
  Pds4DAO pds4DAO = new Pds4DAO();
  String root = request.getContextPath();
  
  String col = Tool.checkNull(request.getParameter("col")); //null값일 경우 공백으로 변환
  String word = Tool.checkNull(request.getParameter("word"));

  //페이지당 출력할 레코드 갯수
  int recordPerPage = 0;
  if (request.getParameter("recordPerPage") == null) {
    recordPerPage = 20;
  } else {
    recordPerPage = Integer.parseInt(request.getParameter("recordPerPage"));
  }

  //현재 페이지
  int nowPage = 0;
  if (request.getParameter("nowPage") == null) { 
    nowPage = 1; // 현재 페이지 1부터 시작
  } else {
    nowPage = Integer.parseInt(request.getParameter("nowPage"));
  }
  
  String listFile = "";
  if (request.getParameter("listFile") == null) {
    listFile = "list.jsp"; 
  } else {
    listFile = request.getParameter("listFile");
  };
%>