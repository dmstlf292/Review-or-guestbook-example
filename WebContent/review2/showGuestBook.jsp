<!-- showGuestBook.jsp -->
<!-- 여기서도 받아야한다!! -->
<%@page import="guestbook.CommentBean"%>
<%@page import="guestbook.GuestBookBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="guestbook.GuestBookMgr" />
<%
	request.setCharacterEncoding("EUC-KR");
String id = (String) session.getAttribute("idKey");
if (id == null) {
	StringBuffer url = request.getRequestURL();
	response.sendRedirect("login.jsp?url=" + url);
	return;
}
%>

<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
<title>Open Pediatrics</title>
<!-- 버튼에 자바스크립트 기능 넣었으니 여기 이부분에서 js function 기능 구현하기 -->
<script type="text/javascript">
	function updateFn(num) {//기능 : 댓글 수정버튼 누르면 수정할수 있는 창이 뜨는것, updateGuestBook.jsp 만들기!! 그 이후에 proc 만들어야함 !!
		url = "updateGuestBook.jsp?num=" + num;
		window.open(url, "GuestBook Update", "width=520,height=300");
	}
	function commentFn(frm) { //this.form //기능 : 대댓글 알림창
		if (frm.comment.value == "") {
			alert("내용을 입력하세요.");
			frm.comment.focus();
			return;
		}
		frm.submit();
	}
	function disFn(num) {//여기 아주 중요
		var v = "cmt" + num;
		//alert(v);
		var e = document.getElementById(v);
		if (e.style.display == 'none')
			e.style.display = 'block';//보이는것
		else
			e.style.display = 'none';//안보임
	}
</script>
<meta charset="UTF-8">
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="author" content="">
<link rel="profile" href="#">

<!--Google Font-->
<link rel="stylesheet"
	href='http://fonts.googleapis.com/css?family=Dosis:400,700,500|Nunito:300,400,600' />
<!-- Mobile specific meta -->
<meta name=viewport content="width=device-width, initial-scale=1">
<meta name="format-detection" content="telephone-no">

<!-- CSS files -->
<link rel="stylesheet" href="css/plugins.css">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<!--preloading-->
	<div id="preloader">
		<img class="logo" src="images/logo1.png" alt="" width="119"
			height="58">
		<div id="status">
			<span></span> <span></span>
		</div>
	</div>
	<!--end of preloading-->
	<!--login form popup-->
	<div class="login-wrapper" id="login-content">
		<div class="login-content">
			<a href="#" class="close">x</a>
			<h3>Login</h3>
			<form method="post" action="#">
				<div class="row">
					<label for="username"> Username: <input type="text"
						name="username" id="username" placeholder="Hugh Jackman"
						pattern="^[a-zA-Z][a-zA-Z0-9-_\.]{8,20}$" required="required" />
					</label>
				</div>

				<div class="row">
					<label for="password"> Password: <input type="password"
						name="password" id="password" placeholder="******"
						pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
						required="required" />
					</label>
				</div>
				<div class="row">
					<div class="remember">
						<div>
							<input type="checkbox" name="remember" value="Remember me"><span>Remember
								me</span>
						</div>
						<a href="#">Forget password ?</a>
					</div>
				</div>
				<div class="row">
					<button type="submit">Login</button>
				</div>
			</form>
			<div class="row">
				<p>Or via social</p>
				<div class="social-btn-2">
					<a class="fb" href="#"><i class="ion-social-facebook"></i>Facebook</a>
					<a class="tw" href="#"><i class="ion-social-twitter"></i>twitter</a>
				</div>
			</div>
		</div>
	</div>
	<!--end of login form popup-->
	<!--signup form popup-->
	<div class="login-wrapper" id="signup-content">
		<div class="login-content">
			<a href="#" class="close">x</a>
			<h3>sign up</h3>
			<form method="post" action="#">
				<div class="row">
					<label for="username-2"> Username: <input type="text"
						name="username" id="username-2" placeholder="Hugh Jackman"
						pattern="^[a-zA-Z][a-zA-Z0-9-_\.]{8,20}$" required="required" />
					</label>
				</div>

				<div class="row">
					<label for="email-2"> your email: <input type="password"
						name="email" id="email-2" placeholder=""
						pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
						required="required" />
					</label>
				</div>
				<div class="row">
					<label for="password-2"> Password: <input type="password"
						name="password" id="password-2" placeholder=""
						pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
						required="required" />
					</label>
				</div>
				<div class="row">
					<label for="repassword-2"> re-type Password: <input
						type="password" name="password" id="repassword-2" placeholder=""
						pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$"
						required="required" />
					</label>
				</div>
				<div class="row">
					<button type="submit">sign up</button>
				</div>
			</form>
		</div>
	</div>
	<!--end of signup form popup-->
	<!-- BEGIN | Header -->
	<header class="ht-header">
		<div class="container">
			<nav class="navbar navbar-default navbar-custom">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header logo">
					<div class="navbar-toggle" data-toggle="collapse"
						data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span>
						<div id="nav-icon1">
							<span></span> <span></span> <span></span>
						</div>
					</div>
					<a href="index-2.html"><img class="logo" src="images/logo1.png"
						alt="" width="119" height="58"></a>
				</div>
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse flex-parent"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav flex-child-menu menu-left">
						<li class="hidden"><a href="#page-top"></a></li>
						<li class="dropdown first"><a
							class="btn btn-default dropdown-toggle lv1"
							data-toggle="dropdown"> Home <i class="fa fa-angle-down"
								aria-hidden="true"></i>
						</a>
							<ul class="dropdown-menu level1">
								<li><a href="index-2.html">Home 01</a></li>
								<li><a href="homev2.html">Home 02</a></li>
								<li><a href="homev3.html">Home 03</a></li>
							</ul></li>
						<li class="dropdown first"><a
							class="btn btn-default dropdown-toggle lv1"
							data-toggle="dropdown" data-hover="dropdown"> movies<i
								class="fa fa-angle-down" aria-hidden="true"></i>
						</a>
							<ul class="dropdown-menu level1">
								<li class="dropdown"><a href="#" class="dropdown-toggle"
									data-toggle="dropdown">Movie grid<i
										class="ion-ios-arrow-forward"></i></a>
									<ul class="dropdown-menu level2">
										<li><a href="moviegrid.html">Movie grid</a></li>
										<li><a href="moviegridfw.html">movie grid full width</a></li>
									</ul></li>
								<li><a href="movielist.html">Movie list</a></li>
								<li><a href="moviesingle.html">Movie single</a></li>
								<li class="it-last"><a href="seriessingle.html">Series
										single</a></li>
							</ul></li>
						<li class="dropdown first"><a
							class="btn btn-default dropdown-toggle lv1"
							data-toggle="dropdown" data-hover="dropdown"> celebrities <i
								class="fa fa-angle-down" aria-hidden="true"></i>
						</a>
							<ul class="dropdown-menu level1">
								<li><a href="celebritygrid01.html">celebrity grid 01</a></li>
								<li><a href="celebritygrid02.html">celebrity grid 02 </a></li>
								<li><a href="celebritylist.html">celebrity list</a></li>
								<li class="it-last"><a href="celebritysingle.html">celebrity
										single</a></li>
							</ul></li>
						<li class="dropdown first"><a
							class="btn btn-default dropdown-toggle lv1"
							data-toggle="dropdown" data-hover="dropdown"> news <i
								class="fa fa-angle-down" aria-hidden="true"></i>
						</a>
							<ul class="dropdown-menu level1">
								<li><a href="bloglist.html">blog List</a></li>
								<li><a href="bloggrid.html">blog Grid</a></li>
								<li class="it-last"><a href="blogdetail.html">blog
										Detail</a></li>
							</ul></li>
						<li class="dropdown first"><a
							class="btn btn-default dropdown-toggle lv1"
							data-toggle="dropdown" data-hover="dropdown"> community <i
								class="fa fa-angle-down" aria-hidden="true"></i>
						</a>
							<ul class="dropdown-menu level1">
								<li><a href="userfavoritegrid.html">user favorite grid</a></li>
								<li><a href="userfavoritelist.html">user favorite list</a></li>
								<li><a href="userprofile.html">user profile</a></li>
								<li class="it-last"><a href="userrate.html">user rate</a></li>
							</ul></li>
					</ul>
					<ul class="nav navbar-nav flex-child-menu menu-right">
						<li class="dropdown first"><a
							class="btn btn-default dropdown-toggle lv1"
							data-toggle="dropdown" data-hover="dropdown"> pages <i
								class="fa fa-angle-down" aria-hidden="true"></i>
						</a>
							<ul class="dropdown-menu level1">
								<li><a href="landing.html">Landing</a></li>
								<li><a href="404.html">404 Page</a></li>
								<li class="it-last"><a href="comingsoon.html">Coming
										soon</a></li>
							</ul></li>
						<li><a href="#">Help</a></li>
						<li class="loginLink"><a href="#">LOG In</a></li>
						<li class="btn signupLink"><a href="#">sign up</a></li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</nav>

			<!-- top search form -->
			<div class="top-search">
				<select>
					<option value="united">TV show</option>
					<option value="saab">Others</option>
				</select> <input type="text"
					placeholder="Search for a movie, TV Show or celebrity that you are looking for">
			</div>
		</div>
	</header>
	<!-- END | Header -->
	<div class="hero common-hero">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="hero-ct">
						<h1>blog detail</h1>
						<ul class="breadcumb">
							<li class="active"><a href="#">Home</a></li>
							<li><span class="ion-ios-arrow-right"></span> blog listing</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- blog detail section-->
	<div class="page-single">
		<div class="container">
			<div class="row">
				<div class="col-md-9 col-sm-12 col-xs-12">
					<div class="blog-detail-ct">
						<h1>New Character Posters For Pirates Of The Caribbean</h1>
						<span class="time">27 Mar 2017</span> <img
							src="images/uploads/blog-detail.jpg" alt="">
						<p>Joss Whedon has a little bit of a history with superhero
							movies, and for creating layered female characters. After his
							documented frustrations with Wonder Woman, he's getting another
							chance at the DC Extended Universe and Warner Bros., closing in
							on a deal to write direct and produce a Batgirl movie.</p>
						<p>It's a somewhat surprising, but welcome move, given that
							Whedon has taken a long break to write something original, but
							has now pivoted to focus on developing the Batgirl project. First
							appearing in 1967 in Gardner Fox and Carmine Infantino's story
							run The Million Dollar Debut Of Batgirl, she's the superhero
							alias of Barbara Gordon, daughter of Gotham City Police
							Commissioner James Gordon. So we can likely expect J.K. Simmons'
							take on Gordon to appear along with other Bat-related characters.</p>



						<div class="flex-it flex-ct">
							<p>
								Arterton is next set to play Vita Sackville-West in Vita and
								Virginia about her relationship with Virginia Woolf. She spoke
								to Variety about working with female directors, remarkable
								women, and why she shies away from the term “strong female
								character.” <br> I’m friends with the producer who I worked
								with on Byzantium and he sent it to me. I read the book as well,
								which is fantastic. You’re always looking for untold stories and
								many times they’re women’s stories. What surprised me is that it
								centers around a woman who’s really quite timid. I guess she’s
								allowed to be because all of the other characters.
							</p>
							<img src="images/uploads/blog-detail2.jpg" alt="">
						</div>
						<p>Man Down debuted simultaneously on digital platforms in the
							U.K., meaning it was never going to be a big earner in theaters.
							But no one expected only one ticket sale. As of Tuesday, the Reel
							Cinema in Burnley was still carrying Man Down, which also stars
							Gary Oldman, Jai Courtney and Kate Mara.</p>
						<p>In the film, LaBeouf stars as a war veteran suffering from
							PTSD following his return from Afghanistan. The indie project,
							reuniting the star with A Guide to Recognizing Your Saints
							director Dito Montile, made its world premiere at the 2016 Venice
							Film Festival before making making a stop at the Toronto
							International Film Festival.</p>


						<!-- share link -->
						<div class="flex-it share-tag">
							<div class="social-link">
								<h4>Share it</h4>
								<a href="#"><i class="ion-social-facebook"></i></a> <a href="#"><i
									class="ion-social-twitter"></i></a> <a href="#"><i
									class="ion-social-googleplus"></i></a> <a href="#"><i
									class="ion-social-pinterest"></i></a> <a href="#"><i
									class="ion-social-linkedin"></i></a>
							</div>
							<div class="right-it">
								<h4>Tags</h4>
								<a href="#">Gray,</a> <a href="#">Film,</a> <a href="#">Poster</a>
							</div>
						</div>
					</div>
				</div>
				<!-- side -->
				<div class="col-md-3 col-sm-12 col-xs-12">
				<div class="sidebar">
					<div class="sb-search sb-it">
						<h4 class="sb-title">Search</h4>
						<input type="text" placeholder="Enter keywords">
					</div>
					<div class="sb-cate sb-it">
						<h4 class="sb-title">Categories</h4>
						<ul>
							<li><a href="#">Awards (50)</a></li>
							<li><a href="#">Box office (38)</a></li>
							<li><a href="#">Film reviews (72)</a></li>
							<li><a href="#">News (45)</a></li>
							<li><a href="#">Global (06)</a></li>
						</ul>
					</div>
					<div class="sb-recentpost sb-it">
						<h4 class="sb-title">most popular</h4>
						<div class="recent-item">
							<span>01</span><h6><a href="#">Korea Box Office: Beauty and the Beast Wins Fourth</a></h6>
						</div>
						<div class="recent-item">
							<span>02</span><h6><a href="#">Homeland Finale Includes Shocking Death </a></h6>
						</div>
						<div class="recent-item">
							<span>03</span><h6><a href="#">Fate of the Furious Reviews What the Critics Saying</a></h6>
						</div>
					</div>
					<div class="sb-tags sb-it">
						<h4 class="sb-title">tags</h4>
						<ul class="tag-items">
							<li><a href="#">Batman</a></li>
							<li><a href="#">film</a></li>
							<li><a href="#">homeland</a></li>
							<li><a href="#">Fast & Furious</a></li>
							<li><a href="#">Dead Walker</a></li>
							<li><a href="#">King</a></li>
							<li><a href="#">Beauty</a></li>
						</ul>
					</div>
					<div class="ads">
						<img src="images/uploads/ads1.png" alt="">
					</div>
				</div>
			</div>
				
				
				
				
			</div>
		</div>
	</div>

	<!-- 여기 이부분 이쁘게 꾸미기!!! -->

	<%@include file="postGuestBook.jsp"%>
	<h4>04 Comments</h4>


	<table width="300" cellspacing="0" cellpadding="3">
		<tr bgcolor="#F5F5F5">
			<td><b><%=login.getName()%></b></td>
			<td align="right"><a href="logout.jsp">Logout</a></b></td>
		</tr>
	</table>

	<!-- GuestBook List Start -->
	<%
		Vector<GuestBookBean> vlist = mgr.listGuestBook(id, login.getGrade());
	//out.print(vlist.size());
	if (vlist.isEmpty()) {
	%>
	<table width="520" cellspacing="0" cellpadding="7">
		<tr>
			<td>There are no registered post.</td>
		</tr>
	</table>
	<%
		} else {
	for (int i = 0; i < vlist.size(); i++) {
		//방명록글 가져오기
		GuestBookBean bean = vlist.get(i);
		//방명록 글쓴이 가져오기
		JoinBean writer = mgr.getJoin(bean.getId());
	%>


	<!-- comment items -->
	<!-- GuestBook List Start -->
	<div class="comments">
		<!-- <h4>04 Comments</h4> -->
		<div class="cmt-item flex-it">
			<img src="images/uploads/author.png" alt="">
			<div class="author-infor">
				<div class="flex-it2">
					<table bgcolor="#F5F5F5">
						<tr>
							<td width="225">NO : <%=vlist.size() - i%></td>
							<td width="225"><img src="img/face.bmp" border="0"
								alt="name"> <a href="mailto:<%=writer.getEmail()%>"><%=writer.getName()%></a>
							</td>
							<td width="150" align="center">
								<%
									if (writer.getHp() == null || writer.getHp().equals("")) {
								%> There is not Homepage <%
									} else {
								%> <a href="http://<%=writer.getHp()%>"> <img
									alt="홈페이지 " src="img/hp.bmp" border="0"></a> <%
 	}
 %>
							</td>
						</tr>
						<tr>
							<td colspan="3"><%=bean.getContents()%></td>

						</tr>
						<tr>
							<td>IP : <%=bean.getIp()%></td>
							<td><%=bean.getRegdate() + " " + bean.getRegtime()%></td>
							<td>
								<%
									//수정, 삭제 : 로그인 id와 글쓴이 id가 동일 활성
								//삭제 : 관리자
								//비밀글 : secret이 1일때 
								boolean chk = login.getId().equals(writer.getId());
								if (chk || login.getGrade().equals("1")) {
									if (chk) {
								%> <a href="javascript:updateFn('<%=bean.getNum()%>')">modify</a>
								<%
									}
								%> <a href="deleteGuestBook.jsp?num=<%=bean.getNum()%>">delete</a>
								<%
									if (bean.getSecret().equals("1")) {
								%> secret <%
									}
								}
								%>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	<!-- Comment List Start -->
	<!-- 아래내용 중요, 모든대댓글 버튼 클릭시 본댓글은 사라지고 대댓글만 보이도록 하는 기능, 대댓글만 보이게 새로운 영역 짜주기 -->
	<div id="cmt<%=bean.getNum()%>" style="display: none">
		<%
			Vector<CommentBean> cvlist = mgr.listComment(bean.getNum());
		//out.print(cvlist.size()); 댓글개수 확인용
		if (!cvlist.isEmpty()) {
		%>
		<table width="500" bgcolor="#F5F5F5">
			<%
				for (int j = 0; j < cvlist.size(); j++) {
				CommentBean cbean = cvlist.get(j);
			%>
			<tr>
				<td>
					<table width="500">
						<tr>
							<td><b><%=cbean.getCid()%></b></td>
							<td align="right">
								<!-- 삭제가 활성화 되려면  --> <!-- 삭제는 로그인 id와 입력 id가 동일한 경우에만 --> <%
 	if (login.getId().equals(cbean.getCid())) {
 %><!-- ==하면 주소값을 비교하는것 --> <a
								href="commentProc.jsp?flag=delete&cnum=<%=cbean.getCnum()%>">
									delete</a> <%
 	}
 %>
							</td>
						</tr>
						<tr>
							<td colspan="2"><%=cbean.getComment()%></td>
						</tr>
						<tr>
							<td><%=cbean.getCip()%></td>
							<td align="right"><%=cbean.getCregDate()%></td>
						</tr>
					</table>
					<hr>
				</td>
			</tr>
			<%
				} //for
			%>
		</table>
		<%
			} //if
		%>
	</div>
	<!-- Comment List End -->
	<table width="500">
		<tr>
			<td>
				<button onclick="disFn('<%=bean.getNum()%>')">
					+ Reply
					<%=cvlist.size() > 0 ? cvlist.size() : ""%></button> <!-- 이거 뭔뜻...?댓글개수 표현함 -->
			</td>
		</tr>
	</table>
	<!-- Comment Form Start -->
	<form name="cFrm" method="post" action="commentProc.jsp">
		<!-- commentProc.jsp 만들기 -->
		<table>
			<div class="cmt-item flex-it reply">
				<img src="images/uploads/author2.png" alt="">
				<div class="author-infor">
					<div class="flex-it2">
						<td><textarea placeholder="Enter a comment" name="comment"
								rows="2" cols="65" maxlength="1000"></textarea></td>
						<td><input type="button" value="Submit"
							onclick="commentFn(this.form)"> <input type="hidden"
							name="flag" value="insert"> <!-- 방명록 글 번호 --> <input
							type="hidden" name="num" value="<%=bean.getNum()%>"> <!-- 로그인 id -->
							<input type="hidden" name="cid" value="<%=bean.getId()%>">
							<!-- 댓글 입력 ip 주소 --> <input type="hidden" name="cip"
							value="<%=request.getRemoteAddr()%>"></td>
					</div>
				</div>
			</div>
		</table>
	</form>

	<!-- Comment  Form End -->
	<%
		} //--for(comment)
	} //--if(comment)
	%>
	<!-- GuestBook List End -->





	</div>




	<script src="js/jquery.js"></script>
	<script src="js/plugins.js"></script>
	<script src="js/plugins2.js"></script>
	<script src="js/custom.js"></script>
</body>
<!-- footer section-->
<footer class="ht-footer">
	<div class="container">
		<div class="flex-parent-ft">
			<div class="flex-child-ft item1">
				 <a href="index-2.html"><img class="logo" src="images/logo1.png" alt=""></a>
				 <p>5th Avenue st, manhattan<br>
				New York, NY 10001</p>
				<p>Call us: <a href="#">(+01) 202 342 6789</a></p>
			</div>
			<div class="flex-child-ft item2">
				<h4>Resources</h4>
				<ul>
					<li><a href="#">About</a></li> 
					<li><a href="#">Blockbuster</a></li>
					<li><a href="#">Contact Us</a></li>
					<li><a href="#">Forums</a></li>
					<li><a href="#">Blog</a></li>
					<li><a href="#">Help Center</a></li>
				</ul>
			</div>
			<div class="flex-child-ft item3">
				<h4>Legal</h4>
				<ul>
					<li><a href="#">Terms of Use</a></li> 
					<li><a href="#">Privacy Policy</a></li>	
					<li><a href="#">Security</a></li>
				</ul>
			</div>
			<div class="flex-child-ft item4">
				<h4>Account</h4>
				<ul>
					<li><a href="#">My Account</a></li> 
					<li><a href="#">Watchlist</a></li>	
					<li><a href="#">Collections</a></li>
					<li><a href="#">User Guide</a></li>
				</ul>
			</div>
			<div class="flex-child-ft item5">
				<h4>Newsletter</h4>
				<p>Subscribe to our newsletter system now <br> to get latest news from us.</p>
				<form action="#">
					<input type="text" placeholder="Enter your email...">
				</form>
				<a href="#" class="btn">Subscribe now <i class="ion-ios-arrow-forward"></i></a>
			</div>
		</div>
	</div>
	<div class="ft-copyright">
		<div class="ft-left">
			<p><a target="_blank" href="https://www.templateshub.net">Templates Hub</a></p>
		</div>
		<div class="backtotop">
			<p><a href="#" id="back-to-top">Back to top  <i class="ion-ios-arrow-thin-up"></i></a></p>
		</div>
	</div>
</footer>
<!-- end of footer section-->

<script src="js/jquery.js"></script>
<script src="js/plugins.js"></script>
<script src="js/plugins2.js"></script>
<script src="js/custom.js"></script>
</body>

<!-- blogdetail13:40-->
</html>
</html>