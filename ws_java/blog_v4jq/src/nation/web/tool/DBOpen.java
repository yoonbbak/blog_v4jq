package nation.web.tool;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBOpen {

  public Connection getConnection() {
    Connection con = null; // DBMS 연결

    String className = "org.gjt.mm.mysql.Driver"; // MySQL 연결 Drvier
    String url = "jdbc:mysql://localhost:3306/javadb?useUnicode=true&characterEncoding=euckr";
    String user = "root";
    String pass = "1234";

    try {
      Class.forName(className); // try-catch문을 의무적으로 써야하는 클래스
      con = DriverManager.getConnection(url, user, pass); // MySQL 연결

    } catch (ClassNotFoundException e) { // 정확한 Exception 처리
      e.printStackTrace();
    } catch (SQLException e) {
      e.printStackTrace();
    }
    
    return con;
  }
}
