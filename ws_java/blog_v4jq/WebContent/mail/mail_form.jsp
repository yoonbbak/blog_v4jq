<%@ page contentType="text/html; charset=UTF-8" %>
 
<% String root = request.getContextPath(); // context 추출 %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 쓰기</title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">
</head>
 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<div class='title_box'>mail 쓰기</div>
 
<div style='width: 80%; margin: 0px auto;'>
<form name='mailForm' method='post' action="./mail_proc.jsp">
  <table class='table_basic'>
    <colgroup>
      <col style='width: 20%;' />   <!-- 출력 순서 -->
      <col style='width: 80%;' /> <!-- 제목 -->
    </colgroup>
    <tr>
      <th class='th_basic'>받는 사람</th>
      <td class='td_left'><input type="text" name="to" value='testcell2010@gmail.com' class='input_basic' style='width: 50%;'></td>
    </tr>
    <tr>
      <th class='th_basic'>보내는 사람</th>
      <td class='td_left'><input type="text" name="from" value='inulunggi@gmail.com' class='input_basic' style='width: 100%;'></td>
  </tr>
  <tr>
    <th class='th_basic'>제 목</th>
    <td class='td_left'><input type="text" name="subject" value="OJT 메일을 보냅니다. IP: 100" class='input_basic' style='width: 100%;'></td>
  </tr>
  <tr>
    <td class='td_left' colspan="2">
      <textarea name="content" rows="10"  style='width: 100%; border: none;'>메일 전송 테스트</textarea>
    </td>
  </tr>
</table>
 
<div  class="bottom_menu">
  <input type="submit" value="보내기">
  <input type="button" value="취소" onclick="history.back()">
</div>
</form>
</div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html>