package nation.web.tool;
 

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Date;
 
import javax.servlet.http.HttpServletRequest;
 
import jdk.nashorn.internal.ir.RuntimeNode.Request;
 
public class Log { 
  /**
   * �Ϲ� Ŭ���������� �α� ���
   * @param str
   */
  public static synchronized void w(String str){
    String os = System.getProperty("os.name");
    String path = "";
    
    if (os.indexOf("Window") >= 0){
      path = "C:/ai2/ws_java/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/blog_v4jq/log";
    }else{
      path="/home/hosting_users/�ڽ��� cafe24 ����/tomcat/webapps/ROOT/log";   
    }
    File dir = new File(path);
    if (dir.exists() == false) { 
      dir.mkdir(); // log ���� ����
    }
    
    String file = path + "/" + "log.txt"; // �α� ����
    String Enter = System.getProperty("line.separator"); // Enter
    FileWriter fw = null; // ���� ��� 
    
    try {
      fw = new FileWriter(file, true); // true: �߰� ���
      fw.write(new Date().toLocaleString() + Enter);
      fw.write(str + Enter);
      fw.write("----------------------------------------------------------------------" + Enter);
      fw.flush(); // ���� ���
    } catch (IOException e) {
      e.printStackTrace();
    } finally{
      try {
        fw.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }
 
  /**
   * JSP�� �������� �α� ���
   * @param request
   * @param str
   */
  public static synchronized void w(HttpServletRequest request, String str){
    // /log ������ ��� ����
    String path = request.getServletContext().getRealPath("/log");
    File dir = new File(path);
    if (dir.exists() == false) {
      dir.mkdir();
    }
    
    String file = path + "/" + "log.txt"; // �α� ����
    System.out.println("file: " + file);
    String Enter = System.getProperty("line.separator"); // Enter
    FileWriter fw = null; // ���� ��� 
    
    try {
      fw = new FileWriter(file, true); // true: �߰� ���
      fw.write(new Date().toLocaleString() + " IP: " + request.getRemoteAddr() + Enter);
      fw.write(str + Enter);
      fw.write("----------------------------------------------------------------------" + Enter);
      fw.flush();
    } catch (IOException e) {
      e.printStackTrace();
    } finally{
      try {
        fw.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }
  
  public static void main(String[] args) {
    // Ŭ������ ��ġ�ϴ� ���� ��� ����
    String path = Log.class.getResource("").getPath();
    System.out.println("--> path: " + path);
    // /C:/iot1/ws_web/admin_v1jq/build/classes/web/tool/
    
    System.out.println(System.getProperty("os.name"));
    // Windows 7, Windows 10
    
    w("�ݿ��� 11�� �ڱ��� ����� ź�� ���� ����");
  }
 
}