package nation.web.pds4;

import java.util.ArrayList;

import nation.web.category4.CategoryVO;
import nation.web.tool.Tool;

public class Pds4Proc {
  private Pds4DAO pds4DAO; // DB ����, ������ϴ� ����

  public Pds4Proc() {
    this.pds4DAO = new Pds4DAO();
  }

  /**
   * ���(�亯�� ����)
   * 
   * @param pds4VO
   * @return ����� ����
   */
  public int insert(Pds4VO pds4VO) {
    int count = pds4DAO.insert(pds4VO);

    return count;
  }

  /**
   * ��� ���ڵ�
   * 
   * @return
   */
  public ArrayList<Pds4VO> list() {
    ArrayList<Pds4VO> list = null;
    list = pds4DAO.list();

    return list;

  }

  /**
   * ī�װ��� ���ڵ�
   * 
   * @param category
   *          �Խ��� �׷� ��ȣ
   * @return
   */
  public ArrayList<Pds4VO> list_category(int categoryno) {
    ArrayList<Pds4VO> list = pds4DAO.list_category(categoryno);
    
    return list;
  }
  
  /**
   * ��ü ī�װ��� �˻�
   * 
   * @param category ī�װ�
   *          �Խ��� �׷� ��ȣ
   * @return
   */
  public ArrayList<Pds4VO> list(String col, String word) {
    ArrayList<Pds4VO> list = pds4DAO.list(col, word);
      
    return list;
    
  }

  /**
   * ī�װ��� �˻�
   * 
   * @param categoryno ī�װ� ��ȣ
   * @param col �˻� �÷�
   * @param word �˻���
   * @return �˻� ���
   */
  public ArrayList<Pds4VO> list_category(int categoryno, String col, String word) {
    ArrayList<Pds4VO> list_category =  pds4DAO.list_category(categoryno, col, word);
        
    return list_category;
 
  }
  
  /**
   * ��ȸ�� ����
   * 
   * @param pdsno
   */
  public void increaseCnt(int pdsno) { // call by value
    pds4DAO.increaseCnt(pdsno);
    

  }

  /**
   * ��ȸ
   * 
   * @return
   */
  public Pds4VO read(int pdsno) {
    Pds4VO pds4VO = pds4DAO.read(pdsno);
    pds4DAO.increaseCnt(pdsno);
    return pds4VO;

  }

  /**
   * �н����带 �˻��մϴ�.
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
   * �� ����
   * 
   * @param pds4VO
   * @return ����� ����
   */
  public int update(Pds4VO pds4VO) { // call by reference
    int count = pds4DAO.update(pds4VO);
    return count;

  }
  
  /**
   * Visible ��� ����
   * @param pdsno
   * @param visible Y/N
   * @return ó���� ����
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
   * ���� ����
   * @param pdsno ������ ���ڵ� ��ȣ
   * @return ó�� ����(update, delete ���� ó�� ����)
   */ 
  public int delete_file1(int pdsno) {
    Pds4VO pds4VO = new Pds4VO(); //���ϸ��� �����ϱ� ���� ��ü����
    pds4VO.setFile1(""); 
    pds4VO.setFstor1("");
    pds4VO.setSize1(0);
    pds4VO.setPdsno(pdsno);
    
   int count =  pds4DAO.update_file1(pds4VO);
     return count;
    
  }
  
  /**
   * ���� �ű� ���
   * @param pds4VO
   * @return ó���� ���ڵ� ����
   */
    public int create_file1(Pds4VO pds4VO){
      int count = pds4DAO.update_file1(pds4VO);
      return count;
      
    }
    /**
     * Map ���� �� ����
     * @param pdsno
     * @return
     */
    public int create_map(Pds4VO pds4VO) {
      int count = pds4DAO.update_map(pds4VO);
      return count;  
    }
    
 
    /**
     * Map ����
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
     * Map ����
     * @param pdsno
     * @return
     */
    public int replace_map(Pds4VO pds4VO) {
      int count =  pds4DAO.update_map(pds4VO);
      return count;
    
   }
    
    /**
     * ī�װ� ����
     * @param categoryno
     * @return count
     */
    public int delete(int pdsno) {
      int count = pds4DAO.delete(pdsno);
      
      return count;
    }
    
    /**
     * youtube ���
     * @param pds4VO
     * @return
     */
    public int create_youtube(Pds4VO pds4VO) {
     int count =  pds4DAO.update_youtube(pds4VO);
         return count;
      
    }
    
    /**
     * youtube ����
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
     * youtube ����
     * @param pdsno
     * @return
     */
    public int replace_youtube(Pds4VO pds4VO) {
     int count =  pds4DAO.update_youtube(pds4VO);
    return count;
      
      
    }
    /**
     * �۸������ ���� mp3�� �����ؼ� ���
     * @param pdsno
     * @return
     */
    public int create_mp3(Pds4VO pds4VO) {
      int count  = pds4DAO.update_mp3(pds4VO);
      return count;
      
      }
    
    
    /**
     * MP3 ����
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
     * MP3 �ִ°� �ٸ��ɷ� ����
     * @param pdsno
     * @return
     */
    public int replace_mp3(Pds4VO pds4VO) {
      
      int count =  pds4DAO.update_mp3(pds4VO);
        return count;
      
    }
    
    /**
     * MP3 �ִ°� �ٸ��ɷ� ����
     * @param pdsno
     * @return
     */
    public int replace_mp4(Pds4VO pds4VO) {
      
      int count =  pds4DAO.update_mp4(pds4VO); 
        return count;
      
    }
    
    /**
     * �۸������ ���� mp3�� �����ؼ� ���
     * @param pdsno
     * @return
     */
    public int create_mp4(Pds4VO pds4VO) {
      int count  = pds4DAO.update_mp4(pds4VO);
      return count;
      
      }
    
    
    /**
     * MP4 ���� ����
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
     * ī�װ����� �˻��� ���ڵ� ����
     * 
     * @return
     */
    public int count(int categoryno, String col, String word) {
      int count = 0;
      
      count = pds4DAO.count(categoryno, col, word);
      
      return count;
    }
    
   
    /**
     * ī�װ����� �˻� �� ����¡�� ������ ���, SELECT�� ����߿�
     * ����¡ ����� �̿��Ͽ� Ư�� ���ڵ� �κ�(10��)�� �����ɴϴ�. 
     * �亯���� ������
     *  1 ������: (nowPage 1 - 1) *  10 �� 0  
     *  2 ������: (nowPage 2 - 1) *  10 �� 10 
     *  3 ������: (nowPage 3 - 1) *  10 �� 20 
     *  4 ������: (nowPage 4 - 1) *  10 �� 30  
     *  5 ������: (nowPage 5 - 1) *  10 �� 40   
     * @param categoryno ī�װ� ��ȣ
     * @param col �˻� �÷�
     * @param word �˻���
     * @param nowPage ����������
     * @param offset skip�� ���ڵ� ����
     * @param recordPerPage �������� ����� ���ڵ� ����
     * @return �˻� ���
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
      *  1 ������: (nowPage 1 - 1) *  10 �� 0
      *  2 ������: (nowPage 2 - 1) *  10 �� 10
      *  3 ������: (nowPage 3 - 1) *  10 �� 20 
      *  4 ������: (nowPage 4 - 1) *  10 �� 30 
      *  5 ������: (nowPage 5 - 1) *  10 �� 40 
      */
      int offset  = (nowPage - 1) * recordPerPage; // skip�� ���ڵ� ��
      
      list = pds4DAO.list_category(categoryno, col, word, offset, recordPerPage);
      
      return list;
    }
    /**
     * ī�װ��� ���ڵ� ����
     * 
     * @return
     */
    public int countByCategory(int categoryno) {
      int count = 0;
      
      count = pds4DAO.countByCategory(categoryno);
      
      return count;
    }
    
    
    /**
     * �亯 ���
     * 
     * @param pds4VO
     * @return ����� ����
     */
    public int reply(Pds4VO pds4VO) {
      int count = pds4DAO.insert(pds4VO);
          //----------------------------------�亯 ���� �ڵ� ����----------------------------------
          //�θ��� pdsno ����
      int pdsno = pds4VO.getPdsno();
          //�θ�� ���� ���� ��ȸ
      Pds4VO parent_pds4VO = pds4DAO.read(pdsno);
          //�亯������ �θ��� grpno�� ������ ��ϵ� VO ��ü�� ����
      pds4VO.setGrpno(parent_pds4VO.getGrpno());
          //�亯������ �θ𺸴� �鿩���⸦ 1 ������Ŵ
      pds4VO.setIndent(parent_pds4VO.getIndent() + 1);
          //�亯 ������ 1 �������� �θ� �ٷ� �ϴܿ� ��ġ ��Ű���� ��
      pds4VO.setAnsnum(parent_pds4VO.getAnsnum() + 1);
          //������ ��ϵ� �亯�� ������ 1 �������Ѽ� �ڷ� �о����
      pds4DAO.increaseAnsnum(pds4VO.getCategoryno(), 
                                             pds4VO.getGrpno(), 
                                             pds4VO.getAnsnum());
          //----------------------------------�亯 ���� �ڵ� ����----------------------------------
      pds4DAO.reply(pds4VO);
      
      
      
      
      return count;
    }

}