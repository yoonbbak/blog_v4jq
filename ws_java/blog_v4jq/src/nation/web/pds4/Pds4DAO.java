package nation.web.pds4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import nation.web.tool.DBClose;
import nation.web.tool.DBOpen;

public class Pds4DAO {
  private Connection con = null; // DBMS 연결
  private PreparedStatement pstmt = null; // SQL 실행
  private ResultSet rs = null; // SELECT 결과를 저장
  private StringBuffer sql = null; // SQL 저장

  private DBOpen dbopen = null;
  private DBClose dbclose = null;

  public Pds4DAO() {
    dbopen = new DBOpen();
    dbclose = new DBClose();
  }

  /**
   * 등록(답변형 게시판 기반)
   * 
   * @param pds4VO
   * @return 등록한 갯수
   */
  public int insert(Pds4VO pds4VO) { // call by reference
    int count = 0; // 처리된 레코드 갯수
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" INSERT INTO pds4(categoryno, rname, email, title, content,");
      sql.append(" passwd, cnt, rdate, web, file1, fstor1, thumb, size1, ip, visible, map, youtube, mp3, mp4,");
      sql.append(" grpno, indent, ansnum)");
      sql.append(" VALUES(?, ?, ?, ?, ?, ?, 0, now(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,");
      sql.append(" (SELECT IFNULL(MAX(grpno), 0) + 1 FROM pds4 as grpno), 0, 0); ");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, pds4VO.getCategoryno());
      pstmt.setString(2, pds4VO.getRname());
      pstmt.setString(3, pds4VO.getEmail());
      pstmt.setString(4, pds4VO.getTitle());
      pstmt.setString(5, pds4VO.getContent());
      pstmt.setString(6, pds4VO.getPasswd());
      pstmt.setString(7, pds4VO.getWeb());
      pstmt.setString(8, pds4VO.getFile1());
      pstmt.setString(9, pds4VO.getFstor1());
      pstmt.setString(10, pds4VO.getThumb());
      pstmt.setLong(11, pds4VO.getSize1());
      pstmt.setString(12, pds4VO.getIp());
      pstmt.setString(13, pds4VO.getVisible());
      pstmt.setString(14, pds4VO.getMap());
      pstmt.setString(15, pds4VO.getYoutube());
      pstmt.setString(16, pds4VO.getMp3());
      pstmt.setString(17, pds4VO.getMp4());

      count = pstmt.executeUpdate();

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }

  /**
   * 모든 레코드
   * 
   * @return
   */
  public ArrayList<Pds4VO> list() {
    ArrayList<Pds4VO> list = new ArrayList<Pds4VO>();

    try {
      con = dbopen.getConnection();

      sql = new StringBuffer();

      sql.append(
          " SELECT pdsno, categoryno, rname, email, title, cnt, rdate, web, file1, fstor1, thumb, size1, ip, visible");
      sql.append(" FROM pds4");
      sql.append(" ORDER BY pdsno ASC");

      pstmt = con.prepareStatement(sql.toString());
      rs = pstmt.executeQuery(); // SELECT

      while (rs.next() == true) {
        Pds4VO pds4VO = new Pds4VO();
        pds4VO.setPdsno(rs.getInt("pdsno")); // DBMS -> JAVA 객체
        pds4VO.setCategoryno(rs.getInt("categoryno"));
        pds4VO.setRname(rs.getString("rname"));
        pds4VO.setEmail(rs.getString("email"));
        pds4VO.setTitle(rs.getString("title"));
        pds4VO.setCnt(rs.getInt("cnt"));
        pds4VO.setRdate(rs.getString("rdate").substring(0, 10));
        pds4VO.setWeb(rs.getString("web"));
        pds4VO.setFile1(rs.getString("file1"));
        pds4VO.setFstor1(rs.getString("fstor1"));
        pds4VO.setThumb(rs.getString("thumb"));
        pds4VO.setSize1(rs.getLong("size1"));
        pds4VO.setIp(rs.getString("ip"));
        pds4VO.setVisible(rs.getString("visible"));

        list.add(pds4VO);
      }

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }

    return list;
  }

 /**
  * @param categoryno 카테고리 번호
  * @param col 검색 컬럼
  * @param word 검색어
  * @return 검색 목록
  */
  public ArrayList<Pds4VO> list(String col, String word) {
    ArrayList<Pds4VO> list = new ArrayList<Pds4VO>();

    try {
      con = dbopen.getConnection();

      sql = new StringBuffer();

      sql.append(
          " SELECT pdsno, categoryno, rname, email, title, cnt, rdate, web, file1, fstor1, thumb, size1, ip, visible");
      sql.append(" FROM pds4");
     
      if(col.equals("rname")){
        sql.append(" WHERE rname LIKE ?");
        sql.append(" ORDER BY pdsno DESC");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setString(1, "%" + word + "%");
     
      }else if (col.equals("title")){
        sql.append(" WHERE title LIKE ?");
        sql.append(" ORDER BY pdsno DESC");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setString(1, "%" + word + "%");
      
      }else if(col.equals("content")){
         sql.append(" WHERE content LIKE ?");
         sql.append(" ORDER BY pdsno DESC");
         pstmt = con.prepareStatement(sql.toString());
         pstmt.setString(1, "%" + word + "%");
       
       }else if(col.equals("title_content")){
         sql.append(" WHERE title LIKE ? OR content LIKE ?");
         sql.append(" ORDER BY pdsno DESC");
         pstmt = con.prepareStatement(sql.toString());
         pstmt.setString(1, "%" + word + "%");
         pstmt.setString(2, "%" + word + "%");
      
       }else{ //검색 하지 않는 경우
      sql.append(" ORDER BY pdsno DESC");
      pstmt = con.prepareStatement(sql.toString());
       }
      
      rs = pstmt.executeQuery(); // SELECT

      while (rs.next() == true) {
        Pds4VO pds4VO = new Pds4VO();
        pds4VO.setPdsno(rs.getInt("pdsno")); // DBMS -> JAVA 객체
        pds4VO.setCategoryno(rs.getInt("categoryno"));
        pds4VO.setRname(rs.getString("rname"));
        pds4VO.setEmail(rs.getString("email"));
        pds4VO.setTitle(rs.getString("title"));
        pds4VO.setCnt(rs.getInt("cnt"));
        pds4VO.setRdate(rs.getString("rdate").substring(0, 10));
        pds4VO.setWeb(rs.getString("web"));
        pds4VO.setFile1(rs.getString("file1"));
        pds4VO.setFstor1(rs.getString("fstor1"));
        pds4VO.setThumb(rs.getString("thumb"));
        pds4VO.setSize1(rs.getLong("size1"));
        pds4VO.setIp(rs.getString("ip"));
        pds4VO.setVisible(rs.getString("visible"));

        list.add(pds4VO);
      }

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }

    return list;
  }
  /**
   * 전체 카테고리별 검색
   * 
   * @param category 카테고리
   *          게시판 그룹 번호
   * @return
   */
  public ArrayList<Pds4VO> list_category(int categoryno, String col, String word) {
    ArrayList<Pds4VO> list = new ArrayList<Pds4VO>();

    try {
      con = dbopen.getConnection();

      sql = new StringBuffer();

      sql.append(" SELECT pdsno, categoryno, rname, email, title, cnt, rdate, web, file1, fstor1, thumb, size1, ip, visible");
      sql.append(" FROM pds4");
      
      if(col.equals("rname")){
        sql.append(" WHERE categoryno = ? AND rname LIKE ?");
        sql.append(" ORDER BY pdsno DESC");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setInt(1, categoryno);
        pstmt.setString(2, "%" + word + "%");
     
      }else if (col.equals("title")){
        sql.append(" WHERE categoryno = ? AND title LIKE ?");
        sql.append(" ORDER BY pdsno DESC");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setInt(1, categoryno);
        pstmt.setString(2, "%" + word + "%");
      
      }else if(col.equals("content")){
         sql.append(" WHERE categoryno = ? AND content LIKE ?");
         sql.append(" ORDER BY pdsno DESC");
         pstmt = con.prepareStatement(sql.toString());
         pstmt.setInt(1, categoryno);
         pstmt.setString(2, "%" + word + "%");
       
       }else if(col.equals("title_content")){
         sql.append(" WHERE categoryno = ? AND title LIKE ? OR content LIKE ?"); 
         sql.append(" ORDER BY pdsno DESC");
         pstmt = con.prepareStatement(sql.toString());
         pstmt.setInt(1, categoryno);
         pstmt.setString(2, "%" + word + "%");
         pstmt.setString(3, "%" + word + "%");
      
       }else{ //검색 하지 않는 경우
      sql.append(" WHERE categoryno = ?");
      sql.append(" ORDER BY pdsno DESC");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, categoryno);
       } 

      
      rs = pstmt.executeQuery(); // SELECT

      while (rs.next() == true) {
        Pds4VO pds4VO = new Pds4VO();
        pds4VO.setPdsno(rs.getInt("pdsno")); // DBMS -> JAVA 객체
        pds4VO.setCategoryno(rs.getInt("categoryno"));
        pds4VO.setRname(rs.getString("rname"));
        pds4VO.setEmail(rs.getString("email"));
        pds4VO.setTitle(rs.getString("title"));
        pds4VO.setCnt(rs.getInt("cnt"));
        pds4VO.setRdate(rs.getString("rdate").substring(0, 10));
        pds4VO.setWeb(rs.getString("web"));
        pds4VO.setFile1(rs.getString("file1"));
        pds4VO.setFstor1(rs.getString("fstor1"));
        pds4VO.setThumb(rs.getString("thumb"));
        pds4VO.setSize1(rs.getLong("size1"));
        pds4VO.setIp(rs.getString("ip"));
        pds4VO.setVisible(rs.getString("visible"));

        list.add(pds4VO);
      }

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }

    return list;
  }
  /**
   * 카테고리별 검색
   * 
   * @param category 카테고리
   *          게시판 그룹 번호
   * @return
   */
  public ArrayList<Pds4VO> list_category(int categoryno) {
    ArrayList<Pds4VO> list = new ArrayList<Pds4VO>();
    
    try {
      con = dbopen.getConnection();
      
      sql = new StringBuffer();
      
      sql.append(" SELECT pdsno, categoryno, rname, email, title, cnt, rdate, web, file1, fstor1, thumb, size1, ip, visible");
      sql.append(" FROM pds4");
      sql.append(" WHERE categoryno = ?");
      sql.append(" ORDER BY pdsno DESC");
      
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, categoryno);
     
      rs = pstmt.executeQuery(); // SELECT
      
      while (rs.next() == true) {
        Pds4VO pds4VO = new Pds4VO();
        pds4VO.setPdsno(rs.getInt("pdsno")); // DBMS -> JAVA 객체
        pds4VO.setCategoryno(rs.getInt("categoryno"));
        pds4VO.setRname(rs.getString("rname"));
        pds4VO.setEmail(rs.getString("email"));
        pds4VO.setTitle(rs.getString("title"));
        pds4VO.setCnt(rs.getInt("cnt"));
        pds4VO.setRdate(rs.getString("rdate").substring(0, 10));
        pds4VO.setWeb(rs.getString("web"));
        pds4VO.setFile1(rs.getString("file1"));
        pds4VO.setFstor1(rs.getString("fstor1"));
        pds4VO.setThumb(rs.getString("thumb"));
        pds4VO.setSize1(rs.getLong("size1"));
        pds4VO.setIp(rs.getString("ip"));
        pds4VO.setVisible(rs.getString("visible"));
        
        list.add(pds4VO);
      }
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
    
    return list;
  }

  /**
   * 조회수 증가
   * 
   * @param pdsno
   */
  public void increaseCnt(int pdsno) { // call by value
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection(); // 추가

      sql = new StringBuffer();
      sql.append(" UPDATE pds4");
      sql.append(" SET cnt = cnt + 1");
      sql.append(" WHERE pdsno=?");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, pdsno);

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // 추가
    }
  }

  /**
   * 조회
   * 
   * @return
   */
  public Pds4VO read(int pdsno) {
    Pds4VO pds4VO = null;

    try {
      con = dbopen.getConnection();

      sql = new StringBuffer();

      sql.append(
          " SELECT pdsno, categoryno, rname, email, title, content, passwd, cnt, rdate, web, file1, fstor1, thumb, size1, map, youtube, mp3, mp4, ip, visible, grpno, indent, ansnum");
      sql.append(" FROM pds4");
      sql.append(" WHERE pdsno=?");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, pdsno);
      rs = pstmt.executeQuery(); // SELECT

      if (rs.next() == true) {
        pds4VO = new Pds4VO();
        pds4VO.setPdsno(rs.getInt("pdsno")); // DBMS -> JAVA 객체
        pds4VO.setCategoryno(rs.getInt("categoryno"));
        pds4VO.setRname(rs.getString("rname"));
        pds4VO.setEmail(rs.getString("email"));
        pds4VO.setTitle(rs.getString("title"));
        pds4VO.setContent(rs.getString("content"));
        pds4VO.setCnt(rs.getInt("cnt"));
        pds4VO.setRdate(rs.getString("rdate").substring(0, 10));
        pds4VO.setWeb(rs.getString("web"));
        pds4VO.setFile1(rs.getString("file1"));
        pds4VO.setFstor1(rs.getString("fstor1"));
        pds4VO.setThumb(rs.getString("thumb"));
        pds4VO.setSize1(rs.getLong("size1"));
        pds4VO.setIp(rs.getString("ip"));
        pds4VO.setVisible(rs.getString("visible"));
        pds4VO.setMap(rs.getString("map"));
        pds4VO.setYoutube(rs.getString("youtube"));
        pds4VO.setMp3(rs.getString("mp3"));
        pds4VO.setMp4(rs.getString("mp4")); 
        pds4VO.setGrpno(rs.getInt("grpno")); 
        pds4VO.setIndent(rs.getInt("indent")); 
        pds4VO.setAnsnum(rs.getInt("ansnum")); 

      }

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }

    return pds4VO;
  }

  /**
   * 패스워드를 검사합니다.
   * 
   * @param pdsno
   * @param passwd
   * @return 레코드 개수, 1 or 0
   */
  public int passwordCheck(int pdsno, String passwd) {
    int count = 0;

    try {
      con = dbopen.getConnection();

      sql = new StringBuffer();

      sql.append(" SELECT COUNT(*) as cnt ");
      sql.append(" FROM pds4");
      sql.append(" WHERE pdsno = ? AND passwd = ? ");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, pdsno);
      pstmt.setString(2, passwd);
      rs = pstmt.executeQuery(); // SELECT

      if (rs.next() == true) {
        count = rs.getInt("cnt");

      }

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }

    return count;
  }

  /**
   * 글 수정
   * 
   * @param pds4VO
   * @return 처리한 개수
   */
  public int update(Pds4VO pds4VO) { // call by reference
    int count = 0; // 처리된 레코드 갯수
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE pds4");
      sql.append(" SET rname = ?, email = ?, title = ?,");
      sql.append("       content = ?, web = ?");
      sql.append(" WHERE pdsno = ?");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, pds4VO.getRname());
      pstmt.setString(2, pds4VO.getEmail());
      pstmt.setString(3, pds4VO.getTitle());
      pstmt.setString(4, pds4VO.getContent());
      pstmt.setString(5, pds4VO.getWeb());
      pstmt.setInt(6, pds4VO.getPdsno());

      count = pstmt.executeUpdate();

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }

  /**
   * Visible 모드 변경
   * 
   * @param pdsno
   * @param visible
   *          Y/N
   * @return 처리한 갯수
   */
  public int show_hide(int pdsno, String visible) {
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection(); // 추가

      sql = new StringBuffer();
      sql.append(" UPDATE pdsno");
      sql.append(" SET visible=?");
      sql.append(" WHERE pdsno=?");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setString(1, visible);
      pstmt.setInt(2, pdsno);

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // 추가
    }

    return count;
  }

  /**
   * 수정시 참고자료 변경(파일변경)
   * 
   * @param pds4VO
   * @return
   */
  public int update_file1(Pds4VO pds4VO) {
    int count = 0; // 처리된 레코드 갯수
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE pds4");
      sql.append(" SET file1 = ?, fstor1 = ?, thumb = ?, size1 = ?");
      sql.append(" WHERE pdsno = ?");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, pds4VO.getFile1());
      pstmt.setString(2, pds4VO.getFstor1());
      pstmt.setString(3, pds4VO.getThumb());
      pstmt.setLong(4, pds4VO.getSize1());
      pstmt.setInt(5, pds4VO.getPdsno());

      count = pstmt.executeUpdate();

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }

  /**
   * 맵 삭제
   * 
   * @param 삭제할
   *          PK 번호
   * @return 처리한 갯수
   */
  public int update_map(Pds4VO pds4VO) {
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE pds4 ");
      sql.append(" SET map= ? ");
      sql.append(" WHERE pdsno = ? ");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, pds4VO.getMap());
      pstmt.setInt(2, pds4VO.getPdsno());

      count = pstmt.executeUpdate();

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }

  /**
   * Map 삭제
   * 
   * @param pdsno
   * @return
   */
  public int delete_map(Pds4VO pds4VO) {
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE pds4 ");
      sql.append(" SET map = ? ");
      sql.append(" WHERE pdsno = ? ");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, pds4VO.getMap());
      pstmt.setInt(2, pds4VO.getPdsno());

      count = pstmt.executeUpdate();

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }

  /**
   * 글 삭제
   * 
   * @param pdsno
   * @return
   */
  public int delete(int pdsno) {
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" DELETE FROM pds4");
      sql.append(" WHERE pdsno = ?");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      pstmt.setInt(1, pdsno);

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }

  /**
   * Youtube 변경
   * 
   * @param pdsno
   * @return
   */
  public int update_youtube(Pds4VO pds4VO) {
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE pds4 ");
      sql.append(" SET youtube = ? ");
      sql.append(" WHERE pdsno = ? ");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, pds4VO.getYoutube());
      pstmt.setInt(2, pds4VO.getPdsno());

      count = pstmt.executeUpdate();

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }

  
  /**
   * Youtube 삭제
   * 
   * @param pdsno
   * @return
   */
  public int delete_youtube(Pds4VO pds4VO) {
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE pds4 ");
      sql.append(" SET youtube = ? ");
      sql.append(" WHERE pdsno = ? ");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, pds4VO.getYoutube());
      pstmt.setInt(2, pds4VO.getPdsno());

      count = pstmt.executeUpdate();

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }
  
  /**
   * MP3 파일 변경
   * @param pdsno
   * @return
   */
  public int update_mp3(Pds4VO pds4VO) {
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE pds4 ");
      sql.append(" SET mp3 = ? ");
      sql.append(" WHERE pdsno = ? ");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, pds4VO.getMp3());
      pstmt.setInt(2, pds4VO.getPdsno());

      count = pstmt.executeUpdate();

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }
  
  
  /**
   * MP3 삭제
   * @param pdsno
   * @return
   */
  public int delete_mp3(Pds4VO pds4VO) {
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE pds4 ");
      sql.append(" SET mp3 = ? ");
      sql.append(" WHERE pdsno = ? ");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, pds4VO.getMp3());
      pstmt.setInt(2, pds4VO.getPdsno());

      count = pstmt.executeUpdate();

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }
  
  
  /**
   * MP4 파일 등록 및 삭제 및 변경
   * @param pdsno
   * @return
   */
  public int update_mp4(Pds4VO pds4VO) {
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" UPDATE pds4 ");
      sql.append(" SET mp4 = ? ");
      sql.append(" WHERE pdsno = ? ");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setString(1, pds4VO.getMp4());
      pstmt.setInt(2, pds4VO.getPdsno());

      count = pstmt.executeUpdate();

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }
  
  /**
   * 카테고리별로 검색된 레코드 갯수
   * 
   * @return
   */
  public int count(int categoryno, String col, String word) {
    int count = 0;
  
    try {
      con = dbopen.getConnection();
  
      sql = new StringBuffer();
      sql.append(" SELECT COUNT(pdsno) as cnt ");
      sql.append(" FROM pds4");
      
      if (col.equals("rname")) {
        sql.append(" WHERE categoryno = ? AND rname LIKE ?");
        sql.append(" ORDER BY grpno DESC, pdsno ASC");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setInt(1, categoryno);
        pstmt.setString(2, "%" + word + "%");
      } else if (col.equals("title")) {
        sql.append(" WHERE categoryno = ? AND  title LIKE ?");
        sql.append(" ORDER BY grpno DESC, pdsno ASC");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setInt(1, categoryno);
        pstmt.setString(2, "%" + word + "%");
      } else if (col.equals("content")) {
        sql.append(" WHERE categoryno = ? AND  content LIKE ?");
        sql.append(" ORDER BY grpno DESC, pdsno ASC");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setInt(1, categoryno);
        pstmt.setString(2, "%" + word + "%");
      } else if (col.equals("title_content")) {
        sql.append(" WHERE categoryno = ? AND (title LIKE ? OR content LIKE ?)");
        sql.append(" ORDER BY grpno DESC, pdsno ASC");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setInt(1, categoryno);
        pstmt.setString(2, "%" + word + "%");
        pstmt.setString(3, "%" + word + "%");
      } else { // 검색하지 않는 경우
        sql.append(" WHERE categoryno = ?");
        sql.append(" ORDER BY grpno DESC, pdsno ASC");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setInt(1, categoryno);
      }
  
      rs = pstmt.executeQuery(); // SELECT
  
      if (rs.next() == true) {
        count = rs.getInt("cnt");
      }
  
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
  
    return count;
  }
  
  /**
   * 카테고리별로 검색 및 페이징이 구현된 목록, SELECT된 목록중에
   * 페이징 기법을 이용하여 특정 레코드 부분(10개)만 가져옵니다. 
   * @param categoryno 카테고리 번호
   * @param col 검색 컬럼
   * @param word 검색어
   * @param offset skip할 레코드 갯수
   * @param recordPerPage 페이지당 출력할 레코드 갯수
   * @return 검색 목록
   */
  public ArrayList<Pds4VO> list_category(
      int categoryno, 
      String col, 
      String word,  
      int offset, //스킵
      int recordPerPage) {
    ArrayList<Pds4VO> list = new ArrayList<Pds4VO>();
 
    try {
      con = dbopen.getConnection();
  
      sql = new StringBuffer();
      sql.append(" SELECT pdsno, categoryno, rname, email, title, content, passwd, cnt,");
      sql.append("            SUBSTRING(rdate, 1, 16) as rdate, web, file1, fstor1,");
      sql.append("            thumb, size1, map, youtube, mp3, mp4, ip, visible, grpno, indent, ansnum ");
      sql.append(" FROM pds4"); 
      
      if (col.equals("rname")) {
        sql.append(" WHERE categoryno = ? AND rname LIKE ?");
        sql.append(" ORDER BY grpno DESC, ansnum ASC");
        // sql.append(" LIMIT " + offset + ", " + record_per_page);
        sql.append(" LIMIT ?, ?");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setInt(1, categoryno);
        pstmt.setString(2, "%" + word + "%");
        pstmt.setInt(3, offset);
        pstmt.setInt(4, recordPerPage);
      } else if (col.equals("title")) {
        sql.append(" WHERE categoryno = ? AND  title LIKE ?");
        sql.append(" ORDER BY pdsno DESC");
        sql.append(" LIMIT ?, ?");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setInt(1, categoryno);
        pstmt.setString(2, "%" + word + "%");
        pstmt.setInt(3, offset);
        pstmt.setInt(4, recordPerPage);
      } else if (col.equals("content")) {
        sql.append(" WHERE categoryno = ? AND  content LIKE ?");
        sql.append(" ORDER BY pdsno DESC");
        sql.append(" LIMIT ?, ?");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setInt(1, categoryno);
        pstmt.setString(2, "%" + word + "%");
        pstmt.setInt(3, offset);
        pstmt.setInt(4, recordPerPage);
      } else if (col.equals("title_content")) {
        sql.append(" WHERE categoryno = ? AND (title LIKE ? OR content LIKE ?)");
        sql.append(" ORDER BY pdsno DESC");
        sql.append(" LIMIT ?, ?");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setInt(1, categoryno);
        pstmt.setString(2, "%" + word + "%");
        pstmt.setString(3, "%" + word + "%");
        pstmt.setInt(4, offset);
        pstmt.setInt(5, recordPerPage);
      } else { // 검색하지 않는 경우
        sql.append(" WHERE categoryno = ?");
        sql.append(" ORDER BY pdsno DESC");
        sql.append(" LIMIT ?, ?");
        pstmt = con.prepareStatement(sql.toString());
        pstmt.setInt(1, categoryno);
        pstmt.setInt(2, offset);
        pstmt.setInt(3, recordPerPage);
      }
  
      rs = pstmt.executeQuery(); // SELECT
  
      while (rs.next() == true) {
        Pds4VO pds4VO = new Pds4VO();
        pds4VO.setPdsno(rs.getInt("pdsno")); // DBMS -> JAVA 객체
        pds4VO.setCategoryno(rs.getInt("categoryno"));
        pds4VO.setRname(rs.getString("rname"));
        pds4VO.setEmail(rs.getString("email"));
        pds4VO.setTitle(rs.getString("title"));
        pds4VO.setContent(rs.getString("content"));
        pds4VO.setPasswd(rs.getString("passwd"));
        pds4VO.setCnt(rs.getInt("cnt"));
        pds4VO.setRdate(rs.getString("rdate"));
        pds4VO.setWeb(rs.getString("web"));
        pds4VO.setFile1(rs.getString("file1"));
        pds4VO.setFstor1(rs.getString("fstor1"));
        pds4VO.setThumb(rs.getString("thumb"));
        pds4VO.setSize1(rs.getLong("size1"));
        pds4VO.setMap(rs.getString("map"));
        pds4VO.setYoutube(rs.getString("youtube"));
        pds4VO.setMp3(rs.getString("mp3"));
        // System.out.println("rs.getString(\"mp3\"): " + rs.getString("mp3"));
        // System.out.println("pds4VO.getMp3(\"mp3\"): " + pds4VO.getMp3());
        pds4VO.setMp4(rs.getString("mp4"));
        
        pds4VO.setGrpno(rs.getInt("grpno"));
        pds4VO.setIndent(rs.getInt("indent"));
        pds4VO.setAnsnum(rs.getInt("ansnum"));
   
        pds4VO.setIp(rs.getString("ip"));
        pds4VO.setVisible(rs.getString("visible"));
        
        list.add(pds4VO);
      }
  
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
  
    return list;
  }
 
  /**
   * 카테고리별 레코드 갯수
   * 
   * @return
   */
  public int countByCategory(int categoryno) {
    int count = 0;
  
    try {
      con = dbopen.getConnection();
  
      sql = new StringBuffer();
      sql.append(" SELECT COUNT(pdsno) as cnt ");
      sql.append(" FROM pds4");
      sql.append(" WHERE categoryno = ?");
      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, categoryno);
  
      rs = pstmt.executeQuery(); // SELECT
  
      if (rs.next() == true) {
        count = rs.getInt("cnt");
      }
  
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
  
    return count;
  } 
  
  /**
   * 조회수 증가
   * 기존에 등록된 답변의 seqno 증가 처리
   * <xmp>
   * UPDATE pds4
   * SET ansnum = ansnum + 1
   * WHERE categoryno = 1 AND grpno = 1 AND ansnum > 0;
   * </xmp>
   * @param pdsno
   */
  public void increaseAnsnum(int categoryno, int grpno, int ansnum) { // call by value
    int count = 0; // 처리된 레코드 갯수

    try {
      con = dbopen.getConnection(); // 추가

      sql = new StringBuffer();
      sql.append(" UPDATE pds4");
      sql.append(" SET ansnum = ansnum + 1");
      sql.append(" WHERE categoryno = ? AND grpno = ? AND ansnum > ?");

      pstmt = con.prepareStatement(sql.toString()); // SQL 실행 객체 생성
      
      pstmt.setInt(1, categoryno);
      pstmt.setInt(2, grpno);
      pstmt.setInt(3, ansnum);

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL 실행

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // 추가
    }
  }
  
  /**
   * 답변 등록(답변형 게시판 기반)
   * 
   * @param pds4VO
   * @return 등록한 갯수
   */
  public int reply(Pds4VO pds4VO) { // call by reference
    int count = 0; // 처리된 레코드 갯수
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" INSERT INTO pds4(categoryno, rname, email, title, content,");
      sql.append(" passwd, cnt, rdate, web, file1, fstor1, thumb, size1, ip, visible, map, youtube, mp3, mp4,");
      sql.append(" grpno, indent, ansnum)");
      sql.append(" VALUES(?, ?, ?, ?, ?, ?, 0, now(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,");
      sql.append(" ?, ?, ? ");

      pstmt = con.prepareStatement(sql.toString());
      pstmt.setInt(1, pds4VO.getCategoryno());
      pstmt.setString(2, pds4VO.getRname());
      pstmt.setString(3, pds4VO.getEmail());
      pstmt.setString(4, pds4VO.getTitle());
      pstmt.setString(5, pds4VO.getContent());
      pstmt.setString(6, pds4VO.getPasswd());
      pstmt.setString(7, pds4VO.getWeb());
      pstmt.setString(8, pds4VO.getFile1());
      pstmt.setString(9, pds4VO.getFstor1());
      pstmt.setString(10, pds4VO.getThumb());
      pstmt.setLong(11, pds4VO.getSize1());
      pstmt.setString(12, pds4VO.getIp());
      pstmt.setString(13, pds4VO.getVisible());
      pstmt.setString(14, pds4VO.getMap());
      pstmt.setString(15, pds4VO.getYoutube());
      pstmt.setString(16, pds4VO.getMp3());
      pstmt.setString(17, pds4VO.getMp4());
      pstmt.setInt(18,  pds4VO.getGrpno());
      pstmt.setInt(19,  pds4VO.getIndent());
      pstmt.setInt(20,  pds4VO.getAnsnum());
      
      count = pstmt.executeUpdate();

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }

    return count;
  }
  
  
}