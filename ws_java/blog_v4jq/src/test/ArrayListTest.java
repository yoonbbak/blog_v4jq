package test;

import java.util.ArrayList;

import nation.web.notice3.NoticeVO;

public class ArrayListTest {

  public static void main(String[] args) {
    ArrayList<String> items = new ArrayList<String>();
    items.add("일본 도쿄");
    items.add("월미도");
    items.add("제주도");

    int cnt = items.size(); // 메소드 호출을 덜하기 위해서 선언
    
    for (int i = 0; i < cnt; i++) {
      String str = items.get(i);
      System.out.println(str);
    }
    System.out.println("------------------------------------------------");

    ArrayList<NoticeVO> list = new ArrayList<NoticeVO>();

    NoticeVO noticeVO = new NoticeVO(); // 메모리 할당: 정수/문자열/문자욜/문자열
    noticeVO.setNoticeno(1);
    noticeVO.setTitle("화요일");
    noticeVO.setRname("왕눈이");
    noticeVO.setRdate("2017-03-01"); // 메모리: 1/화요일/왕눈이/2017-03-01

    list.add(noticeVO); // 메모리의 해시코드만 저장

    noticeVO = new NoticeVO();
    noticeVO.setNoticeno(2);
    noticeVO.setTitle("수요일");
    noticeVO.setRname("홍길동");
    noticeVO.setRdate("2017-03-02"); // 메모리: 2/수요일/홍길동/2017-03-02

    list.add(noticeVO); // NoticeVO 클래스의 객체가 저장됨. 메모리의 해시코드만 저장

    noticeVO = new NoticeVO();
    noticeVO.setNoticeno(3);
    noticeVO.setTitle("목요일");
    noticeVO.setRname("홍길순");
    noticeVO.setRdate("2017-03-03"); // 메모리: 3/목요일/홍길순/2017-03-03

    list.add(noticeVO); // NoticeVO 클래스의 객체가 저장됨. 메모리의 해시코드만 저장

    cnt = list.size(); // 메소드 호출을 덜하기 위해서 선언
    for (int index = 0; index < cnt; index++) {
      NoticeVO vo = list.get(index); // 제네릭스 쓰지 않을 시, 꺼낼 때 다시 형변환이 필요.

      System.out.print(vo.hashCode() + " "); // 객체에 할당된 고유의 메모리 코드
      System.out.print(vo.getNoticeno() + " ");
      System.out.print(vo.getTitle() + " ");
      System.out.print(vo.getRname() + " ");
      System.out.print(vo.getRdate() + " ");
      System.out.println();
    }

  }
}