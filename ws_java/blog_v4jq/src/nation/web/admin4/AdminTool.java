package nation.web.admin4;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class AdminTool {

  /**
   * ȸ�� �������� �˻��մϴ�.
   * @param request
   * @return true or false 
   * 
   */
  public static synchronized boolean isAdmin(HttpServletRequest request){
    boolean sw = false;
     
    HttpSession session = request.getSession(); // java class���� session ��ü ����
    String act = (String)session.getAttribute("act"); // ���� ����
    
    if (act != null){
      if (act.equals("M") || act.equals("Y")){ // �α��� ����
        sw = true; 
      }
    }
    return sw;
  }
 
  /**
   * ������ �������� �˻��մϴ�. 
   * @param request
   * @return true: ������ ����
   */
  public static synchronized boolean isMaster(HttpServletRequest request){
    boolean sw = false;
    
    HttpSession session = request.getSession();
    String act = (String)session.getAttribute("act"); // ��Ȱ
    // System.out.println("--> Tool.java act: " + act);
    
    if (act != null){
      if (act.equals("M")){ // ���������� �˻�
        sw = true;
      }
    }
    return sw;
  }
   
}
