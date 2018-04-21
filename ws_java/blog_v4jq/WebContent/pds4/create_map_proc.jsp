<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int categoryno = Integer.parseInt(request.getParameter("categoryno"));
CategoryVO categoryVO = categoryProc.read(categoryno);
String category_title = categoryVO.getTitle();
 
int count = 0; // 변경된 레코드 수
%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
  <DIV class='aside_menu'>
    <ASIDE style='float: left;'>게시판＞<%=category_title %>＞지도(Map) 등록</ASIDE> 
    <ASIDE style='float: right;'>
    <A href='./list_category_table2.jsp?categoryno=<%=categoryno %>&col=<%=col%>&word=<%=word%>'>목록형</A> <span class='menu_divide'> |</span> 
    <A href='./list.jsp?categoryno=<%=categoryno %>&col=<%=col%>&word=<%=word%>'>앨범형</A> <span class='menu_divide'> |</span>
    <A href='./list_read.jsp'>펼쳐보기</A>
    </ASIDE> 
    <DIV class='menu_line' style='clear: both;'></DIV>
  </DIV>
 
  <DIV class='message'>
    <%
    int pdsno = Integer.parseInt(request.getParameter("pdsno"));
    String passwd  = request.getParameter("passwd");
 
    if (pds4Proc.passwordCheck(pdsno, passwd) == 1) { // 패스워드 일치
      String map = request.getParameter("map");
  
      Pds4VO pds4VO = new Pds4VO();
      pds4VO.setPdsno(pdsno);
      pds4VO.setMap(map);
      
      count = pds4Proc.create_map(pds4VO);
      if (count == 1) {
      %>
        <SPAN class='span_info'>지도를 등록했습니다.</SPAN>
      <%  
      } else {
      %>
        <SPAN class='span_warning'>지도 등록중에 에러가 발생하여 등록에 실패했습니다.</SPAN>
      <%  
      }
  
    } else { // 패스워드 실패
      %>
      <SPAN class='span_warning'>패스워드가 일치하지 않습니다.</SPAN>
      <%  
    }
    %>
  </DIV>
 
  <DIV class='bottom_menu'>
    <%
    if (count == 0) {
    %>
      <button type='button' onclick="history.back()">다시 시도</button>  
    <%  
    } else {
    %>
<button type='button' onclick="location.href='./read.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>&col=<%=col%>&word=<%=word%>'">확인</button>
    <%  
    }
    %> 
    <button type='button' onclick="location.href='./list.jsp?categoryno=<%=categoryno %>&col=<%=col%>&word=<%=word%>'">목록</button>
  </DIV>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>