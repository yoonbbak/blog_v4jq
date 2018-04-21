package test;

import java.util.ArrayList;

import nation.web.notice3.NoticeVO;

public class ArrayListTest {

  public static void main(String[] args) {
    ArrayList<String> items = new ArrayList<String>();
    items.add("�Ϻ� ����");
    items.add("���̵�");
    items.add("���ֵ�");

    int cnt = items.size(); // �޼ҵ� ȣ���� ���ϱ� ���ؼ� ����
    
    for (int i = 0; i < cnt; i++) {
      String str = items.get(i);
      System.out.println(str);
    }
    System.out.println("------------------------------------------------");

    ArrayList<NoticeVO> list = new ArrayList<NoticeVO>();

    NoticeVO noticeVO = new NoticeVO(); // �޸� �Ҵ�: ����/���ڿ�/���ڿ�/���ڿ�
    noticeVO.setNoticeno(1);
    noticeVO.setTitle("ȭ����");
    noticeVO.setRname("�մ���");
    noticeVO.setRdate("2017-03-01"); // �޸�: 1/ȭ����/�մ���/2017-03-01

    list.add(noticeVO); // �޸��� �ؽ��ڵ常 ����

    noticeVO = new NoticeVO();
    noticeVO.setNoticeno(2);
    noticeVO.setTitle("������");
    noticeVO.setRname("ȫ�浿");
    noticeVO.setRdate("2017-03-02"); // �޸�: 2/������/ȫ�浿/2017-03-02

    list.add(noticeVO); // NoticeVO Ŭ������ ��ü�� �����. �޸��� �ؽ��ڵ常 ����

    noticeVO = new NoticeVO();
    noticeVO.setNoticeno(3);
    noticeVO.setTitle("�����");
    noticeVO.setRname("ȫ���");
    noticeVO.setRdate("2017-03-03"); // �޸�: 3/�����/ȫ���/2017-03-03

    list.add(noticeVO); // NoticeVO Ŭ������ ��ü�� �����. �޸��� �ؽ��ڵ常 ����

    cnt = list.size(); // �޼ҵ� ȣ���� ���ϱ� ���ؼ� ����
    for (int index = 0; index < cnt; index++) {
      NoticeVO vo = list.get(index); // ���׸��� ���� ���� ��, ���� �� �ٽ� ����ȯ�� �ʿ�.

      System.out.print(vo.hashCode() + " "); // ��ü�� �Ҵ�� ������ �޸� �ڵ�
      System.out.print(vo.getNoticeno() + " ");
      System.out.print(vo.getTitle() + " ");
      System.out.print(vo.getRname() + " ");
      System.out.print(vo.getRdate() + " ");
      System.out.println();
    }

  }
}