<%@page import="review2.BoardBean"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		int tnum = Integer.parseInt(request.getParameter("tnum"));
		String nowPage = request.getParameter("nowPage");
	    String numPerPage = request.getParameter("numPerPage");
	    BoardBean bean = (BoardBean)session.getAttribute("bean");
	    String tsubject = bean.getTsubject();
	    String tname = bean.getTname();
	    String tcontent = bean.getTcontent();
	    String tfilename = bean.getTfilename();
%>

<html>
<head>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function check() {
	   if (document.updateFrm.tpass.value == "") {
		 alert("수정을 위해 비밀번호를 입력하세요.");
		 document.updateFrm.tpass.focus();
		 return false;
		 }
	   document.updateFrm.submit();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
<div align="center"><br/><br/>
<table width="600" cellpadding="3">
  <tr>
   <td bgcolor="#FF9018"  height="21" align="center">수정하기</td>
  </tr>
</table>
<form name="updateFrm" method="post" action="tboardUpdate" enctype="multipart/form-data">
<table width="600" cellpadding="7">
 <tr>
  <td>
   <table>
    <tr>
     <td width="20%">성 명</td>
     <td width="80%">
	  <input name="tname" value="<%=tname%>" size="30" maxlength="20">
	 </td>
	</tr>
	<tr>
     <td>제 목</td>
     <td>
	  <input name="tsubject" size="50" value="<%=tsubject%>" maxlength="50">
	 </td>
    <tr>
     <td>내 용</td>
     <td>
	  <textarea name="tcontent" rows="10" cols="50"><%=tcontent%></textarea>
	 </td>
    </tr>
    <tr>
    <td>첨부파일</td>
     <td>
     	<%=tfilename!=null?tfilename:"첨부된 파일이 없습니다."%>
     	<input type="file" name="tfilename" size="50" maxlength="50">
     </td>
    </tr>
	<tr>
     <td>비밀 번호</td> 
     <td><input type="password" name="tpass" size="15" maxlength="15">
      수정 시에는 비밀번호가 필요합니다.</td>
    </tr>
	<tr>
     <td colspan="2" height="5"><hr/></td>
    </tr>
	<tr>
     <td colspan="2">
	  <input type="button" value="수정완료" onClick="check()">
      <input type="reset" value="다시수정"> 
      <input type="button" value="뒤로" onClick="history.go(-1)">
	 </td>
    </tr> 
   </table>
  </td>
 </tr>
</table>
 <input type="hidden" name="nowPage" value="<%=nowPage %>">
 <input type='hidden' name="tnum" value="<%=tnum%>">
 <input type='hidden' name="numPerPage" value="<%=numPerPage%>">
</form> 
</div>
</body>
</html>