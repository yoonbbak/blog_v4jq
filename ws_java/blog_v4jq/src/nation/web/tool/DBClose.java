package nation.web.tool;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBClose {
  public void close(Connection con, PreparedStatement pstmt){
    // 전문적으로 메모리를 해제하는 클래스
    try {
      pstmt.close();
    } catch (Exception e) {
    }
    
    try {
      con.close();
    } catch (Exception e) {
    }
    
  }
  public void close(Connection con, PreparedStatement pstmt, ResultSet rs){
    // 전문적으로 메모리를 해제하는 클래스
    try {
      rs.close();
    } catch (Exception e) {
    }

    try {
      pstmt.close();
    } catch (Exception e) {
    }
    
    try {
      con.close();
    } catch (Exception e) {
    }
    
  }
}
