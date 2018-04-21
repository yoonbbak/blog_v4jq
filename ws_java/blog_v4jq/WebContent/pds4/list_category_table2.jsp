<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="./ssi.jsp"%>

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
listFile = "list_category_table2.jsp";
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
          <FORM name='frm' method='GET' action='./list_category_table2.jsp'>
           <input type='hidden' name='categoryno' value='<%=categoryno%>'> 
            <SELECT name='col'>
              <OPTION value='none' <%if (col.equals("none")) { out.print("selected = 'selected'");}  %>>전체 목록</OPTION>
              <OPTION value='rname'<%if (col.equals("rname")) { out.print("selected = 'selected'");}  %>>성명</OPTION>
              <OPTION value='title'<%if (col.equals("title")) { out.print("selected = 'selected'");}  %>>제목</OPTION>
              <OPTION value='content'<%if (col.equals("content")) { out.print("selected = 'selected'");}  %>>내용</OPTION>
              <OPTION value='title_content'<%if (col.equals("title_content")) { out.print("selected = 'selected'");}  %>>제목+내용</OPTION>
            </SELECT> <INPUT type='text' name='word' value='<%=word %>' placeholder="검색어"> 
            <BUTTON type='submit'>검색</BUTTON>
          </FORM>
        </ASIDE>
        <ASIDE style='float: left;'> 
          <A href='../category4/list.jsp'>게시판</A>＞<A href='./list.jsp?categoryno=<%=categoryno%>'><%=category_title%></A>
        </ASIDE>
        <ASIDE style='float: right;'>
              <%
    if (AdminTool.isMaster(request) || AdminTool.isAdmin(request)) {
    %>   
            <A href='./create_form.jsp?categoryno=<%=categoryno%>&listFile=<%=listFile%>'>등록</A> <span class='menu_divide'> |</span>
          <%
          }
              %>
          <A href='./list_category_table2.jsp?categoryno=<%=categoryno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'>목록형</A> <span class='menu_divide'> |</span> <A
            href='./list.jsp?categoryno=<%=categoryno%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'>앨범형</A> 
            <span class='menu_divide'> |</span> <A href='./list_read.jsp?categoryno=<%=categoryno %>&nowPage=1&recordPerPage=1'>펼쳐보기</A>
        </ASIDE>
        <DIV class='menu_line' style='clear: both;'></DIV> 
      </DIV>

      <%
       /*  ArrayList<Pds4VO> list = pds4Proc.list_category(categoryno, col, word); */ //검색하는 경우
        /* ArrayList<Pds4VO> list = pds4Proc.list_category(categoryno); */ //검색하지 않은 경우
      %>
      <%--  
  <DIV class='title_box'><%=category_title %></DIV>
    --%>

      <TABLE class='table_basic'>
        <colgroup>
          <col style='width: 10%;' />
          <!--<col style='width: 10%;' /> -->
          <col style='width: 40%;' />
          <col style='width: 10%;' />
          <col style='width: 10%;' />
          <col style='width: 20%;' />
          <col style='width: 10%;' />
        </colgroup>
        <thead>
          <TR>
            <TH class='th_basic'>번호</TH>
            <!-- <TH class='th_basic'>파일</TH> -->
            <TH class='th_basic'>제목</TH>
            <TH class='th_basic'>성명</TH>
            <TH class='th_basic'>조회</TH>
            <TH class='th_basic'>등록일</TH>
            <TH class='th_basic'>기타</TH>
          </TR>
        </thead>
        <tbody>
          <%
            for (int index = 0; index < list.size(); index++) {
              Pds4VO pds4VO = list.get(index);
              int pdsno = pds4VO.getPdsno(); //pk
              String file1 = Tool.checkNull(pds4VO.getFile1());
              String thumb = pds4VO.getThumb();
              //System.out.println(" --> file1 : " + file1); 파일이 없어도 null이 아님;
          %>
          <TR style='height: 20px;'> 
            <TD class='td_basic'><%=pds4VO.getGrpno() %>/<%=pds4VO.getIndent() %>/<%=pds4VO.getAnsnum() %></TD>

            <%--주석--------------------------------  
            <TD class="td_basic" style='padding-top: 5px; padding-bottom: 5px;'>
              <%
                if (file1.length() > 0) {
                    if (Tool.isImage(thumb)) {
              %>
              <IMG src='./storage/<%=pds4VO.getThumb()%>' style='width: 100%; display: block;'>
              <%
                } else {
              %>
              <%=file1%>
              <%
                }
              %>
              <%
                } else {
              %>
              <IMG src='./images/none1.jpg' style='width: 100%; display: block;'>
              <%
                }
              %>
              

            </TD>
              -------------------------주석--%>
            
            <TD class='td_left'>
            <% 
            if (pds4VO.getAnsnum() > 0){ //답변이라면
             %>
             <img src = '/images/white.jpg' style = 'width: <%=pds4VO.getIndent() * 20 %>px; opacity: 0.0;'>
             <img src = '/images/reply3.jpg'>
             <%
            }
             %>
              <A href='./read.jsp?categoryno=<%=categoryno%>&pdsno=<%=pds4VO.getPdsno()%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'><%=Tool.convertChar(Tool.textLength(pds4VO.getTitle(), 10))%></A>
            <TD class='td_basic'><%=pds4VO.getRname()%></TD>
            <TD class='td_basic'><%=pds4VO.getCnt()%></TD>
            <TD class='td_basic'><%=pds4VO.getRdate()%></TD>
            <TD class='td_basic'>

              <%
                if (pds4VO.getVisible().equals("Y")) {
              %>
                   <%
    if (AdminTool.isMaster(request) || AdminTool.isAdmin(request)) {
    %>   
              <A href='./show_hide.jsp?categoryno=<%=categoryno%>&pdsno=<%=pdsno%>&visible=<%=pds4VO.getVisible()%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'><IMG
                  src='./images/show.png' title='출력'></A>
                  <%
                  }
                   %>
              <%
                } else {
              %>
                    <%
    if (AdminTool.isMaster(request) || AdminTool.isAdmin(request)) {
    %>   
              <A href='./show_hide.jsp?categoryno=<%=categoryno%>&pdsno=<%=pdsno%>&visible=<%=pds4VO.getVisible()%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'><IMG
                  src='./images/hide.png' title='숨기기'></A>
            <%
            }
                    %> 
              <%
                }
              %>
                   <% 
    if (AdminTool.isMaster(request) || AdminTool.isAdmin(request)) {
    %>   
              <A href='./update_form.jsp?categoryno=<%=categoryno%>&pdsno=<%=pds4VO.getPdsno()%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'><IMG
                  src='./images/update.png' title='수정'></A> <A
                href='./delete_form.jsp?categoryno=<%=categoryno%>&pdsno=<%=pds4VO.getPdsno()%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'><IMG
                  src='./images/delete.png' title='삭제'></A>
            <%
            }
                   %>
            </TD>

          </TR>
          <%
            }
          %>
        </tbody>
        <tfoot>
        </tfoot>
      </TABLE>

      
  <HR class='hr_dotted'>
                      
<DIV class='bottom_menu'>
  <%=paging %>
</DIV>
    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END --> 

</body>
</html>
