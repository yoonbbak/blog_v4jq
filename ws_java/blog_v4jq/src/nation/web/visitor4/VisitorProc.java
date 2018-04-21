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
   * 한 건의 레코드 조회
   * 
   * @param visitorno
   * @return visitorVO
   */
  public VisitorVO read(int visitorno) {
    VisitorVO visitorVO = visitorDAO.read(visitorno);

    return visitorVO;
  }
  
  /**
   * 한건의 레코드 변경
   * @param visitorVO 변경할 레코드 객체
   * @return
   */
  public int update (VisitorVO visitorVO) { // Call By Reference
    int count = visitorDAO.update(visitorVO);
    
    return count;
  }
  
}