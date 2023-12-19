<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>kdw 로그인</title>
		<link rel="stylesheet" href="resources/css/login_form.css">
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<script src="resources/js/httpRequest.js"></script>
		<script type="text/javascript">
			function login(f){
				var id = f.id.value;
				var pwd = f.pwd.value;
				
				if(id == ''){
					swal("로그인 불가!!","아이디를 입력해 주세요!!","warning");
					
					return;
				}
				if(pwd == ''){
					swal("로그인 불가!!","비밀번호를 입력해 주세요!!","warning");
					
					return;
				}
				
				var url = "login.do";
				var param = "id="+id+"&pwd="+pwd;
				
				sendRequest(url,param,m_check,"POST");
			}
			
			function m_check(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var data = xhr.responseText;
					var json = (new Function('return' + data))();
					
					if(json[0].result == 'no_id'){
						swal("아이디가 존재하지 않습니다!","다시 확인 후 로그인하세요!","warning");
					} else if(json[0].result == 'no_pwd'){
						swal("비밀번호가 일치하지 않습니다!","다시 확인 후 로그인하세요!","warning");
					} else{
						swal({
						    title: "로그인 성공!",
						    icon: "success",
						    buttons: {
						      confirm: {
						        text: "확인",
						        value: true,
						        visible: true,
						        className: "",
						        closeModal: true
						      }
						    }
						  }).then(function() {
						    location.href = "board.do";
						  });
					}
				}
			}
		</script>
	</head>
	<body style="background-image: url('resources/img/login_form.png'); background-size: 100% 100%;">
		<div class="container">
			<div class="inside">
				<div class="xbtn" onclick="location.href='board.do'" style="cursor: pointer;"></div>
				<h1>Login</h1>
				<form action="" method="post">
					<div class="login_form">
						 <input type="text" id="id" name="id" placeholder="아이디">
					</div>
					<div class="login_form">
						<input type="password" id="pwd" name="pwd" placeholder="비밀번호">
					</div>
					<div class="login_form">
						<input type="button" class="login_btn" value="로그인" onclick="login(this.form)"> <br> 
						<input type="button" class="member_btn" value="회원가입" onclick="location.href='member_insert.do'">
					</div>
					<div>
						<a href="find_id.do" class="find">
							<font color="black">아이디/비밀번호 찾기</font>
						</a>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>