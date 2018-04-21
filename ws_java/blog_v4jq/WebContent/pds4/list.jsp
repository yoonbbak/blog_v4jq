<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
int categoryno = Integer.parseInt(request.getParameter("categoryno"));
CategoryVO categoryVO = categoryProc.read(categoryno);
String category_title = categoryVO.getTitle();

AdminProc adminProc_auth = new AdminProc(); 
 
%>
 <%
// -----------------------------------------------------------------
// 페이징 관련 코드 시작
// ----------------------------------------------------------------- 
int recordCount = pds4Proc.count(categoryno, col, word);
  
// listFile 목록 파일명
// recordCount 전체 레코드수 
// nowPage 현재 페이지 
// recordPerPage 페이지당 레코드 수
// col 검색 컬럼 
// word 검색어
// categoryno 카테고리 그룹(이거만바꾸면됨)
listFile = "list.jsp";
String paging = new Paging().paging4(listFile, recordCount, nowPage, 
                                                        recordPerPage, col, word, categoryno); 
// -----------------------------------------------------------------
 
ArrayList<Pds4VO> list = pds4Proc.list_category(categoryno, col, word, nowPage, recordPerPage);
  %>  
<!DOCTYPE html>  
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>게시판</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
</head> 
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>  
  
<DIV class='aside_menu'> 
<ASIDE style='float: right;'>
      <FORM name='frm' method='GET' action='./list.jsp'>
        <input type='hidden' name='categoryno' value='<%=categoryno %>'>
       
      
  
   
   
  
        <SELECT name='col'>
          <OPTION value='none' <%=(col.equals("none"))?"selected='selected'":"" %> >전체 목록</OPTION>
          <OPTION value='rname' <%=(col.equals("rname"))?"selected='selected'":"" %>>성명</OPTION>
          <OPTION value='title' <%=(col.equals("title"))?"selected='selected'":"" %>>제목</OPTION>
          <OPTION value='content' <%=(col.equals("content"))?"selected='selected'":"" %>>내용</OPTION>
          <OPTION value='title_content' <%=(col.equals("title_content"))?"selected='selected'":"" %>>제목+내용</OPTION>
        </SELECT>
        <INPUT type='text' name='word' value='<%=word %>' placeholder="검색어">
        <BUTTON type='submit'>검색</BUTTON>
      </FORM> 
    </ASIDE>
  <ASIDE style='float: left;'><A href='../category4/list.jsp'>게시판</A>＞<A href='./list.jsp?categoryno=<%=categoryno %>'><%=category_title %></A></ASIDE> 
  <ASIDE style='float: right;'>
  
    <%
    if (AdminTool.isMaster(request) || AdminTool.isAdmin(request)) {
    %>
    <A href='./create_form.jsp?categoryno=<%=categoryno %>'>등록</A> <span class='menu_divide'> |</span> 
   <%
    }
   %>

<A href='./list_category_table2.jsp?categoryno=<%=categoryno %>&col=<%=col%>&word=<%=word%>'>목록형</A> <span class='menu_divide'> |</span> 
    <A href='./list.jsp?categoryno=<%=categoryno %>&col=<%=col%>&word=<%=word%>'>앨범형</A> <span class='menu_divide'> |</span>
    <A href='./list_read.jsp?categoryno=<%=categoryno %>&nowPage=1&recordPerPage=1'>펼쳐보기</A>
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>
 
  <%
     /* ArrayList<Pds4VO> list = pds4Proc.list_category(categoryno); 
     ArrayList<Pds4VO> list = pds4Proc.list_category(categoryno, col, word); */
  %>
 
  <%
  for(int index=0; index < list.size(); index++){
    Pds4VO pds4VO = list.get(index);
    String thumb = pds4VO.getThumb();
    int pdsno = pds4VO.getPdsno();
    String title = pds4VO.getTitle();
    String rdate = pds4VO.getRdate();
    String rname = pds4VO.getRname();
    int cnt = pds4VO.getCnt();
    String fstor1 = pds4VO.getFstor1();
    String file1 = pds4VO.getFile1();
    
    if(index != 0 && index % 4 ==0){ //4에서 hr발생 
      %>
      <HR class = "hr_dotted">
      <% 
    }
  %>
  <!-- 하나의 이미지 출력 -->
  <DIV class='div_grid_img'>
    <%
    if (pds4VO.getSize1() > 0) {
      if (Tool.isImage(thumb)) {
        %> 
          <IMG src='./storage/<%=thumb %>' style='width: 100%; height: 150px;'>
          <br>
        <%
        } else {
        %>
          <DIV class='div_grid_text' style='height: 150px; width: 98%'>
          <DIV class='div_grid_text_content'>
            <A href='<%=request.getContextPath()%>/download?dir=/pds4/storage&filename=<%=fstor1 %>'><%=file1 %></A>
          </DIV>
        </DIV>
        <%
        } // END if (thumb != null) {
       
    } else {
    %>
    
    <!--   <DIV class='div_grid_text' style='height: 150px; width: 98%'>
        <DIV class='div_grid_text_content'>
          등록된 파일 없음
        </DIV> 
      </DIV> -->
      <IMG src='./images/none1.jpg' style='width: 100%; height: 150px;'>
    <%
    } 
    %> 
    <A href='./read.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'><%=Tool.convertChar(Tool.textLength(title, 10)) %> [<%=cnt %>]</A>  
    <br>
    <span style='font-size: 0.8em;'><%=rdate %> (<%=rname %>)</span>
  </DIV>   
  <%
  } // for END
  %>
 
  <HR class='hr_dotted'>
                      
<DIV class='bottom_menu'>
  <%=paging %>
</DIV>
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html> 