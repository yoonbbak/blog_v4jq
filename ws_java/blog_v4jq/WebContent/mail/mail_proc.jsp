<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ page import="java.util.*, java.io.*, javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
 
<% String root = request.getContextPath(); %>
<%  
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 전송</title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">
</head>
 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<div class='content'>
<div align="center">
<%
// javamail lib 이 필요합니다.
class MyAuthentication extends Authenticator {
  PasswordAuthentication pa;
  public MyAuthentication(){
    pa = new PasswordAuthentication("test@nulunggi.pe.kr", "test2016");
  }
 
  public PasswordAuthentication getPasswordAuthentication() {
    return pa;
  }
}
  
String subject = request.getParameter("subject");  // 제목
String content = request.getParameter("content");  // 내용
content = content.replace("\n", "<BR>"); // 엔터키를 줄바꿈 <BR>로 변경 
 
// mw-002.cafe24.com, Cafe24
String host = "mw-002.cafe24.com";        // smtp mail server(서버관리자)     
String from = request.getParameter("from"); // 보내는 주소
String to = request.getParameter("to");    // 받는 사람
 
Properties props = new Properties();  // SMTP 프로토콜 사용, port 25
props.put("mail.smtp.host", host);
props.put("mail.smtp.auth","true");
 
Authenticator auth = new MyAuthentication();
Session sess = Session.getInstance(props, auth);   // 계정 인증 검사
 
try {
  Message msg = new MimeMessage(sess);   // 메일 내용 객체 생성
  msg.setFrom(new InternetAddress(from));   // 보내는 사람 설정
        
  // 한명에게만 보냄
  InternetAddress[] address = {new InternetAddress(to)}; // 받는 사람 설정
  
  /*
  // 다중 메일 전송
  to=mail1@gmail.com,mail2@gmail.com,mail3@gmail.com,mail4@gmail.com,mail5@gmail.com,
  String[] addrs = to.split(",");
  InternetAddress[] address = new InternetAddress[30];
  
  for(int i=0; i<addrs.length; i++){
    address[i] = addrs[i];
  }
  */
  
  msg.setRecipients(Message.RecipientType.TO, address); // 수령인 주소 설정
        
  msg.setSubject(subject);                  // 제목 설정 
  msg.setSentDate(new Date());          // 보낸 날짜 설정
        
  // msg.setText(msgText); // 메일 내용으로 문자만 보낼 경우
 
  // 보내는 내용으로 HTML 형식으로 보낼 경우
  msg.setContent(content, "text/html;charset=utf-8");
        
  Transport.send(msg);  // 메일 전송
 
  out.println("<u>전송된 내용</u><br><br>");
  out.println("<u>제목(subject): " + subject + "</u><br>");
  out.println("내용(msgText): " + content + "<br><br>");
 
  out.println(to + "님에게 메일을 발송했습니다.");
 
  out.println("<br><br>");
  /**
  // 다중 전송
  for(int i=0; i<addrs.length; i++){
    out.println(addrs[i] + " 님에게 메일을 전송했습니다.");
  }
  */
  
} catch (MessagingException mex) {
  out.println(mex.getMessage()+"<br><br>");
  out.println(to + "님에게 메일 발송을 실패 했습니다.");
}
 
%>
 
</div>
</div>
    
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html>
 