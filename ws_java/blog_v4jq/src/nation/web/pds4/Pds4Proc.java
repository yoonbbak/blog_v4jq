package nation.web.pds4;

import java.util.ArrayList;

import nation.web.category4.CategoryVO;
import nation.web.tool.Tool;

public class Pds4Proc {
  private Pds4DAO pds4DAO; // DB 접근, 입출력하는 역할

  public Pds4Proc() {
    this.pds4DAO = new Pds4DAO();
  }

  /**
   * 등록(답변형 동일)
   * 
   * @param pds4VO
   * @return 등록한 갯수
   */
  public int insert(Pds4VO pds4VO) {
    int count = pds4DAO.insert(pds4VO);

    return count;
  }

  /**
   * 모든 레코드
   * 
   * @return
   */
  public ArrayList<Pds4VO> list() {
    ArrayList<Pds4VO> list = null;
    list = pds4DAO.list();

    return list;

  }

  /**
   * 카테고리별 레코드
   * 
   * @param category
   *          게시판 그룹 번호
   * @return
   */
  public ArrayList<Pds4VO> list_category(int categoryno) {
    ArrayList<Pds4VO> list = pds4DAO.list_category(categoryno);
    
    return list;
  }
  
  /**
   * 전체 카테고리별 검색
   * 
   * @param category 카테고리
   *          게시판 그룹 번호
   * @return
   */
  public ArrayList<Pds4VO> list(String col, String word) {
    ArrayList<Pds4VO> list = pds4DAO.list(col, word);
      
    return list;
    
  }

  /**
   * 카테고리별 검색
   * 
   * @param categoryno 카테고리 번호
   * @param col 검색 컬럼
   * @param word 검색어
   * @return 검색 목록
   */
  public ArrayList<Pds4VO> list_category(int categoryno, String col, String word) {
    ArrayList<Pds4VO> list_category =  pds4DAO.list_category(categoryno, col, word);
        
    return list_category;
 
  }
  
  /**
   * 조회수 증가
   * 
   * @param pdsno
   */
  public void increaseCnt(int pdsno) { // call by value
    pds4DAO.increaseCnt(pdsno);
    

  }

  /**
   * 조회
   * 
   * @return
   */
  public Pds4VO read(int pdsno) {
    Pds4VO pds4VO = pds4DAO.read(pdsno);
    pds4DAO.increaseCnt(pdsno);
    return pds4VO;

  }

  /**
   * 패스워드를 검사합니다.
   * 
   * @param pdsno
   * @param passwd
   * @return
   */
  public int passwordCheck(int pdsno, String passwd) {

    int count = pds4DAO.passwordCheck(pdsno, passwd);
    return count;

  }

  /**
   * 글 수정
   * 
   * @param pds4VO
   * @return 등록한 갯수
   */
  public int update(Pds4VO pds4VO) { // call by reference
    int count = pds4DAO.update(pds4VO);
    return count;

  }
  
  /**
   * Visible 모드 변경
   * @param pdsno
   * @param visible Y/N
   * @return 처리한 갯수
   */
  public int show_hide(int pdsno, String visible){ 
    if (visible.equals("Y")){
      visible = "N";
      }else{
        visible = "Y";
      }
    int count =  pds4DAO.show_hide(pdsno, visible);
      return count;
  
  }
  
  /**
   * 파일 변경
   * @param pdsno 삭제할 레코드 번호
   * @return 처리 갯수(update, delete 전부 처리 갯수)
   */ 
  public int delete_file1(int pdsno) {
    Pds4VO pds4VO = new Pds4VO(); //파일명을 삭제하기 위한 객체생성
    pds4VO.setFile1(""); 
    pds4VO.setFstor1("");
    pds4VO.setSize1(0);
    pds4VO.setPdsno(pdsno);
    
   int count =  pds4DAO.update_file1(pds4VO);
     return count;
    
  }
  
  /**
   * 파일 신규 등록
   * @param pds4VO
   * @return 처리된 레코드 갯수
   */
    public int create_file1(Pds4VO pds4VO){
      int count = pds4DAO.update_file1(pds4VO);
      return count;
      
    }
    /**
     * Map 변경 및 삭제
     * @param pdsno
     * @return
     */
    public int create_map(Pds4VO pds4VO) {
      int count = pds4DAO.update_map(pds4VO);
      return count;  
    }
    
 
    /**
     * Map 삭제
     * @param pdsno
     * @return
     */
    public int delete_map(int pdsno) {
     Pds4VO pds4VO = new Pds4VO();
     pds4VO.setMap("");
     pds4VO.setPdsno(pdsno);
     
     
     int count = pds4DAO.delete_map(pds4VO);
      return count;
    }
     
    
    
    
    
    /**
     * Map 변경
     * @param pdsno
     * @return
     */
    public int replace_map(Pds4VO pds4VO) {
      int count =  pds4DAO.update_map(pds4VO);
      return count;
    
   }
    
    /**
     * 카테고리 삭제
     * @param categoryno
     * @return count
     */
    public int delete(int pdsno) {
      int count = pds4DAO.delete(pdsno);
      
      return count;
    }
    
    /**
     * youtube 등록
     * @param pds4VO
     * @return
     */
    public int create_youtube(Pds4VO pds4VO) {
     int count =  pds4DAO.update_youtube(pds4VO);
         return count;
      
    }
    
    /**
     * youtube 삭제
     * @param pdsno
     * @return
     */
    public int delete_youtube(int pdsno) {
     Pds4VO pds4VO = new Pds4VO();
     pds4VO.setYoutube("");
     pds4VO.setPdsno(pdsno);
     
     
     int count = pds4DAO.delete_youtube(pds4VO);
      return count;
    }
     
    
    
    /**
     * youtube 변경
     * @param pdsno
     * @return
     */
    public int replace_youtube(Pds4VO pds4VO) {
     int count =  pds4DAO.update_youtube(pds4VO);
    return count;
      
      
    }
    /**
     * 글만써놓고 없던 mp3를 수정해서 등록
     * @param pdsno
     * @return
     */
    public int create_mp3(Pds4VO pds4VO) {
      int count  = pds4DAO.update_mp3(pds4VO);
      return count;
      
      }
    
    
    /**
     * MP3 삭제
     * @param pdsno
     * @return
     */
    public int delete_mp3(int pdsno) {
      Pds4VO pds4VO = new Pds4VO();
      pds4VO.setMp3("");
      pds4VO.setPdsno(pdsno);
      
      
      int count = pds4DAO.delete_mp3(pds4VO);
       return count; 
     }
      
    
    
    /**
     * MP3 있는걸 다른걸로 변경
     * @param pdsno
     * @return
     */
    public int replace_mp3(Pds4VO pds4VO) {
      
      int count =  pds4DAO.update_mp3(pds4VO);
        return count;
      
    }
    
    /**
     * MP3 있는걸 다른걸로 변경
     * @param pdsno
     * @return
     */
    public int replace_mp4(Pds4VO pds4VO) {
      
      int count =  pds4DAO.update_mp4(pds4VO); 
        return count;
      
    }
    
    /**
     * 글만써놓고 없던 mp3를 수정해서 등록
     * @param pdsno
     * @return
     */
    public int create_mp4(Pds4VO pds4VO) {
      int count  = pds4DAO.update_mp4(pds4VO);
      return count;
      
      }
    
    
    /**
     * MP4 파일 삭제
     * @param pdsno
     * @return
     */
    public int delete_mp4(int pdsno) {
      Pds4VO pds4VO = new Pds4VO();
      pds4VO.setMp4("");
      pds4VO.setPdsno(pdsno);
      
      
      int count = pds4DAO.update_mp4(pds4VO);
       return count; 
     }
    
    /**
     * 카테고리별로 검색된 레코드 갯수
     * 
     * @return
     */
    public int count(int categoryno, String col, String word) {
      int count = 0;
      
      count = pds4DAO.count(categoryno, col, word);
      
      return count;
    }
    
   
    /**
     * 카테고리별로 검색 및 페이징이 구현된 목록, SELECT된 목록중에
     * 페이징 기법을 이용하여 특정 레코드 부분(10개)만 가져옵니다. 
     * 답변형도 동일함
     *  1 페이지: (nowPage 1 - 1) *  10 → 0  
     *  2 페이지: (nowPage 2 - 1) *  10 → 10 
     *  3 페이지: (nowPage 3 - 1) *  10 → 20 
     *  4 페이지: (nowPage 4 - 1) *  10 → 30  
     *  5 페이지: (nowPage 5 - 1) *  10 → 40   
     * @param categoryno 카테고리 번호
     * @param col 검색 컬럼
     * @param word 검색어
     * @param nowPage 현재페이지
     * @param offset skip할 레코드 갯수
     * @param recordPerPage 페이지당 출력할 레코드 갯수
     * @return 검색 목록
     */
    public ArrayList<Pds4VO> list_category(
        int categoryno, 
        String col, 
        String word, 
        int nowPage,
        int recordPerPage) {
      ArrayList<Pds4VO> list = new ArrayList<Pds4VO>();
   
      col = Tool.checkNull(col); 
      word = Tool.checkNull(word);
      /*
      *  1 페이지: (nowPage 1 - 1) *  10 → 0
      *  2 페이지: (nowPage 2 - 1) *  10 → 10
      *  3 페이지: (nowPage 3 - 1) *  10 → 20 
      *  4 페이지: (nowPage 4 - 1) *  10 → 30 
      *  5 페이지: (nowPage 5 - 1) *  10 → 40 
      */
      int offset  = (nowPage - 1) * recordPerPage; // skip할 레코드 수
      
      list = pds4DAO.list_category(categoryno, col, word, offset, recordPerPage);
      
      return list;
    }
    /**
     * 카테고리별 레코드 갯수
     * 
     * @return
     */
    public int countByCategory(int categoryno) {
      int count = 0;
      
      count = pds4DAO.countByCategory(categoryno);
      
      return count;
    }
    
    
    /**
     * 답변 등록
     * 
     * @param pds4VO
     * @return 등록한 갯수
     */
    public int reply(Pds4VO pds4VO) {
      int count = pds4DAO.insert(pds4VO);
          //----------------------------------답변 관련 코드 시작----------------------------------
          //부모의 pdsno 산출
      int pdsno = pds4VO.getPdsno();
          //부모글 관련 정보 조회
      Pds4VO parent_pds4VO = pds4DAO.read(pdsno);
          //답변임으로 부모의 grpno를 가져와 등록될 VO 객체에 저장
      pds4VO.setGrpno(parent_pds4VO.getGrpno());
          //답변임으로 부모보다 들여쓰기를 1 증가시킴
      pds4VO.setIndent(parent_pds4VO.getIndent() + 1);
          //답변 순서를 1 증가시켜 부모 바로 하단에 위치 시키도록 함
      pds4VO.setAnsnum(parent_pds4VO.getAnsnum() + 1);
          //기존에 등록된 답변의 순서를 1 증가시켜서 뒤로 밀어버림
      pds4DAO.increaseAnsnum(pds4VO.getCategoryno(), 
                                             pds4VO.getGrpno(), 
                                             pds4VO.getAnsnum());
          //----------------------------------답변 관련 코드 종료----------------------------------
      pds4DAO.reply(pds4VO);
      
      
      
      
      return count;
    }

}