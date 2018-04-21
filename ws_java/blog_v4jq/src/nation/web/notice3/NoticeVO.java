package nation.web.notice3;

public class NoticeVO {
  private int noticeno;
  private String title;
  private String rname;
  private String rdate;

  public NoticeVO() {
    super(); // 있어도 없어도 상관없음
  }

  public NoticeVO(int noticeno, String title, String rname, String rdate) {
    this.noticeno = noticeno;
    this.title = title;
    this.rname = rname;
    this.rdate = rdate;
  }

  public int getNoticeno() {
    return noticeno;
  }

  public void setNoticeno(int noticeno) {
    this.noticeno = noticeno;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getRname() {
    return rname;
  }

  public void setRname(String rname) {
    this.rname = rname;
  }

  public String getRdate() {
    return rdate;
  }

  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

}
