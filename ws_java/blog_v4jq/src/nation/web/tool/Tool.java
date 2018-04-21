// version 0.3
 
package nation.web.tool;
 
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.File;
 
import javax.imageio.ImageIO;
 
public class Tool {
  /**
   * �̹������� �˻�
   * @param file
   * @return
   */
  public static synchronized boolean isImage(String file) {
    boolean sw = false;
 
    if (file != null) {
      file = file.toLowerCase(); // �ҹ���
      if (file.endsWith(".jpg") || file.endsWith(".jpeg") || file.endsWith(".png") || file.endsWith(".gif")) {
        sw = true;
      }
    }
    return sw;
  }
  
  /**
   * ������ �����մϴ�.
   */
  public static synchronized boolean deleteFile(String folder, String fileName) {
    boolean ret = false;
 
    try {
      if (fileName != null) { // ������ ������ �����ϴ� ��� ����
        File file = new File(folder + "/" + fileName);
        if (file.exists() && file.isFile()) { // �����ϴ� �������� �˻�
          ret = file.delete();
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
 
    return ret;
  }
  
  /**
   * HTML Ư�� ������ ����
   * @param str
   * @return
   */
  public static synchronized String convertChar(String str) {
    str = str.replaceAll("<", "&lt;");
    str = str.replaceAll(">", "&gt;");
    str = str.replaceAll("'", "&#39;");
    str = str.replaceAll("\"", "&quot;");
    str = str.replaceAll("\r\n", "<BR>");
    
    return str;
  }
  
  /**
   * ���ڿ��� ���̰� length ���� ũ�� "..." �� ǥ���ϴ� �޼ҵ�
   * 
   * @param str ���ڿ�
   * @param length ������ ���ڿ� ����
   * @return
   */
  public static synchronized String textLength(String str, int length) {
 
    if (str != null) {
      if (str.length() > length) { //�־��� ���ڼ����� ũ�ٸ�
        str = str.substring(0, length) + "..."; // ����: 0 ~ length - 1���� ����
      }
    } else {
      str = "";
    }
 
    return str;
  }
  
  /**
   * ���� ���޹޾� �ڷ��� ������ �����մϴ�.
   * @param size
   * @return 1000 > 1000 Byte
   */
  public static synchronized String unit(long size){
    String str = "";
    
    if (size < 1024){ // 1 KB ����
      str = size + " Byte";
    }else if (size < 1024 * 1024){ // 1 MB ����
      str = (int)(Math.ceil(size/1024.0)) + " KB"; // 1048576 ���� ������ KB
    }else if (size < 1024 * 1024 * 1024){ // 1 GB ����
      str = (int)(Math.ceil(size/1024.0/1024.0)) + " MB";
    }else if (size < 1024L * 1024 * 1024 * 1024){ // 1 TB ����
      str = (int)(Math.ceil(size/1024.0/1024.0/1024.0)) + " GB";
    }else if (size < 1024L * 1024 * 1024 * 1024 * 1024){ // 1 PT ����
      str = (int)(Math.ceil(size/1024.0/1024.0/1024.0/1024.0)) + " TB";
    }else if (size < 1024L * 1024 * 1024 * 1024 * 1024 * 1024){ // 1 EX ����
      str = (int)(Math.ceil(size/1024.0/1024.0/1024.0/1024.0/1024.0)) + " PT";
    }
    
    return str;
  }
   
  /**
   * �̹��� ����� �����Ͽ� ���ο� Preview �̹����� �����մϴ�.
   <pre>
   ��뿹): Too.preview(folder ��, ���� ���ϸ�, 200, 150)
   </pre>
   * @param upDir ���� �̹��� ����
   * @param _src ���� ���ϸ�
   * @param width ������ �̹��� �ʺ�
   * @param height  ������ �̹��� ����, ImageUtil.RATIO�� �ڵ� ��� ����
   * @return src.jpg ������ �̿��Ͽ� src_t.jpg ������ �����Ͽ� ���ϸ� ����
   */
  public static synchronized String preview(String upDir, String _src, int width,
      int height) {
    int RATIO = 0;
    int SAME = -1;
 
    File src = new File(upDir + "/" + _src); // ���� ���� ��ü ����
    String srcname = src.getName(); // ���� ���ϸ� ����
 
    // ���� ���ϸ� ����, mt.jpg -> mt �� ����
    String _dest = srcname.substring(0, srcname.indexOf("."));
 
    // ��� �̹��� ���� /upDir/mt_t.jpg
    File dest = new File(upDir + "/" + _dest + "_t.jpg");
 
    Image srcImg = null;
 
    String name = src.getName().toLowerCase(); // ���ϸ��� �����Ͽ� �ҹ��ڷ� ����
    
    // �̹��� �������� �˻�
    if (name.endsWith("jpg") || name.endsWith("bmp") || name.endsWith("png")
        || name.endsWith("gif")) {
      try {
        srcImg = ImageIO.read(src); // �޸𸮿� ���� �̹��� ����, Call By Reference
        int srcWidth = srcImg.getWidth(null); // ���� �̹��� �ʺ� ����
        int srcHeight = srcImg.getHeight(null); // ���� �̹��� ���� ����
        int destWidth = -1, destHeight = -1; // ��� �̹��� ũ�� �ʱ�ȭ
 
        if (width == SAME) { // width�� ���� ���
          destWidth = srcWidth;
        } else if (width > 0) {
          destWidth = width; // ���ο� width�� �Ҵ�
        }
 
        if (height == SAME) { // ���̰� ���� ���
          destHeight = srcHeight;
        } else if (height > 0) {
          destHeight = height; // ���ο� ���̷� �Ҵ�
        }
 
        // ������ ���� ũ�� ���
        if (width == RATIO && height == RATIO) {
          destWidth = srcWidth;
          destHeight = srcHeight;
        } else if (width == RATIO) {
          double ratio = ((double) destHeight) / ((double) srcHeight);
          destWidth = (int) ((double) srcWidth * ratio);
        } else if (height == RATIO) {
          double ratio = ((double) destWidth) / ((double) srcWidth);
          destHeight = (int) ((double) srcHeight * ratio);
        }
 
        // �޸𸮿� ��� �̹��� ����
        Image imgTarget = srcImg.getScaledInstance(destWidth, destHeight,
            Image.SCALE_SMOOTH);
        int pixels[] = new int[destWidth * destHeight];
        PixelGrabber pg = new PixelGrabber(imgTarget, 0, 0, destWidth,
            destHeight, pixels, 0, destWidth);
 
        pg.grabPixels();
 
        BufferedImage destImg = new BufferedImage(destWidth, destHeight,
            BufferedImage.TYPE_INT_RGB);
        destImg.setRGB(0, 0, destWidth, destHeight, pixels, 0, destWidth);
 
        // ���Ͽ� ���
        ImageIO.write(destImg, "jpg", dest);
 
        System.out.println(dest.getName() + " �̹����� �����߽��ϴ�.");
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
 
    return dest.getName();
  }
  
  
  /**
   * null Ư�� ���ڳ� "null" ���ڿ��� ���� ""���� �����մϴ�.
   * @param str ���� ���ڿ�
   * @return ����� ���ڿ�
   */
  public static synchronized String checkNull(String str) {
    if (str == null) {
      return "";
    } else if (str.equals("null")) {
      return "";
    } else {
      return str;  
    }
  }
}