<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="./ssi.jsp"%>
<%
  int seqno = categoryProc.getMaxSeqno();
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

      <%
    if (AdminTool.isMaster(request) || AdminTool.isAdmin(request)) {
    %>
      <form name='frm' action='./create_proc.jsp' method='POST'>
        <fieldset class='fieldset_basic'>
          <legend class='legend_basic'>카테고리 등록(*: 필수)</legend>
          <DIV style='text-align: center;'>
            <ul>
              <li class='li_none'>
                <input type='text' name='title' id='title' value='' style='width: 25%;' autofocus="autofocus" placeholder="게시판 제목"> * 순서 <input
                  type='number' name='seqno' id='seqno' value='<%=seqno %>' min='1' max='1000' step='1' style='width: 5%;'> View
                <label>
                  <input type='radio' name='visible' id='visible' value='Y' checked="checked"> Y
                </label>
                <label>
                  <input type='radio' name='visible' id='visible' value='N'> N
                </label>
                <input type='text' name='ids' id='ids' value='admin' style='width: 20%;' placeholder="접근 계정"> *
                <button type='submit'>등록</button>
                <button type='reset'>취소</button>
              </li>
            </ul>
          </DIV>
        </fieldset>
      </form>

      <TABLE class='table_basic'>
        <colgroup>
          <col style='width: 5%;' />
          <!-- 출력 순서 -->
          <col style='width: 40%;' />
          <!-- 제목 -->
          <col style='width: 25%;' />
          <!-- 접근 계정 -->
          <col style='width: 5%;' />
          <!-- 출력 선택 -->
          <col style='width: 10%;' />
          <!-- 등록된 자료수 -->
          <col style='width: 15%;' />
          <!-- 기타 -->
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
            for (int index = 0; index < cnt; index++) {
              CategoryVO categoryVO = list.get(index);
              int categoryno = categoryVO.getCategoryno(); //PK
              String visible = categoryVO.getVisible();
          %>
          <tr>
            <%-- <td class='td_basic'><%=index + 1%>/<%=categoryno%>/<%=categoryVO.getSeqno()%></td> --%>
            <td class='td_basic'><%=categoryVO.getSeqno()%></td>
            <td class='td_left'>
            
            <A href="../pds4/list.jsp?categoryno=<%=categoryno%>"><%=categoryVO.getTitle() %></A>
            
            </td> 
              
             
           
            <td class='td_basic'><%=categoryVO.getIds()%></td>
            <td class='td_basic'>
              <a href="./show_hide.jsp?categoryno=<%=categoryno%>&visible=<%=visible%>"><%=visible%></a>
            </td>
            <td class='td_basic'><%=categoryVO.getCnt()%></td>
            <td class='td_basic'>
             <a href='../pds4/create_form.jsp?categoryno=<%=categoryno%>'> <IMG src='./images/create.png' style='width: 14px;' title ="카테고리에 해당하는 글 등록"></a>
              <a href='./decreaseSeqno.jsp?categoryno=<%=categoryno%>'> <IMG src='./images/up.jpg' style='width: 14px;' title = "우선순위 높임"></a>
              <a href='./increaseSeqno.jsp?categoryno=<%=categoryno%>'> <IMG src='./images/down.jpg' style='width: 14px;' title = "우선순위 내림"></a> 
              <a href='./update_form.jsp?categoryno=<%=categoryno%>'> <IMG src='./images/update.png' style='width: 14px;' title = "수정"></a> 
              <a href='./delete_form.jsp?categoryno=<%=categoryno%>'> <IMG src='./images/delete.png' style='width: 14px;' title = "삭제"></a> 
            </td>
          </tr>
          <%
            } 
          %>
          <%
          }
          %>
        </tbody>
      </TABLE>

    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->

</body>
</html>