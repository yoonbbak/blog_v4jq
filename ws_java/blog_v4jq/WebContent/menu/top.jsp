
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="nation.web.category4.CategoryProc"%>
<%@ page import="nation.web.category4.CategoryVO"%> 
<%@ page import="nation.web.admin4.AdminTool"%> 


<%
CategoryProc categoryProc = new CategoryProc();
 
%>

<%
String root = request.getContextPath();
// out.println("root: " + root);
%>
 
<!-- 화면 상단 메뉴 --> 
<DIV class='top_menu_label'>Watch Story ~ ♥</DIV>
<DIV class='top_menu'
        style="background-image: url('<%=root %>/menu/images/ok1.jpg')" >
  <NAV class='top_menu_list'>
    <A class='menu_link' href='<%=root %>/index.jsp'>HOME</A> <span class = 'top_menu_sep'> | </span>
    <A class='menu_link' href='<%=root %>/admin4/create_form.jsp'>Sign up</A> <span class = 'top_menu_sep'> | </span>
    <A class='menu_link'  href='<%=root %>/notice3/list.jsp'>알림</A> <span class = 'top_menu_sep' > | </span>
    
      
    <%
    ArrayList<CategoryVO> list = categoryProc.list();
    
    int cnt = list.size();
    for (int index = 0; index < cnt; index++) {
      CategoryVO categoryVO = list.get(index); 
      int categoryno = categoryVO.getCategoryno(); 
      String title = categoryVO.getTitle();
      %>
          <A class='menu_link'  href='<%=root %>/pds4/list.jsp?categoryno=<%=categoryno %>'><%=title %></A> |
      <%
    }
      %>
       <%
       if(AdminTool.isAdmin(request)){
         %>
       
      
       [<%=session.getAttribute("email") %>]
        <A class='menu_link'  href='<%=root %>/category4/list.jsp'>Category</A> 
        <span class = 'top_menu_sep'> | </span>
        
        <%
        if( AdminTool.isMaster(request)){
        %>
        <A class='menu_link'  href='<%=root %>/admin4/list.jsp'>Member</A> 
        <span class = 'top_menu_sep'> | </span>
        <A class='menu_link'  href='<%=root %>/log/list.jsp'>Log</A> 
        <span class = 'top_menu_sep'> | </span>
          <%
            }
          %>
          
          <A class='menu_link'  href='<%=root %>/admin4/logout_proc.jsp'>Logout</A> 
         <%
            }else{
            
             %>
              <A class='menu_link'  href='<%=root %>/admin4/login_ck_form.jsp'>Login</A>
             <%
            }
       
             %>
        

 
  </NAV>
</DIV>


