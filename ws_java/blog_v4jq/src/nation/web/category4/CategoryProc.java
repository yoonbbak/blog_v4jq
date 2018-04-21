package nation.web.category4;

import java.util.ArrayList;

public class CategoryProc { // 로직(알고리즘) 처리(구현)
  private CategoryDAO categoryDAO; // DB 접근, 입출력하는 역할

  public CategoryProc() {
    this.categoryDAO = new CategoryDAO();
  }
  
  // DAO의 메소드 를 복사
  /**
   * 카테고리 등록
   * @param categoryVO
   * @return 등록된 갯수 1 or 0
   */
  public int insert(CategoryVO categoryVO) {
    int count = categoryDAO.insert(categoryVO);
    
    return count;
  }
  
  /**
   * 모든 카테고리 목록
   * @return list
   */
  public ArrayList<CategoryVO> list() {
    ArrayList<CategoryVO> list = null;
    // greenIT 저전력
    // 객체는 최대한 많이 만들지 말아야 한다.
    list = categoryDAO.list();
    
    return list;
  }
  
  /**
   * 한 건의 레코드 조회
   * @param categoryno 조회할 번호
   * @return categoryVO
   */
  public CategoryVO read(int categoryno) {
    CategoryVO categoryVO = categoryDAO.read(categoryno);
    
    return categoryVO;
  }
  
  /**
   * 카테고리 수정
   * @param categoryVO
   * @return 수정된 갯수 1 or 0
   */
  public int update(CategoryVO categoryVO) {
    int count = categoryDAO.update(categoryVO);
    
    return count;
  }
  
  /**
   * 출력 순서의 낮춤(나중에 출력)
   * @param categoryno
   * @return 수정된 갯수 1 or 0
   */
  public int increaseSeqno(int categoryno) {
    int count = categoryDAO.increaseSeqno(categoryno);
    
    return count;
  }
  
  /**
   * 출력 순서의 높임(먼저 출력)
   * @param categoryno
   * @return 수정된 갯수 1 or 0
   */
  public int decreaseSeqno(int categoryno) {
    int count = categoryDAO.decreaseSeqno(categoryno);
    
    return count;
  }
  
  /**
   * 게시판 공개
   * @param categoryno
   * @return 수정여부 1 or 0
   */
  public int show(int categoryno) {
    int count = categoryDAO.show(categoryno);
    
    return count;
  }
  
  /**
   * 게시판 숨김
   * @param categoryno
   * @return 수정여부 1 or 0
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
  
  /*Proc update를 복사한 후에 DAO를 본다*/
  
  /**
   * 카테고리 삭제
   * @param categoryno
   * @return count
   */
  public int delete(int categoryno) {
    int count = categoryDAO.delete(categoryno);
    
    return count;
  }
  
  /**
   * 관련 게시판 글수의 증가
   * @param categoryno
   * @return
   */
  public int increaseCnt(int categoryno) { // call by reference
    int count = 0;                     // 처리된 레코드 갯수
    
    count = categoryDAO.increaseCnt(categoryno);
    
    return count;
  }
 
  /**
   * 관련 게시판 글수의 감소
   * @param categoryno
   * @return
   */
  public int decreaseCnt(int categoryno) { // call by reference
    int count = 0;                     // 처리된 레코드 갯수
    
    count = categoryDAO.decreaseCnt(categoryno);
    
    return count;
  }
  
}