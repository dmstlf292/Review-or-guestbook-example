<!-- postGuestBook.jsp 말 그대로 방명록만 작성하는 공간 -->
<%@page import="guestbook.JoinBean"%>
<%@page pageEncoding="EUC-KR"%>
<!-- 이 페이지에서 던지면 proc에서 받아야한다!! -->
<jsp:useBean id="login" scope="session" class="guestbook.JoinBean"/>

<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
	<title>Open Pediatrics</title>
	<!-- 버튼에 자바스크립트 기능 넣었으니 여기 이부분에서 js function 기능 구현하기 -->
	<script type="text/javascript">
	function checkInputs() {
		frm = document.postFrm;
		if(frm.contents.value==""){
			alert("Please enter your comments");
			frm.contents.focus();
			return;
		}
		frm.submit();
	}
</script>
	<meta charset="UTF-8">
	<meta name="description" content="">
	<meta name="keywords" content="">
	<meta name="author" content="">
	<link rel="profile" href="#">

    <!--Google Font-->
    <link rel="stylesheet" href='http://fonts.googleapis.com/css?family=Dosis:400,700,500|Nunito:300,400,600' />
	<!-- Mobile specific meta -->
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="format-detection" content="telephone-no">

	<!-- CSS files -->
	<link rel="stylesheet" href="css/plugins.css">
	<link rel="stylesheet" href="css/style.css">
</head>

<body>
<div class="page-single" >
	<div class="container">
		<div class="row">
			<div class="col-md-9 col-sm-12 col-xs-12">
				<div class="blog-detail-ct">
					<div class="comments">
						<!-- <h4>04 Comments</h4> -->
					</div>
					<div class="comment-form">
						<h4>Leave a comment</h4>
						<form name="postFrm" method="post" action="postGuestBookProc.jsp"><!-- 보냈으니 proc가 받아야함 -->
							<div class="row">
								<div class="col-md-4">
									<input type="text" placeholder="Your name" name="name" size="9" 
								maxlength="20" value="<%=login.getName()%>" readonly >
								</div>
								<div class="col-md-4">
									<input type="text" placeholder="Your email" name="email" size="20"
									maxlength="80" value="<%=login.getEmail()%>">
								</div>
								<div class="col-md-4">
									<input type="text" placeholder="Website" name="hp" size="20"
									maxlength="80" value="<%=login.getHp()%>">
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<textarea  name="contents" cols="60" rows="6" placeholder="Message"></textarea>
								</div>
							</div>
							<input type="hidden" name="id" value="<%=login.getId()%>">
							<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
							<input type="button" value="Submit" onclick="javascript:checkInputs()"><!-- 여기 자바스크립트를 제일 위에 function 기능 넣어야한다. -->
							<input type="reset" value="Modify">
							<input type="checkbox" name="secret" value="1">
							<a >Secret</a>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="js/jquery.js"></script>
<script src="js/plugins.js"></script>
<script src="js/plugins2.js"></script>
<script src="js/custom.js"></script>
</body>
</html>