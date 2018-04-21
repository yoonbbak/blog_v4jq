<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="./ssi.jsp"%>

<%
  int categoryno = Integer.parseInt(request.getParameter("categoryno"));
  CategoryVO categoryVO = categoryProc.read(categoryno);
  String category_title = categoryVO.getTitle();

  int pdsno = Integer.parseInt(request.getParameter("pdsno"));
 
  
  Pds4VO pds4VO = pds4Proc.read(pdsno);
  
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
        <ASIDE style='float: left;'>
          <A href='../category4/list.jsp'>게시판</A>＞<A href='./list.jsp?categoryno=<%=categoryno%>'><%=category_title%></A>＞수정
        </ASIDE>
        <ASIDE style='float: right;'>
          <A href='./list_category_table2.jsp?categoryno=<%=categoryno%>'>목록형</A> <span class='menu_divide'> |</span> <A
            href='./list.jsp?categoryno=<%=categoryno%>'>앨범형</A> <span class='menu_divide'> |</span> 
           <A href='./list_read.jsp?categoryno=<%=categoryno %>&nowPage=1&recordPerPage=1'>펼쳐보기</A>
        </ASIDE>
        <DIV class='menu_line' style='clear: both;'></DIV>
      </DIV>

      <FORM name='frm' method='POST' action='./update_proc.jsp'>
        <input type='hidden' name='categoryno' value='<%=categoryno%>'> 
        <input type='hidden' name='pdsno' value='<%=pdsno%>'>
        <input type='hidden' name='col' value='<%=col %>'>
        <input type='hidden' name='word' value='<%=word %>'>

        <fieldset class='fieldset_no_line'>
          <ul>
            <li class='li_none'>
              <label for='title'>제목: </label>
              <input class='input_basic' type='text' name='title' id='title' value='<%=Tool.convertChar(pds4VO.getTitle())%> ' style = 'width: 80%;'>
            </li>
            <li class='li_none'>
              <label for='content'>내용: </label>
              <br>
              <textarea name='content' id='content' rows='10' style='width: 100%;'><%=pds4VO.getContent()%></textarea>
            </li>
            <li class='li_none'>
              <label for='web'>WEB URL: </label>
              <input class='input_basic' type="text" name='web' id='web' size='50' value='<%=pds4VO.getWeb()%>'>
            </li>
            <li class='li_none'> 
              <label for='rname'>성명: </label>
              <input class='input_basic' type='text' name='rname' id='rname' value='<%=pds4VO.getRname() %>' size='10'>

              <label for='email'>이메일: </label>
              <input class='input_basic' type='email' name='email' id='email' value='<%=pds4VO.getEmail() %>' size='25'>

              <label for='passwd'>패스워드: </label>
              <input class='input_basic' type='password' name='passwd' id='passwd' value='123' size='5'>

              <button type="submit">변경된 내용 저장</button>
              <button type="button" onclick="location.href='./list.jsp?categoryno=<%=categoryno%>'">수정 취소</button>
            </li>
       <%
       //-----------------------------------------유튜브시작
       %>
          <li class='li_center'>
        <HR class='hr_dotted'>
        
        <%
        // -------------------------- Youtube -------------------------- 
        String youtube = pds4VO.getYoutube();
        if (youtube == null) { // checkNull 메소드로 변경 예정
          youtube = "";
        }
        if (youtube.trim().length() > 0) { // 지도가 있는 경우만 출력
        %>
        <DIV style='width:900px; margin: 0px auto;'>
          <DIV style='width:854px; float: left;'>
            <%=pds4VO.getYoutube() %> 
          </DIV>
          <DIV style='margin: 0px auto; float: left'>
            <A href="./replace_youtube_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>"><IMG src='./images/update.png' title="지도 변경"></A>
            <A href="./delete_youtube_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>"><IMG src='./images/delete.png' title="지도 삭제"></A>   
          </DIV>
        </DIV>
        
        <%
        } else {
        %>
          <A class='button' style='text-decoration: none; ' href='./create_youtube_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>'>새로운 Youtube 영상 등록</A>
        <%  
        }
        //-------------------------------------유튜브 종료
        %>
        
          <li class='li_center'>
        <HR class='hr_dotted'>
        
        <%
        // -------------------------- MP3 파일 -------------mmmmmmmmmmmmmmmmm------------- 
        String mp3 = Tool.checkNull(pds4VO.getMp3());
        if (mp3.trim().length() > 0) { // 지도가 있는 경우만 출력
        %>
        <DIV style='width:620px; margin: 0px auto;'>
          <DIV style='width:570px; margin: 0px auto; float: left;'>
            등록된 MP3 파일명: <%=pds4VO.getMp3() %>
          </DIV>
          <DIV style='width:50px; margin: 0px auto; float: left'>
              <A href="./replace_mp3_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>"><IMG src='./images/update.png' title="음악 변경"></A>
              <A href="./delete_mp3_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>"><IMG src='./images/delete.png' title="음악 삭제"></A>   
          </DIV>        
        </DIV>
        <%
        } else {
        %>
          <A class='button' style='text-decoration: none; ' href='./create_mp3_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>'>새로운 MP3 파일 등록</A>
        <%  
        }
        %>
      
      </li> 
      
        <%  //----------------------------------------------------------------mp3 종료 %>
        
      
         <li class='li_center'>
        <HR class='hr_dotted'>
        <%
        // -------------------------- MP4 파일 -------------------------- 
        String mp4 = Tool.checkNull(pds4VO.getMp4());
       
        if (mp4.trim().length() > 0) {
        %>
        <DIV style='width:620px; margin: 0px auto;'> 
          <DIV style='width:570px; margin: 0px auto; float: left;'>
            <VIDEO controls src='./storage/<%=mp4 %>' style='width: 80%;'></VIDEO>
          </DIV>
          <DIV style='width:50px; margin: 0px auto; float: left'>
            <A href="./replace_mp4_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>"><IMG src='./images/update.png' title="MP4 변경"></A>
            <A href="./delete_mp4_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>"><IMG src='./images/delete.png' title="MP4 삭제"></A>   
          </DIV>        
        </DIV>
        <%
        } else {
        %>
          <A class='button' style='text-decoration: none; ' href='./create_mp4_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>'>새로운 MP4파일 등록</A>
        <%  
        }
        %>
      </li> 
 
          
          
          <li class='li_center'>
        <HR class='hr_dotted'>
                     
        <%
        
        
        // -------------------------- Map -------------------------- 
        String map = Tool.checkNull(pds4VO.getMap());
        
        if (map.trim().length() > 0) { // 지도가 있는 경우만 출력
        %>
        <DIV style='width:570px; margin: 0px auto;'>
          <DIV style='width:520px; float: left'>
            <%=pds4VO.getMap() %> 
          </DIV>
          <DIV style='width:50px; margin: 0px auto; float: left'>
            <A href="./replace_map_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>"><IMG src='./images/update.png' title="지도 변경"></A>
            <A href="./delete_map_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno%>"><IMG src='./images/delete.png' title="지도 삭제"></A>   
          </DIV>
        </DIV>
        
        <%
        } else {
        %>
          <A class='button' style='text-decoration: none; ' href='./create_map_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>'>새로운 지도 등록</A>
        <%  
        }
        %>
        
      </li>
          
             
           <li class='li_none'>
              <HR class='hr_dotted'>
              <br>
              추가 컨텐츠 변경
              <HR class='hr_dotted'>
            </li>

              <li class='li_center'>
              <label for='file1'>참고 파일: </label>

              <%
                if (pds4VO.getSize1() > 0) { // 파일이 존재하는 경우
                  if (Tool.isImage(pds4VO.getFstor1())) { // 이미지 일경우
              %>
              <IMG src='./storage/<%=pds4VO.getFstor1()%>' style='width: 200px;'>
              <%
                } else { // 이미지가 아닐 경우
                    out.println(pds4VO.getFile1());
                  }
              %>
              <A href="./replace_file1_form.jsp?categoryno=<%=categoryno%>&pdsno=<%=pdsno%>"><IMG src='./images/update.png'></A>
              <A href="./delete_file1_form.jsp?categoryno=<%=categoryno%>&pdsno=<%=pdsno%>"><IMG src='./images/delete.png'></A>
              <%
                } else { // 파일이 없는 경우 
              %>
              <!--  
              <input class='input_basic' type="file" name='file1' id='file1' size='50'> (10 MB 이하만 전송 가능)
              -->
              <button type = 'button' onclick="location.href='./create_file1_form.jsp?categoryno=<%=categoryno%>&pdsno=<%=pdsno%>&col=<%=col%>&word=<%=word%>'">새로운 파일 등록 클릭하세요.</button>
              
             <%
             } 
             %>
            

            </li>  
          </ul>
        </fieldset>

      </FORM>

    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->

</body>
</html>
