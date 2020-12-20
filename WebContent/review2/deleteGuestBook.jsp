<!-- deleteGuestBook.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%><!-- //이거 역할? -->
<jsp:useBean id="mgr" class="guestbook.GuestBookMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");//이거 역할?
		int num = 0;
		if(request.getParameter("num")!=null){
			num = Integer.parseInt(request.getParameter("num"));
			mgr.deleteGuestBook(num);
			mgr.deleteAllComment(num);
		}
		response.sendRedirect("showGuestBook.jsp");
%>