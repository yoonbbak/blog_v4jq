<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="./ssi.jsp" %>

<%
  int visitorno = Integer.parseInt(request.getParameter("visitorno"));
  VisitorVO visitorVO = visitorProc.read(visitorno);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>방명록</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
  <DIV class='container'>
    <jsp:include page="/menu/top.jsp" flush='false' />
    <DIV class='content'>
      <form name='frm' action='./update_proc.jsp' method='POST'>
        <fieldset style='width: 80%; margin: 10px auto;'>
          <legend class="legend_basic">방명록 수정(*: 필수)</legend>
          <ul>
            <li class='li_none'>
             <textarea name='content' id='content' rows='5' style='width: 99%;' placeholder="내용을 입력하세요"><%=visitorVO.getContent() %></textarea>*
            </li>
            <li class='li_none'>
              <input type='text' name='rname' id='rname' value='<%=visitorVO.getRname() %>' style='width: 10%;' placeholder="성명">*
               
              <input type='password' name='passwd' id='passwd' value='' style='width: 10%;' placeholder="패스워드">*
               
              <input type='text' name='email' id='email' value='<%=visitorVO.getEmail() %>' style='width: 25%;' placeholder="이메일">
               
              <input type='text' name='home' id='home' value='<%=visitorVO.getHome() %>' style='width: 37%;' placeholder="홈페이지">
               
              <button type='submit'>수정</button>
              <button type='button' onclick="location.href='./list.jsp'">취소</button>
            </li>
          </ul>
        </fieldset>
      </form>
    
    <DIV style='border: none; margin: 0px auto; width: 80%; padding: 5px 20px;'>
        <%
        ArrayList<VisitorVO> list = visitorProc.list(); 
            
        int cnt = list.size();
        for (int index=0; index < cnt; index++) {
          visitorVO = list.get(index);
//           System.out.println(visitorVO.getVisitorno());
        %>
          <IMG src='./images/bu6.gif'> <%=Tool.convertChar(visitorVO.getContent()) %><br>
          <span style='font-size: 0.8em;'>
            [
            <%=visitorVO.getRname() %> <%=visitorVO.getRdate() %>
            <%=visitorVO.getEmail() %> <%=visitorVO.getHome() %>
            <A href='./update_form.jsp?visitorno=<%=visitorVO.getVisitorno() %>'><IMG src='./images/update.png' style='width: 14px;'></A>
            <A href='./delete_form.jsp?visitorno=<%=visitorVO.getVisitorno() %>'><IMG src='./images/delete.png' style='width: 14px;'></A>
            ]
            
          </span>
          <br>
          <HR style='border: dotted 1px #CCCCCC; margin: 5px auto;'>
        <%
        }
        %>  
      </DIV>
    
    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->
</body>
</html>