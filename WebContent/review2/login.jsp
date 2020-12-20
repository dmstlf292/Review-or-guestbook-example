<!-- login.jsp -->
<%@page contentType="text/html;charset=EUC_KR"%>
<jsp:useBean id="login" class="guestbook.JoinBean" scope="session"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = (String)session.getAttribute("idKey");
		String url = request.getParameter("url");
%>
<title>로그인</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
<body bgcolor="#996600">
<br><br>
<div align="center">
<%
		if(id!=null){//세션에 로그인을 하고 loginProc에서 id가 idkey값으로 id값을 저장시킨것 이기때문에 null이 아닌것
			%>
				<b><%=login.getName()%></b>님 환영합니다.<br>
				<a href="showGuestBook.jsp" >방명록 </a>&nbsp;
				<a href="logout.jsp" >로그아웃</a>
			<%
		}else{
%>
<h2>GuestBook 로그인</h2>
<FORM METHOD="POST" ACTION="loginProc.jsp?url=<%=url%>"><!-- get방식과 post방식 동시에 -->
<table border="1">
	<tr>
		<td>id</td>
		<td> <input name="id" value="aaa">
		</td>
	</tr>
	<tr>
		<td>pwd</td>
		<td><input name="pwd" value="1234"></td>
	</tr>
	<tr>
		<td align="center" colspan="2">
		<INPUT TYPE="submit" value="로그인">
		</td>
	</tr>
</table>
<input type="hidden" name="url" value="<%=url%>">
</FORM>
<%}%>
</div>
</body>
