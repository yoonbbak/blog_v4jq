package nation.web.visitor4;

import java.util.ArrayList;

public class VisitorProc {
  private VisitorDAO visitorDAO;

  public VisitorProc() {
    visitorDAO = new VisitorDAO();
  }

  public int insert(VisitorVO visitorVO) { // Call by Reference
    int count = visitorDAO.insert(visitorVO);

    return count;
  }

  public ArrayList<VisitorVO> list() {
    ArrayList<VisitorVO> list = visitorDAO.list();

    return list;
  }

  /**
   * �� ���� ���ڵ� ��ȸ
   * 
   * @param visitorno
   * @return visitorVO
   */
  public VisitorVO read(int visitorno) {
    VisitorVO visitorVO = visitorDAO.read(visitorno);

    return visitorVO;
  }
  
  /**
   * �Ѱ��� ���ڵ� ����
   * @param visitorVO ������ ���ڵ� ��ü
   * @return
   */
  public int update (VisitorVO visitorVO) { // Call By Reference
    int count = visitorDAO.update(visitorVO);
    
    return count;
  }
  
}