package nation.web.tool;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBOpen {

  public Connection getConnection() {
    Connection con = null; // DBMS ����

    String className = "org.gjt.mm.mysql.Driver"; // MySQL ���� Drvier
    String url = "jdbc:mysql://localhost:3306/javadb?useUnicode=true&characterEncoding=euckr";
    String user = "root";
    String pass = "1234";

    try {
      Class.forName(className); // try-catch���� �ǹ������� ����ϴ� Ŭ����
      con = DriverManager.getConnection(url, user, pass); // MySQL ����

    } catch (ClassNotFoundException e) { // ��Ȯ�� Exception ó��
      e.printStackTrace();
    } catch (SQLException e) {
      e.printStackTrace();
    }
    
    return con;
  }
}
