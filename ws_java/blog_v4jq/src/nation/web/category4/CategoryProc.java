package nation.web.category4;

import java.util.ArrayList;

public class CategoryProc { // ����(�˰���) ó��(����)
  private CategoryDAO categoryDAO; // DB ����, ������ϴ� ����

  public CategoryProc() {
    this.categoryDAO = new CategoryDAO();
  }
  
  // DAO�� �޼ҵ� �� ����
  /**
   * ī�װ� ���
   * @param categoryVO
   * @return ��ϵ� ���� 1 or 0
   */
  public int insert(CategoryVO categoryVO) {
    int count = categoryDAO.insert(categoryVO);
    
    return count;
  }
  
  /**
   * ��� ī�װ� ���
   * @return list
   */
  public ArrayList<CategoryVO> list() {
    ArrayList<CategoryVO> list = null;
    // greenIT ������
    // ��ü�� �ִ��� ���� ������ ���ƾ� �Ѵ�.
    list = categoryDAO.list();
    
    return list;
  }
  
  /**
   * �� ���� ���ڵ� ��ȸ
   * @param categoryno ��ȸ�� ��ȣ
   * @return categoryVO
   */
  public CategoryVO read(int categoryno) {
    CategoryVO categoryVO = categoryDAO.read(categoryno);
    
    return categoryVO;
  }
  
  /**
   * ī�װ� ����
   * @param categoryVO
   * @return ������ ���� 1 or 0
   */
  public int update(CategoryVO categoryVO) {
    int count = categoryDAO.update(categoryVO);
    
    return count;
  }
  
  /**
   * ��� ������ ����(���߿� ���)
   * @param categoryno
   * @return ������ ���� 1 or 0
   */
  public int increaseSeqno(int categoryno) {
    int count = categoryDAO.increaseSeqno(categoryno);
    
    return count;
  }
  
  /**
   * ��� ������ ����(���� ���)
   * @param categoryno
   * @return ������ ���� 1 or 0
   */
  public int decreaseSeqno(int categoryno) {
    int count = categoryDAO.decreaseSeqno(categoryno);
    
    return count;
  }
  
  /**
   * �Խ��� ����
   * @param categoryno
   * @return �������� 1 or 0
   */
  public int show(int categoryno) {
    int count = categoryDAO.show(categoryno);
    
    return count;
  }
  
  /**
   * �Խ��� ����
   * @param categoryno
   * @return �������� 1 or 0
   */
  public int hide(int categoryno) {
    int count = categoryDAO.hide(categoryno);
    
    return count;
  }
  
  public int getMaxSeqno() {
    int seqno = 0;
    
    seqno = categoryDAO.getMaxSeqno();
    
    return seqno;
  }
  
  /*Proc update�� ������ �Ŀ� DAO�� ����*/
  
  /**
   * ī�װ� ����
   * @param categoryno
   * @return count
   */
  public int delete(int categoryno) {
    int count = categoryDAO.delete(categoryno);
    
    return count;
  }
  
  /**
   * ���� �Խ��� �ۼ��� ����
   * @param categoryno
   * @return
   */
  public int increaseCnt(int categoryno) { // call by reference
    int count = 0;                     // ó���� ���ڵ� ����
    
    count = categoryDAO.increaseCnt(categoryno);
    
    return count;
  }
 
  /**
   * ���� �Խ��� �ۼ��� ����
   * @param categoryno
   * @return
   */
  public int decreaseCnt(int categoryno) { // call by reference
    int count = 0;                     // ó���� ���ڵ� ����
    
    count = categoryDAO.decreaseCnt(categoryno);
    
    return count;
  }
  
}