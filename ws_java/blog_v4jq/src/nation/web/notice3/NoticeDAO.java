package nation.web.notice3;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import nation.web.tool.DBClose;
import nation.web.tool.DBOpen;

public class NoticeDAO {

  Connection con = null; // DBMS 연결
  PreparedStatement pstmt = null; // SQL 실행
  ResultSet rs = null; // SELECT 결과를 저장
  StringBuffer sql = null; // SQL 저장

  DBOpen dbopen = null;
  DBClose dbclose = null;

  public NoticeDAO() {
    this.dbopen = new DBOpen(); // this: 가독성 증가 효과
    this.dbclose = new DBClose();
  }

  public int insert(NoticeVO noticeVO) { // Call by Reference
    int count = 0; // 처리된 레코드 갯수

    try {
      con = new DBOpen().getConnection(); // 추가

      sql = new StringBuffer();
      sql.append(" INSERT INTO notice(title, rname, rdate)");
      sql.append(" VALUES(?, ?, now())");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setString(1, noticeVO.getTitle());
      pstmt.setString(2, noticeVO.getRname());

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt); // 추가
    }
    return count;
  }

  public ArrayList<NoticeVO> list() {

    ArrayList<NoticeVO> list = null;

    try {
      con = new DBOpen().getConnection(); // 추가

      sql = new StringBuffer();
      sql.append(" SELECT noticeno, title, rname, rdate"); // 맨 앞에 공백 한 칸이 있어야함.
      sql.append(" FROM notice");
      sql.append(" ORDER BY noticeno DESC");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      rs = pstmt.executeQuery(); // SELECT SQL 실행

      list = new ArrayList<NoticeVO>();

      // 최초 호출시 첫번째 레코드로 이동하며 그 후 호출부터 다음 레코드로 자동 이동
      while (rs.next()) {
        NoticeVO noticeVO = new NoticeVO();
        // DBMS -> Java
        // 아주 중요한 코드이다 [rs.~]
        noticeVO.setNoticeno(rs.getInt("noticeno"));
        noticeVO.setTitle(rs.getString("title"));
        noticeVO.setRname(rs.getString("rname"));
        noticeVO.setRdate(rs.getString("rdate").substring(0, 10));

        list.add(noticeVO); // 저장
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      new DBClose().close(con, pstmt, rs);
    }
    return list;
  }

  public NoticeVO read(int noticeno) {
    NoticeVO noticeVO = null; // 지역 변수

    try {
      con = new DBOpen().getConnection();

      sql = new StringBuffer();
      sql.append(" SELECT noticeno, title, rname, rdate"); // 맨 앞에 공백 한 칸이 있어야함.
      sql.append(" FROM notice");
      sql.append(" WHERE noticeno = ?");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, noticeno);
      rs = pstmt.executeQuery(); // SELECT SQL 실행

      if (rs.next()) { // 첫번째 레코드로 이동
        noticeVO = new NoticeVO(); // 레코드에 대응할 객체 생성
        // DBMS 컬럼의 값 -> JAVA 변수의 값으로 대입합니다.
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
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection();
      
      sql = new StringBuffer();
      sql.append(" UPDATE notice");
      sql.append(" SET title = ?, rname = ?");
      sql.append(" WHERE noticeno = ?");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      
      pstmt.setString(1, noticeVO.getTitle()); // pstmt.setString(1, title);
      pstmt.setString(2, noticeVO.getRname()); // pstmt.setString(2, rname);
      pstmt.setInt(3, noticeVO.getNoticeno()); // pstmt.setInt(3, noticeno);

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }
  
  public int delete(NoticeVO noticeVO) { // Call By Reference
    int count = 0; // 처리된 레코드 갯수
    
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" DELETE FROM notice");
      sql.append(" WHERE noticeno = ?");
      
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, noticeVO.getNoticeno());
      
      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    
    return count;
  }
  
}