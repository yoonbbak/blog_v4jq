<%@ page contentType="text/html; charset=UTF-8" %> 
 
<%@ include file = "./ssi.jsp"  %>

<%
int categoryno = Integer.parseInt(request.getParameter("categoryno"));
CategoryVO categoryVO = categoryProc.read(categoryno);
String category_title = categoryVO.getTitle();

int pdsno = Integer.parseInt(request.getParameter("pdsno"));
%>
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
</head> 
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>  
 
<DIV class='aside_menu'>
  <ASIDE style='float: left;'><A href='../category4/list.jsp'>게시판</A>＞<A href='./list.jsp?categoryno=<%=categoryno %>'><%=category_title %> > 답변</A></ASIDE> 
  <ASIDE style='float: right;'>
    <A href='./list_category_table2.jsp?categoryno=<%=categoryno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'>목록형</A> <span class='menu_divide'> |</span> 
    <A href='./list.jsp?categoryno=<%=categoryno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'>앨범형</A> <span class='menu_divide'> |</span>
    <A href='./list_read.jsp=?nowPage=<%=nowPage%>&recordPerPage=<%=recordPerPage %>'>펼쳐보기</A>
    <%-- <A href='./list_read.jsp?categoryno=<%=categoryno %>&nowPage=1&recordPerPage=1'>펼쳐보기</A> --%>
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>
 
<FORM name='frm' method='POST' action='./reply_proc.jsp' 
           enctype='multipart/form-data'>
  <input type='hidden' name='categoryno' value='<%=categoryno%>'>
  <input type='hidden' name='pdsno' value='<%=pdsno%>'>  
  <input type='hidden' name='recordPerPage' value='<%=recordPerPage%>'>  
  <input type='hidden' name='nowPage' value='<%=nowPage%>'>  
           
  <fieldset class='fieldset_no_line'>
    <ul>
      <li class='li_none'>
        <label for='title'><b>제목</b> </label>
        <input class='input_basic' type='text' name='title' id='title' size='50' value='봄'>
      </li>
      <li class='li_none'>
        <textarea name='content' id='content' rows='6' style='width: 100%;'>봄 여행</textarea>
      </li>  
      <li class='li_none'>
        <label for='web'><b>WEB URL</b> </label>
        <input class='input_basic'  type="text" name='web' id='web' size='50' value='http://www.daum.net'>
      </li>
      <li class='li_none'>
        <label for='file1'><b>참고 파일</b> </label>
        <input class='input_basic'  type="file" name='file1' id='file1' size='30' > (10 MB 이하만 전송 가능)
      </li>
     
       <li class='li_none'>
        <label for='content'><b>지도</b> </label><br>
        <textarea name='map' id='map' rows='5' style='width: 100%;'></textarea>
      </li>   
           
      <li class='li_none'> 
        <label for='content'><b>youtube</b> (<A href='https://www.youtube.com' target='_blank'>https://www.youtube.com</A>): </label><br>
        <textarea name='youtube' id='youtube' rows='3' style='width: 100%;'></textarea>
      </li>     
       
        <li class='li_none'>
        <DIV style='display: table;'>
          <DIV style='display: table-cell;'>
            <IMG src='./images/speaker.png' style='vertical-align: middle;'>
            <input class='input_basic' style='vertical-align: middle;' type="file" name='mp3' id='mp3' size='50'> (음악 파일(MP3), 100 MB 이하만 전송 가능)
          </DIV>
        </DIV>
      </li>
            
               <li class='li_none'>
        <DIV style='display: table; height: 100px;'>
          <DIV style='display: table-cell;'>
            <IMG src='./images/movie.png' style='vertical-align: middle;'>
            <input class='input_basic' style='vertical-align: middle;' type="file" name='mp4' id='mp4' size='20'> (영상 파일(MP4), 1000 MB 이하만 전송 가능)
          </DIV> 
        </DIV>
      </li>
        
      <li class='li_none'>
        <label for='rname'>성명: </label>
        <input class='input_basic'  type='text' name='rname' id='rname' value='왕눈이' size='10'>
 
        <label for='email'>이메일: </label>
        <input class='input_basic'  type='email' name='email' id='email' value='ddd@ddd.ddd' size='25'>
 
        <label for='passwd'>패스워드: </label>
        <input class='input_basic'  type='password' name='passwd' id='passwd' value='123' size='5'>
      </li>
 
      <li class='li_center'>
        <button type="submit">등록</button>
        <button type="button" onclick="history.back();">목록</button>
        <button type="button" onclick="history.back();">취소</button>
      </li>    
    </ul>
  </fieldset>
 
</FORM>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html> 
 