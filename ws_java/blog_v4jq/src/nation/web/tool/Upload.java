package nation.web.tool;

import java.io.File; 
import java.util.Enumeration; 
import java.util.HashMap; 
import java.util.Iterator; 
import java.util.Map; 
 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletRequestWrapper; 
 
// apache ���� ���ε� ������Ʈ
import org.apache.commons.fileupload.DiskFileUpload; 
import org.apache.commons.fileupload.FileItem; 
import org.apache.commons.fileupload.FileUpload; 
import org.apache.commons.fileupload.FileUploadException; 
 
// ��Ӱ� Servlet �˾ƾ� 
// HttpServletRequestWrapper: ������ Request ��ü�� ����� Ȯ��
// Integer�� WrapperŬ����(�޼ҵ带 ����) 
// int�� ������ ����
/** 
 * HttpServletRequestWrapper Ŭ������ HttpServletRequest 
 * �������̽��� �ӽ÷� ������ Ŭ������ �����ڰ� ���ΰ�ü�� 
 * request�� ��������ʰ� ���ο� ���·� request ��ü�� 
 * ����� ����� ��� ��ӹ޴� Ŭ�����Դϴ�.   
 * Apahce FileUpload ������Ʈ�� ����ϱ� ���ϰ� �����մϴ�. 
 * FileUpload API�� ����ϴ� HttpServletRequestWrapper Ŭ�����μ� 
 * HttpServletRequest�� ����� API�� ����ϱ� ���� �����̴�. 
 */ 
public class Upload extends HttpServletRequestWrapper { 
      
    private boolean multipart = false; 
     
    private HashMap parameterMap;  // �Ϲ� <INPUT> ���±� 
    private HashMap fileItemMap;   // ���۵� <FILE> �±� ��ü�� ���� 
     
    /** 
     * ������ 
     * @param request 
     * @throws FileUploadException 
     */ 
    public Upload(HttpServletRequest request)  
    throws FileUploadException{ 
        this(request, -1, -1, null); // ���� Ŭ������ ������ ȣ��, this: 4���� �μ��� ���� (-1: ������)
    } 
     
    /** 
     * ������ 
     * @param request HttpServletRequest ��ü 
     * @param threshold �޸𸮿� ������ �ִ�ũ�� 
     * @param max ���ε��� �ִ� ����ũ�� 
     * @param repositoryPath ���ε� ��� 
     * @throws FileUploadException 
     */ 
    public Upload(HttpServletRequest request, 
        int threshold, int max, String repositoryPath) throws FileUploadException { 
        super(request); 
         
        parsing(request, threshold, max, repositoryPath); 
    } 
     
    /** 
     * �Ϲ� �Է� �ʵ�� ���� �ʵ带 MAP(key, value�� ������ ����)�� ���� 
     * @param request HttpServletRequest ��ü 
     * @param threshold �޸𸮿� ������ �ִ�ũ�� 
     * @param max ���ε��� �ִ� ����ũ�� 
     * @param repositoryPath ���ε� ��� 
     * @throws FileUploadException 
     */ 
    private void parsing(HttpServletRequest request, 
        int threshold, int max, String repositoryPath) throws FileUploadException { 
         
        if (FileUpload.isMultipartContent(request)) { 
            multipart = true; 
             
            parameterMap = new java.util.HashMap(); 
            fileItemMap = new java.util.HashMap(); 
             
            DiskFileUpload diskFileUpload = new DiskFileUpload(); 
            if (threshold != -1) { 
                diskFileUpload.setSizeThreshold(threshold); 
            } 
            diskFileUpload.setSizeMax(max); 
            if (repositoryPath != null) { 
                diskFileUpload.setRepositoryPath(repositoryPath); 
            } 
             
            java.util.List list = diskFileUpload.parseRequest(request); 
            for (int i = 0 ; i < list.size() ; i++) { 
                FileItem fileItem = (FileItem) list.get(i); 
                String name = fileItem.getFieldName(); 
 
                
                // �������� �ƴ��� ã��
                if (fileItem.isFormField()) { // �Ϲ� �� �±����� �˻� 
                    // �Ϲ� ���±׶�� ó�� 
                    String value = fileItem.getString(); 
                    String[] values = (String[]) parameterMap.get(name); 
                    if (values == null) { 
                        values = new String[] { value }; 
                    } else { 
                        String[] tempValues = new String[values.length + 1]; 
                        System.arraycopy(values, 0, tempValues, 0, 1); 
                        tempValues[tempValues.length - 1] = value; 
                        values = tempValues; 
                    } 
                    parameterMap.put(name, values); 
                } else { // ���� �±׶�� ó�� ; �������� �ƴ��� ã��
                    System.out.println("���� �±� �߰ߵ� �±׸�: " + name); 
                    System.out.println("���� �±� �߰ߵ� ���ϸ�: " + fileItem.getName()); 
                    fileItemMap.put(name, fileItem); 
                } 
            } 
            addTo(); // request �Ӽ����� �����Ѵ�. 
        } 
    } 
     
    /** 
     * ������ �����ϴ� enctype="multipart/form-data"�ΰ�� true���� 
     * @return enctype="multipart/form-data"�ΰ�� true���� 
     */ 
    public boolean isMultipartContent() { 
        return multipart; 
    } 
     
    /** 
     * �־��� �Ķ���Ϳ� ���� ���� ���� 
     */ 
    public String getParameter(String name) { 
        if (multipart) { 
            String[] values = (String[])parameterMap.get(name); 
            if (values == null) return null; 
            return values[0]; 
        } else 
            return super.getParameter(name); 
    } 
     
    /** 
     * �Ķ������ ������ ���� 
     */ 
    public String[] getParameterValues(String name) { 
        if (multipart) 
            return (String[])parameterMap.get(name); 
        else 
            return super.getParameterValues(name); 
    } 
     
    /** 
     * ��ü �Ķ������ �̸��� ���� 
     */ 
    public Enumeration getParameterNames() { 
        if (multipart) { 
            return new Enumeration() { 
                Iterator iter = parameterMap.keySet().iterator(); 
                 
                public boolean hasMoreElements() { 
                    return iter.hasNext(); 
                } 
                public Object nextElement() { 
                    return iter.next(); 
                } 
            }; 
        } else { 
            return super.getParameterNames(); 
        } 
    } 
     
    public Map getParameterMap() { 
        if (multipart) 
            return parameterMap; 
        else 
            return super.getParameterMap(); 
    } 
     
    /** 
     * ������ �Ķ���� �̸��� ���õ� FileItem�� �����մϴ�. 
     * @param name 
     * @return 
     */ 
    public FileItem getFileItem(String name) { 
        if (multipart) 
            return (FileItem) fileItemMap.get(name); 
        else 
            return null; 
    } 
     
    /** 
     * �ӽ÷� ���� ���ε� ������ �����մϴ�. 
     */ 
    public void delete() { 
        if (multipart) { 
            Iterator fileItemIter = fileItemMap.values().iterator(); 
            while( fileItemIter.hasNext()) { 
                FileItem fileItem = (FileItem)fileItemIter.next(); 
                fileItem.delete(); 
            } 
        } 
    } 
     
    /** 
     * ���۰�ü ��ü�� request ��ü�� �����մϴ�. 
     */ 
    public void addTo() { 
        super.setAttribute(Upload.class.getName(), this); 
    } 
     
    /** 
     * request �Ӽ��� ����� FileUploadRequestWrapper�� �����մϴ�. 
     * @param request 
     * @return 
     */ 
    public Upload  
                  getFrom(HttpServletRequest request) { 
        return (Upload) 
            request.getAttribute(Upload.class.getName()); 
    } 
     
    /** 
     * ������ request�� ���۸� �Ӽ����� �����ϰ� ������ true�� �����մϴ�. 
     * @param request 
     * @return 
     */ 
    public boolean hasWrapper(HttpServletRequest request) { 
        if (getFrom(request) == null) { 
            return false; 
        } else { 
            return true; 
        } 
    } 
     
    /** 
     * ������ �ö�� ������ ������ ��ũ�� ���� 
     * ���ϸ� ó��: data.txt -> 0_data.txt -> 1_data.txt -> 2_data.txt -> ... 
     * @param fileItem ������ ���� ��ü 
     * @param upDir ������ ������ ���� 
     * @return ����� ���ϸ� 
     */ 
    public String saveFile(FileItem fileItem, String upDir){ 
         
        String filename = "";       //���ε� ���ϸ� 
        
        // ���� �±� 
        System.out.println("���۵� ���ϸ�: " + fileItem.getName()); 
 
        // ���� ������ ���� 
        int idx = fileItem.getName().lastIndexOf("\\"); //������ ��� 
 
        if (idx == -1) { // ���н�, ������ ��� 
            idx = fileItem.getName().lastIndexOf("/"); 
        } 
           
        // ���� ���ϸ� ����, C:/bigdata1/gallery/winter.jpg -> winter.jpg 
        filename = fileItem.getName().substring(idx + 1); 
           
        try { 
            //--------------------------------------------------------- 
            // ��� ������ ������ ���� ��ü ����, ���� + ���ϸ� 
            //--------------------------------------------------------- 
            File uploadedFile = new File(upDir, filename); 
               
            //�ø����� ���ϰ� ���� �̸��� �����ϸ� �ߺ����� ó�� 
            if ( uploadedFile.exists() == true ){ 
                for(int k=0; true; k++){ 
                    //���ϸ� �ߺ��� ���ϱ� ���� �Ϸ� ��ȣ�� �����Ͽ� 
                    //���ϸ����� ���� 
                    uploadedFile = new File(upDir, k + "_" +filename); 
                    //���յ� ���ϸ��� �����Ѵٸ� �ߺ������� �Ϸù�ȣ�� 
                    //���� ���ϸ� �ٽ� ���� 
                    
                    // !�� �̿��� false�� ��� ������ ó���ǵ��� ��ȯ 
                    if(!(uploadedFile.exists())){ // true -> false, false -> true  
                        // filename = k + "_" +filename; 
                        filename = uploadedFile.getName();
                        break; 
                    } else {
                      // System.out.println(uploadedFile.getName() + " ������ �����մϴ�.");
                    }
                } 
            } 
                
            // storage ������ ���ϸ� ���� 
            fileItem.write(uploadedFile); 
        } catch(Exception e) { 
              System.out.println(e.toString());     
        } 
 
        return filename; // ���ε�� ���ϸ� ���� 
    } 
    //--------------------------------------------------------------- 
    //Fileupload ������Ʈ ���� �ڵ� �� 
    //--------------------------------------------------------------- 
 
 
    /**  
     * ������ �����մϴ�.  
    */ 
    public boolean deleteFile(String folder, String fileName){ 
        boolean ret = false; 
         
        try{ 
            if ( fileName != null){ // ������ ������ �����ϴ� ��� ���� 
                File file = new File(folder + "/" + fileName); 
                if (file.exists()){
                  ret = file.delete();
                }
            } 
        }catch(Exception e){ 
            e.printStackTrace(); 
        } 
         
        return ret; 
    } 
 
    public HashMap getFileItemMap() { 
        return fileItemMap; 
    } 
 
    public void setFileItemMap(HashMap fileItemMap) { 
        this.fileItemMap = fileItemMap; 
    } 
     
    /** 
     * ���۹��� ������ ������ ���� 
     * @return 
     */ 
    public int getFileCount(){ 
        return this.fileItemMap.size(); 
    } 
    
    /**
     * FileUpload 1.2, 1.3 �ѱ� ��ȯ(���� ���ε��� ���� �̷� ������ �߰������� �ʿ���)
     * @param str
     * @return
     */
    public String toKor(String str) {
      String corean = null;
      try {
        // ISO-8859-1: ���� ���ڼ�
        corean = new String(str.getBytes("ISO-8859-1"), "UTF-8"); // 1����Ʈ¥���� 2����Ʈ�� ���ڿ� ��ȯ, ��ȣȭ
        // corean= new String(str.getBytes("ISO-8859-1"), "KSC5601"); // 10�� ��
        // corean= new String(str.getBytes("ISO-8859-1"), "euc-kr"); // ��� ������
      } catch (Exception e) {
        e.printStackTrace();
      }
      return corean;
    }
    
} 