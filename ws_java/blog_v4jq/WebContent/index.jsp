<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
  request.setCharacterEncoding("utf-8");

  DecimalFormat df = new DecimalFormat((char) 65510 + " #,###,### " + (char) 50896);
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  String date = sdf.format(new Date());
%>
  
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>blog</title>
<link href="./css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
  <DIV class='container'>
    <jsp:include page="/menu/top.jsp" flush='false' />
    <!-- <DIV class='content'>
      <TABLE style='width: 30%; margin: 30px auto; border-collapse: collapse;'>
        <tr>
          <td style='width: 50%;'><img src='./menu/images/01.jpg' style='width: 100%; display: block;'></td>
          <td style='width: 50%;'><img src='./menu/images/02.jpg' style='width: 100%; display: block;'></td>
        </tr>
        <tr>
          <td style='width: 50%;'><img src='./menu/images/03.jpg' style='width: 100%; display: block;'></td>
          <td style='width: 50%;'><img src='./menu/images/04.jpg' style='width: 100%; display: block;'></td>
        </tr>
      </TABLE>  //가운데 사진 4개짜리 
    </DIV> -->
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->

</body>
</html>