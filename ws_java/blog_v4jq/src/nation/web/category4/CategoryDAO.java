package nation.web.category4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import nation.web.category4.CategoryVO;
import nation.web.tool.DBClose;
import nation.web.tool.DBOpen;

public class CategoryDAO {
  private Connection con = null; // DBMS 연결
  private PreparedStatement pstmt = null; // SQL 실행
  private ResultSet rs = null; // SELECT 결과를 저장
  private StringBuffer sql = null; // SQL 저장

  private DBOpen dbopen = null;
  private DBClose dbclose = null;

  public CategoryDAO() {
    dbopen = new DBOpen();
    dbclose = new DBClose();
  }

  // documentation API 추가
  /**
   * 카테고리 등록
   * 
   * @param categoryVO
   * @return 등록된 갯수 1 or 0
   */
  public int insert(CategoryVO categoryVO) { // Call by Reference
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection(); // 추가

      sql = new StringBuffer();
      sql.append(" INSERT INTO category(title, seqno, visible, ids, cnt)");
      sql.append(" VALUES(?, ?, ?, ?, 0)");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setString(1, categoryVO.getTitle());
//      if(categoryVO.getTitle() == null){
//        System.out.println("title: null");
//      }else{
//        System.out.println("title: not null");
//        System.out.println("categoryVO.getTitle(): " + categoryVO.getTitle().length());
//      }
      pstmt.setInt(2, categoryVO.getSeqno());
      pstmt.setString(3, categoryVO.getVisible());
      pstmt.setString(4, categoryVO.getIds());

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // 추가
    }

    return count;
  }

  /**
   * 모든 카테고리 목록
   * 
   * @return list
   */
  public ArrayList<CategoryVO> list() {

    ArrayList<CategoryVO> list = null;

    try {
      con = dbopen.getConnection(); // 추가

      sql = new StringBuffer();
      sql.append(" SELECT categoryno, title, seqno, visible, ids, cnt");  
      sql.append(" FROM category");
      sql.append(" ORDER BY seqno ASC");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      rs = pstmt.executeQuery(); // SELECT SQL 실행

      list = new ArrayList<CategoryVO>(); // 객체를 만들어 저장

      // 최초 호출시 첫번째 레코드로 이동하며 그 후 호출부터 다음 레코드로 자동 이동
      while (rs.next()) {
        CategoryVO categoryVO = new CategoryVO();
        // DBMS -> Java
        // 아주 중요한 코드이다 [rs.~]
        categoryVO.setCategoryno(rs.getInt("categoryno"));
        categoryVO.setTitle(rs.getString("title"));
        categoryVO.setSeqno(rs.getInt("seqno"));
        categoryVO.setVisible(rs.getString("visible"));
        categoryVO.setIds(rs.getString("ids"));
        categoryVO.setCnt(rs.getInt("cnt"));

        list.add(categoryVO); // 저장
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
    return list;
  }

  /**
   * 한 건의 레코드 조회
   * @param categoryno 조회할 번호
   * @return categoryVO
   */
  public CategoryVO read(int categoryno) {
    CategoryVO categoryVO = null; // 지역 변수

    try {
      con = dbopen.getConnection();

      sql = new StringBuffer();
      sql.append(" SELECT categoryno, title, seqno, visible, ids, cnt"); 
      sql.append(" FROM category");
      sql.append(" WHERE categoryno = ?");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, categoryno);
      rs = pstmt.executeQuery(); // SELECT SQL 실행

      categoryVO = new CategoryVO(); // 레코드에 대응할 객체 생성
      
      if (rs.next()) { // 첫번째 레코드로 이동
        // DBMS 컬럼의 값 -> JAVA 변수의 값으로 대입합니다.
        categoryVO.setCategoryno(rs.getInt("categoryno"));
        categoryVO.setTitle(rs.getString("title"));
        categoryVO.setSeqno(rs.getInt("seqno"));
        categoryVO.setVisible(rs.getString("visible"));
        categoryVO.setIds(rs.getString("ids"));
        categoryVO.setCnt(rs.getInt("cnt"));
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }

    return categoryVO;
  }
  
  /**
   * 카테고리 수정
   * 
   * @param categoryVO
   * @return 수정된 갯수 1 or 0
   */
  public int update(CategoryVO categoryVO) { // Call by Reference
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection(); // 추가

      sql = new StringBuffer();
      sql.append(" UPDATE category");
      sql.append(" SET title = ?, seqno=?, visible=?, ids=?");
      sql.append(" WHERE categoryno=?");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setString(1, categoryVO.getTitle());
      pstmt.setInt(2, categoryVO.getSeqno());
      pstmt.setString(3, categoryVO.getVisible());
      pstmt.setString(4, categoryVO.getIds());
      pstmt.setInt(5, categoryVO.getCategoryno());

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // 추가
    }

    return count;
  }
  
  /**
   * 출력 순서의 낮춤(나중에 출력)
   * @param categoryVO
   * @return 수정된 갯수 0 or 1
   */
  public int increaseSeqno(int categoryno) {
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection(); // 추가

      sql = new StringBuffer();
      sql.append(" UPDATE category");
      sql.append(" SET seqno = seqno + 1");
      sql.append(" WHERE categoryno=?");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, categoryno);

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // 추가
    }

    return count;
  }
  
  /**
   * 출력 순서의 높임(먼저 출력)
   * @param categoryVO
   * @return 수정된 갯수 0 or 1
   */
  public int decreaseSeqno(int categoryno) {
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection(); // 추가

      sql = new StringBuffer();
      sql.append(" UPDATE category");
      sql.append(" SET seqno = seqno - 1");
      sql.append(" WHERE categoryno=?");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, categoryno);

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // 추가
    }

    return count;
  }
  
  /**
   * 게시판 공개
   * @param categoryVO
   * @return 수정여부 0 or 1
   */
  public int show(int categoryno) {
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection(); // 추가

      sql = new StringBuffer();
      sql.append(" UPDATE category");
      sql.append(" SET visible='Y'");
      sql.append(" WHERE categoryno=?");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, categoryno);

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // 추가
    }

    return count;
  }
  
  /**
   * 게시판 숨김
   * @param categoryVO
   * @return 수정여부 0 or 1
   */
  public int hide(int categoryno) {
    int count = 0; // 처리된 레코드 갯수
    
    try {
      con = dbopen.getConnection(); // 추가
      
      sql = new StringBuffer();
      sql.append(" UPDATE category");
      sql.append(" SET visible='N'");
      sql.append(" WHERE categoryno=?");
      
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, categoryno);
      
      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // 추가
    }
    
    return count;
  }
  
  /**
   * 출력 순서의 최댓값
   * @return seqno; max(seqno)+1
   */
  public int getMaxSeqno() {
    int seqno = 0;

    try {
      con = dbopen.getConnection();

      sql = new StringBuffer();
      sql.append(" SELECT MAX(seqno)+1 as seqno"); 
      sql.append(" FROM category");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      rs = pstmt.executeQuery(); // SELECT SQL 실행

      if (rs.next()) { // 첫번째 레코드로 이동
        // DBMS -> JAVA
        seqno = rs.getInt("seqno");
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }

    return seqno;
  }
  
  /**
   * 카테고리 삭제
   * @param categoryno
   * @return 삭제된 레코드 갯수 1 or 0
   */
  public int delete(int categoryno) {
    int count = 0; // 처리된 레코드 갯수
    
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" DELETE FROM category");
      sql.append(" WHERE categoryno = ?");
      
      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, categoryno);
      
      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    
    return count;
  }
  /**
   * 관련 게시판 글수의 증가
   * @param categoryno
   * @return
   */
  public int increaseCnt(int categoryno) { // call by reference
    int count = 0;                     // 처리된 레코드 갯수
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE category");
      sql.append(" SET cnt = cnt + 1");
      sql.append(" WHERE categoryno=?");
      
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, categoryno);
  
      count = pstmt.executeUpdate();
      
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    
    return count;
  }
 
  /**
   * 관련 게시판 글수의 감소
   * @param categoryno
   * @return
   */
  public int decreaseCnt(int categoryno) { // call by reference
    int count = 0;                     // 처리된 레코드 갯수
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE category");
      sql.append(" SET cnt = cnt - 1");
      sql.append(" WHERE categoryno=?");
      
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, categoryno);
  
      count = pstmt.executeUpdate();
      
    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    
    return count;
  }
  
 
}