<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>
 
<%
String tempDir = application.getRealPath("/pds4/temp"); // WebContent 기준
String upDir = application.getRealPath("/pds4/storage");
// request, 메모리에 저장할 크기, 업로드할 최대 파일 크기, 임시 저장 폴더
Upload upload = new Upload(request, -1, -1, tempDir);
 
int categoryno = Integer.parseInt(upload.getParameter("categoryno"));
CategoryVO categoryVO = categoryProc.read(categoryno);
String category_title = categoryVO.getTitle();
int count = 0;
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
    <ASIDE style='float: left;'>게시판＞<%=category_title %>＞신규 MP4 파일 등록</ASIDE> 
    <ASIDE style='float: right;'>
    <A href='./list_category_table2.jsp?categoryno=<%=categoryno %>&col=<%=col%>&word=<%=word%>'>목록형</A> <span class='menu_divide'> |</span> 
    <A href='./list.jsp?categoryno=<%=categoryno %>&col=<%=col%>&word=<%=word%>'>앨범형</A> <span class='menu_divide'> |</span>
    <A href='./list_read.jsp'>펼쳐보기</A>
    </ASIDE> 
    <DIV class='menu_line' style='clear: both;'></DIV>
  </DIV>
 
  <DIV class='message'>
<%
int pdsno = Integer.parseInt(upload.getParameter("pdsno"));
String passwd  = upload.toKor(upload.getParameter("passwd"));
 
if (pds4Proc.passwordCheck(pdsno, passwd) == 1) { // 패스워드 일치
  Pds4VO pds4VO = new Pds4VO();
  pds4VO.setPdsno(pdsno);  
  
  FileItem fileItemMP4 = null; // 서버로 전송된 파일 객체
  String mp4 = "";   // 사용자가 전송한 파일명
  long sizeMP4 = 0;      // 원본 파일의 크기
 
  //<input type='file' name='mp4' style='width: 100%;'>
  fileItemMP4 = upload.getFileItem("mp4");
  sizeMP4 = fileItemMP4.getSize(); // 파일 크기 
  
  if (sizeMP4 > 0) {
    if (sizeMP4 < 1048576000) { // 1 ~ 104857600 byte, 1000 MB
 
      mp4 = upload.saveFile(fileItemMP4, upDir); // Tomcat이 전송받은 파일 서버에 저장
      pds4VO.setMp4(mp4);
      count = pds4Proc.create_mp4(pds4VO); // DBMS 적용
      if (count == 1) {
        %>
          <span class='span_info'>
            MP4를 등록했습니다.
          </span>
        <%    
        } else { // 모든 조건이 일치했으나 예외가 발생한경우
        %>
          <span class='span_warning'>
            MP4 등록에 실패했습니다. 다시 시도해 주세요.
          </span>
        <%
        }
    } else {
  %>
      <span class='span_warning'>
      전송 파일의 크기는 1000 MB를 넘을 수 없습니다. 다시 시도해주세요.
      </span>
  <%    
    }
  } 
} else {
  %>
  <span class='span_warning'>
    패스워드가 일치하지 않습니다. 다시 시도해주세요.
  </span> 
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
      <button type='button' onclick="location.href='./update_form.jsp?categoryno=<%=categoryno %>&pdsno=<%=pdsno %>&col=<%=col%>&word=<%=word%>'">확인</button>
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
 