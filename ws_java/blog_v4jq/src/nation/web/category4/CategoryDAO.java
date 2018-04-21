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
  private Connection con = null; // DBMS ����
  private PreparedStatement pstmt = null; // SQL ����
  private ResultSet rs = null; // SELECT ����� ����
  private StringBuffer sql = null; // SQL ����

  private DBOpen dbopen = null;
  private DBClose dbclose = null;

  public CategoryDAO() {
    dbopen = new DBOpen();
    dbclose = new DBClose();
  }

  // documentation API �߰�
  /**
   * ī�װ� ���
   * 
   * @param categoryVO
   * @return ��ϵ� ���� 1 or 0
   */
  public int insert(CategoryVO categoryVO) { // Call by Reference
    int count = 0; // ó���� ���ڵ� ����

    try {
      con = dbopen.getConnection(); // �߰�

      sql = new StringBuffer();
      sql.append(" INSERT INTO category(title, seqno, visible, ids, cnt)");
      sql.append(" VALUES(?, ?, ?, ?, 0)");

      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
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

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL ����

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // �߰�
    }

    return count;
  }

  /**
   * ��� ī�װ� ���
   * 
   * @return list
   */
  public ArrayList<CategoryVO> list() {

    ArrayList<CategoryVO> list = null;

    try {
      con = dbopen.getConnection(); // �߰�

      sql = new StringBuffer();
      sql.append(" SELECT categoryno, title, seqno, visible, ids, cnt");  
      sql.append(" FROM category");
      sql.append(" ORDER BY seqno ASC");

      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      rs = pstmt.executeQuery(); // SELECT SQL ����

      list = new ArrayList<CategoryVO>(); // ��ü�� ����� ����

      // ���� ȣ��� ù��° ���ڵ�� �̵��ϸ� �� �� ȣ����� ���� ���ڵ�� �ڵ� �̵�
      while (rs.next()) {
        CategoryVO categoryVO = new CategoryVO();
        // DBMS -> Java
        // ���� �߿��� �ڵ��̴� [rs.~]
        categoryVO.setCategoryno(rs.getInt("categoryno"));
        categoryVO.setTitle(rs.getString("title"));
        categoryVO.setSeqno(rs.getInt("seqno"));
        categoryVO.setVisible(rs.getString("visible"));
        categoryVO.setIds(rs.getString("ids"));
        categoryVO.setCnt(rs.getInt("cnt"));

        list.add(categoryVO); // ����
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt, rs);
    }
    return list;
  }

  /**
   * �� ���� ���ڵ� ��ȸ
   * @param categoryno ��ȸ�� ��ȣ
   * @return categoryVO
   */
  public CategoryVO read(int categoryno) {
    CategoryVO categoryVO = null; // ���� ����

    try {
      con = dbopen.getConnection();

      sql = new StringBuffer();
      sql.append(" SELECT categoryno, title, seqno, visible, ids, cnt"); 
      sql.append(" FROM category");
      sql.append(" WHERE categoryno = ?");

      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      pstmt.setInt(1, categoryno);
      rs = pstmt.executeQuery(); // SELECT SQL ����

      categoryVO = new CategoryVO(); // ���ڵ忡 ������ ��ü ����
      
      if (rs.next()) { // ù��° ���ڵ�� �̵�
        // DBMS �÷��� �� -> JAVA ������ ������ �����մϴ�.
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
   * ī�װ� ����
   * 
   * @param categoryVO
   * @return ������ ���� 1 or 0
   */
  public int update(CategoryVO categoryVO) { // Call by Reference
    int count = 0; // ó���� ���ڵ� ����

    try {
      con = dbopen.getConnection(); // �߰�

      sql = new StringBuffer();
      sql.append(" UPDATE category");
      sql.append(" SET title = ?, seqno=?, visible=?, ids=?");
      sql.append(" WHERE categoryno=?");

      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      pstmt.setString(1, categoryVO.getTitle());
      pstmt.setInt(2, categoryVO.getSeqno());
      pstmt.setString(3, categoryVO.getVisible());
      pstmt.setString(4, categoryVO.getIds());
      pstmt.setInt(5, categoryVO.getCategoryno());

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL ����

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // �߰�
    }

    return count;
  }
  
  /**
   * ��� ������ ����(���߿� ���)
   * @param categoryVO
   * @return ������ ���� 0 or 1
   */
  public int increaseSeqno(int categoryno) {
    int count = 0; // ó���� ���ڵ� ����

    try {
      con = dbopen.getConnection(); // �߰�

      sql = new StringBuffer();
      sql.append(" UPDATE category");
      sql.append(" SET seqno = seqno + 1");
      sql.append(" WHERE categoryno=?");

      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      pstmt.setInt(1, categoryno);

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL ����

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // �߰�
    }

    return count;
  }
  
  /**
   * ��� ������ ����(���� ���)
   * @param categoryVO
   * @return ������ ���� 0 or 1
   */
  public int decreaseSeqno(int categoryno) {
    int count = 0; // ó���� ���ڵ� ����

    try {
      con = dbopen.getConnection(); // �߰�

      sql = new StringBuffer();
      sql.append(" UPDATE category");
      sql.append(" SET seqno = seqno - 1");
      sql.append(" WHERE categoryno=?");

      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      pstmt.setInt(1, categoryno);

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL ����

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // �߰�
    }

    return count;
  }
  
  /**
   * �Խ��� ����
   * @param categoryVO
   * @return �������� 0 or 1
   */
  public int show(int categoryno) {
    int count = 0; // ó���� ���ڵ� ����

    try {
      con = dbopen.getConnection(); // �߰�

      sql = new StringBuffer();
      sql.append(" UPDATE category");
      sql.append(" SET visible='Y'");
      sql.append(" WHERE categoryno=?");

      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      pstmt.setInt(1, categoryno);

      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL ����

    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // �߰�
    }

    return count;
  }
  
  /**
   * �Խ��� ����
   * @param categoryVO
   * @return �������� 0 or 1
   */
  public int hide(int categoryno) {
    int count = 0; // ó���� ���ڵ� ����
    
    try {
      con = dbopen.getConnection(); // �߰�
      
      sql = new StringBuffer();
      sql.append(" UPDATE category");
      sql.append(" SET visible='N'");
      sql.append(" WHERE categoryno=?");
      
      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      pstmt.setInt(1, categoryno);
      
      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL ����
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt); // �߰�
    }
    
    return count;
  }
  
  /**
   * ��� ������ �ִ�
   * @return seqno; max(seqno)+1
   */
  public int getMaxSeqno() {
    int seqno = 0;

    try {
      con = dbopen.getConnection();

      sql = new StringBuffer();
      sql.append(" SELECT MAX(seqno)+1 as seqno"); 
      sql.append(" FROM category");

      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      rs = pstmt.executeQuery(); // SELECT SQL ����

      if (rs.next()) { // ù��° ���ڵ�� �̵�
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
   * ī�װ� ����
   * @param categoryno
   * @return ������ ���ڵ� ���� 1 or 0
   */
  public int delete(int categoryno) {
    int count = 0; // ó���� ���ڵ� ����
    
    try {
      con = dbopen.getConnection();
      sql = new StringBuffer();
      sql.append(" DELETE FROM category");
      sql.append(" WHERE categoryno = ?");
      
      pstmt = con.prepareStatement(sql.toString()); // SQL ���� ��ü ����
      pstmt.setInt(1, categoryno);
      
      count = pstmt.executeUpdate(); // INSERT, UPDATE, DELETE SQL ����
      
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      dbclose.close(con, pstmt);
    }
    
    return count;
  }
  /**
   * ���� �Խ��� �ۼ��� ����
   * @param categoryno
   * @return
   */
  public int increaseCnt(int categoryno) { // call by reference
    int count = 0;                     // ó���� ���ڵ� ����
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
   * ���� �Խ��� �ۼ��� ����
   * @param categoryno
   * @return
   */
  public int decreaseCnt(int categoryno) { // call by reference
    int count = 0;                     // ó���� ���ڵ� ����
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