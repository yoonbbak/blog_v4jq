<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>즐겨찾기</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
</head>
<body>
  <DIV class='container'>
    <jsp:include page="/menu/top.jsp" flush='false' />
    <DIV class='content'>
      <form name='frm' action='./create_proc.jsp' method='POST'>
        <fieldset style='width: 70%; margin: 10px auto;'>
          <legend class="legend_basic">즐겨찾기 등록</legend>
          <ul>
            <li class="li_none">
              <label for="title"> 제목: </label>
              <input type="text" name="title" id="title"
                value="즐겨찾기1">
            </li>
            <li class="li_none">
              <label for="web"> 주소: </label>
              <input type="text" name="web" id="web" value="주소" style="width: 80%;">
            </li>
          </ul>
        </fieldset>
        <DIV
          style='margin: 30px auto; text-align: center; background-color: #FFFFFF'>
          <button type='submit'>등록</button>
        </DIV>
      </form>
    </DIV>
    <!-- content END -->
    <jsp:include page="/menu/bottom.jsp" flush='false' />
  </DIV>
  <!-- container END -->
</body>
</html>