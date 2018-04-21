package nation.web.pds4;
 
public class Pds4VO {
  /** �� ��ȣ */
  private int pdsno;
  /** �׷� ��ȣ */
  private int categoryno;
  /** ���� */
  private String rname;
  /** �̸��� */
  private String email;
  /** ���� */
  private String title;
  /** ���� */
  private String content;
  /** �н����� */
  private String passwd;
  /** ��ȸ�� */
  private int cnt;
  /** ����� */
  private String rdate;
  /** ���� ���ͳ� �ּ� */
  private String web;
  /** ���ϸ� */  
  private String file1;
  /** ���� ��ũ�� ����� ���ϸ� */
  private String fstor1;
  /** preview �̹��� */
  private String thumb;
  /** ����� ���� ������ */
  private long size1;
  /** Google ���� API */
  private String map;
  /** Youtube */
  private String youtube;
  /** MP3 ���� ���� */
  private String mp3;
  /** MP4 ���� ���� */
  private String mp4;
  /** ����� ��ǻ���� ip */
  private String ip;
  /** ��� ���� */
  private String visible;
  
  /** �׷� ��ȣ **/
  private int grpno;
    /* �鿩 ���� */
  private int indent;
    /* �亯 ���� */
  private int ansnum;
  
  public Pds4VO() {
 
  }
 
  public Pds4VO(int pdsno, int categoryno, String rname, String email, String title, String content, String passwd,
      int cnt, String rdate, String web, String file1, String fstor1, String thumb, long size1, String map,
      String youtube, String mp3, String mp4, String ip, String visible) {
    this.pdsno = pdsno;
    this.categoryno = categoryno;
    this.rname = rname;
    this.email = email;
    this.title = title;
    this.content = content;
    this.passwd = passwd;
    this.cnt = cnt;
    this.rdate = rdate;
    this.web = web;
    this.file1 = file1;
    this.fstor1 = fstor1;
    this.thumb = thumb;
    this.size1 = size1;
    this.map = map;
    this.youtube = youtube;
    this.mp3 = mp3;
    this.mp4 = mp4;
    this.ip = ip;
    this.visible = visible;
  }

  public int getPdsno() {
    return pdsno;
  }

  public void setPdsno(int pdsno) {
    this.pdsno = pdsno;
  }

  public int getCategoryno() {
    return categoryno;
  }

  public void setCategoryno(int categoryno) {
    this.categoryno = categoryno;
  }  

  public String getRname() {
    return rname;
  }

  public void setRname(String rname) {
    this.rname = rname;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public String getPasswd() {
    return passwd;
  }

  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }

  public int getCnt() {
    return cnt;
  }

  public void setCnt(int cnt) {
    this.cnt = cnt;
  }

  public String getRdate() {
    return rdate;
  }

  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

  public String getWeb() {
    return web;
  }

  public void setWeb(String web) {
    this.web = web;
  }

  public String getFile1() {
    return file1;
  }

  public void setFile1(String file1) {
    this.file1 = file1;
  }

  public String getFstor1() {
    return fstor1;
  }

  public void setFstor1(String fstor1) {
    this.fstor1 = fstor1;
  }

  public String getThumb() {
    return thumb;
  }

  public void setThumb(String thumb) {
    this.thumb = thumb;
  }

  public long getSize1() {
    return size1;
  }

  public void setSize1(long size1) {
    this.size1 = size1;
  }

  public String getMap() {
    return map;
  }

  public void setMap(String map) {
    this.map = map;
  }

  public String getYoutube() {
    return youtube;
  }

  public void setYoutube(String youtube) {
    this.youtube = youtube;
  }

  public String getMp3() {
    return mp3;
  }

  public void setMp3(String mp3) {
    this.mp3 = mp3;
  }

  public String getMp4() {
    return mp4;
  }

  public void setMp4(String mp4) {
    this.mp4 = mp4;
  }

  public String getIp() {
    return ip;
  }

  public void setIp(String ip) {
    this.ip = ip;
  }

  public String getVisible() {
    return visible;
  }

  public void setVisible(String visible) {
    this.visible = visible;
  }

  public int getGrpno() {
    return grpno;
  }

  public void setGrpno(int grpno) {
    this.grpno = grpno;
  }

  public int getIndent() {
    return indent; 
  }

  public void setIndent(int indent) {
    this.indent = indent; 
  }

  public int getAnsnum() {
    return ansnum;
  }

  public void setAnsnum(int ansnum) {
    this.ansnum = ansnum;
  }
 
  
 
  
}