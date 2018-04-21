package nation.web.notice3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import nation.web.tool.DBClose;
import nation.web.tool.DBOpen;

public class NoticeDAO {

  Connection con = null; // DBMS ����
  PreparedStatement pstmt = null; // SQL ����
  ResultSet rs = null; // SELECT ����� ����
  StringBuffer sql = null; // SQL ����

  DBOpen dbopen = null;
  DBClose dbclose = null;

  public NoticeDAO() {
    this.dbopen = new DBOpen(); // this: ������ ���� ȿ��
    this.dbclose = new DBClose();
  }

  public int insert(NoticeVO noticeVO) { // Call by Reference
    int count = 0; // ó���� ���ڵ� ����

    try {
      con = new DBOpen().getConnection(); // �߰�

      sql = new StringBuffer();
      sql.append(" INSERT INTO notice(title, rname, rdate)");
      sql.append(" VALUES(?, ?, now())");

      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      pstmt.setString(1, noticeVO.getTitle());
      pstmt.setString(2, noticeVO.getRname());

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL ����

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt); // �߰�
    }
    return count;
  }

  public ArrayList<NoticeVO> list() {

    ArrayList<NoticeVO> list = null;

    try {
      con = new DBOpen().getConnection(); // �߰�

      sql = new StringBuffer();
      sql.append(" SELECT noticeno, title, rname, rdate"); // �� �տ� ���� �� ĭ�� �־����.
      sql.append(" FROM notice");
      sql.append(" ORDER BY noticeno DESC");

      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      rs = pstmt.executeQuery(); // SELECT SQL ����

      list = new ArrayList<NoticeVO>();

      // ���� ȣ��� ù��° ���ڵ�� �̵��ϸ� �� �� ȣ����� ���� ���ڵ�� �ڵ� �̵�
      while (rs.next()) {
        NoticeVO noticeVO = new NoticeVO();
        // DBMS -> Java
        // ���� �߿��� �ڵ��̴� [rs.~]
        noticeVO.setNoticeno(rs.getInt("noticeno"));
        noticeVO.setTitle(rs.getString("title"));
        noticeVO.setRname(rs.getString("rname"));
        noticeVO.setRdate(rs.getString("rdate").substring(0, 10));

        list.add(noticeVO); // ����
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt, rs);
    }
    return list;
  }

  public NoticeVO read(int noticeno) {
    NoticeVO noticeVO = null; // ���� ����

    try {
      con = new DBOpen().getConnection();

      sql = new StringBuffer();
      sql.append(" SELECT noticeno, title, rname, rdate"); // �� �տ� ���� �� ĭ�� �־����.
      sql.append(" FROM notice");
      sql.append(" WHERE noticeno = ?");

      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      pstmt.setInt(1, noticeno);
      rs = pstmt.executeQuery(); // SELECT SQL ����

      if (rs.next()) { // ù��° ���ڵ�� �̵�
        noticeVO = new NoticeVO(); // ���ڵ忡 ������ ��ü ����
        // DBMS �÷��� �� -> JAVA ������ ������ �����մϴ�.
        noticeVO.setNoticeno(rs.getInt("noticeno"));
        noticeVO.setTitle(rs.getString("title"));
        noticeVO.setRname(rs.getString("rname"));
        noticeVO.setRdate(rs.getString("rdate").substring(0, 10));
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }

    return noticeVO;
  }

  public int update(NoticeVO noticeVO) { // Call By Reference
    int count = 0; // ó���� ���ڵ� ����

    try {
      con = dbopen.getConnection();
      
      sql = new StringBuffer();
      sql.append(" UPDATE notice");
      sql.append(" SET title = ?, rname = ?");
      sql.append(" WHERE noticeno = ?");

      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      
      pstmt.setString(1, noticeVO.getTitle()); // pstmt.setString(1, title);
      pstmt.setString(2, noticeVO.getRname()); // pstmt.setString(2, rname);
      pstmt.setInt(3, noticeVO.getNoticeno()); // pstmt.setInt(3, noticeno);

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL ����

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }
  
  public int delete(NoticeVO noticeVO) { // Call By Reference
    int count = 0; // ó���� ���ڵ� ����
    
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" DELETE FROM notice");
      sql.append(" WHERE noticeno = ?");
      
      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      pstmt.setInt(1, noticeVO.getNoticeno());
      
      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL ����
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    
    return count;
  }
  
}