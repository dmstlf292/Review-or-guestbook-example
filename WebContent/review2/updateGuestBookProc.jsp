<!-- updateGuestBookProc.jsp 던졌으니 수정한걸 반영해야하니 받아야한다 -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="guestbook.GuestBookMgr"/>
<jsp:useBean id="bean" class="guestbook.GuestBookBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	if(bean.getSecret()==null)
		bean.setSecret("0");
	mgr.updateGuestBook(bean);
%>
<!-- 수정과 동시 창은 close되고 수정된 방명록글은 적용이 되려면 showGuestBook.jsp 새로고침 -->
<script>
	opener.location.reload();//새로고침 기능
	self.close();
</script>