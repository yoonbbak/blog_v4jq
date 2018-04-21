<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ include file="./ssi.jsp" %>

<%
  int categoryno = Integer.parseInt(request.getParameter("categoryno"));
  CategoryVO categoryVO = categoryProc.read(categoryno);
  // 수정할 레코드 하나를 읽어옴
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카테고리</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
  
  <!-- udpate_proc.jsp -->
  <form name='frm' action='./update_proc.jsp' method='POST'>
  
    <!-- categoryno를 hidden으로 가져감 -->
    <input type="hidden" name="categoryno" value="<%=categoryno %>">
    
    <fieldset class='fieldset_basic'>
      <legend class='legend_basic'>카테고리 수정(*: 필수)</legend>
      <DIV style='text-align: center;'>
      <ul>
        <li class='li_none'>
          <input type='text' name='title' id='title' value='<%=categoryVO.getTitle() %>' style='width: 25%;' placeholder="게시판 제목">*
           순서 <input type='number' name='seqno' id='seqno' value='<%=categoryVO.getSeqno() %>' min='1' max='1000' step='1' style='width: 5%;'>
           View 
          <%
            if(categoryVO.getVisible().equals("Y") ){
          %>
          <label>
            <input type='radio' name='visible' id='visible' value='Y' checked="checked"> Y
          </label>
          <label>
            <input type='radio' name='visible' id='visible' value='N'> N
          </label>
          <%
            } else{ 
          %>
          <label>
            <input type='radio' name='visible' id='visible' value='Y'> Y
          </label>
          <label>
            <input type='radio' name='visible' id='visible' value='N' checked="checked"> N
          </label>
          <%
            }
          %>
            <input type='text' name='ids' id='ids' value='<%=categoryVO.getIds() %>'  style='width: 20%;' placeholder="접근 계정">*
          <button type='submit'>수정</button>
          <button type='button' onclick="location.href='./list.jsp'">취소</button>
        </li>
      </ul>
      </DIV>
    </fieldset>
    
  </form>
 
  <TABLE class='table_basic'>
    <colgroup>
      <col style='width: 5%;' />  <!-- 출력 순서 -->
      <col style='width: 40%;' /> <!-- 제목 -->
      <col style='width: 25%;' /> <!-- 접근 계정 -->
      <col style='width: 5%;' />  <!-- 출력 선택 -->
      <col style='width: 10%;' /> <!-- 등록된 자료수 -->
      <col style='width: 15%;' /> <!-- 기타 -->
    </colgroup>
    <TR>
      <TH class='th_basic'>순서</TH>
      <TH class='th_basic'>제목</TH>
      <TH class='th_basic'>계정</TH>
      <TH class='th_basic'>출력</TH>      
      <TH class='th_basic'>자료수</TH>
      <TH class='th_basic'>기타</TH>
    </TR>
    <tbody>
     <% 
       ArrayList<CategoryVO> list = categoryProc.list();
     
       int cnt = list.size();
       
       // 자바에 있는 DB를 HTML로 출력
       for (int index = 0; index < cnt; index++){
         categoryVO = list.get(index);
         categoryno = categoryVO.getCategoryno(); //PK
     %>
     <tr>
       <td class='td_basic'><%=categoryVO.getSeqno()%></td>
       <td class='td_left'><%=categoryVO.getTitle()%></td>
       <td class='td_basic'><%=categoryVO.getIds()%></td>
       <td class='td_basic'><%=categoryVO.getVisible()%></td>
       <td class='td_basic'><%=categoryVO.getCnt()%></td>
       <td class='td_basic'>
         <a href='./decreaseSeqno.jsp?categoryno=<%=categoryno%>'> <IMG src='./images/up.jpg' style='width: 14px;'></a>
         <a href='./increaseSeqno.jsp?categoryno=<%=categoryno%>'> <IMG src='./images/down.jpg' style='width: 14px;'></a> 
         <a href='./update_form.jsp?categoryno=<%=categoryno%>'><IMG src='./images/update.png' style='width: 14px;'></a> 
         <a href='./delete_form.jsp?categoryno=<%=categoryno%>'><IMG src='./images/delete.png' style='width: 14px;'></a>
       </td>
     </tr>
     <%
       }
     %>
    </tbody>
  </TABLE>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
 
</body>
</html>