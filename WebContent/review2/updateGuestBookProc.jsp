<!-- updateGuestBookProc.jsp �������� �����Ѱ� �ݿ��ؾ��ϴ� �޾ƾ��Ѵ� -->
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
<!-- ������ ���� â�� close�ǰ� ������ ���ϱ��� ������ �Ƿ��� showGuestBook.jsp ���ΰ�ħ -->
<script>
	opener.location.reload();//���ΰ�ħ ���
	self.close();
</script>