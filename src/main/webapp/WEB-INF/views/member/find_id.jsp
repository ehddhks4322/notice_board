<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>아이디 찾기</title>
		<link rel="stylesheet" href="resources/css/find_id.css">
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<script src="resources/js/httpRequest.js"></script>
		<script type="text/javascript">
			function find_id(f){
				var name = f.name.value;
				var email = f.email.value;
				var n_pt = /^([가-힣]{2,5})$/;
				var email_pt = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
				
				if(name == ''){
					swal("이름을 입력해 주세요!","","warning");
					return;
				}
				if(!n_pt.test(name)){
					swal("이름을 제대로 입력해 주세요!","한글로 2~5자리!","warning");
					return;
				}
				if(email == ''){
					swal("이메일을 입력해 주세요!","","warning");
					return;
				}
				if (!email_pt.test(email)) {
				    swal("올바른 이메일 형식이 아닙니다!","","warning");
				    return;
				}
				
				var url = "result_id.do";
				var param = "name="+name+"&email="+email;
				
				sendRequest(url,param,result_id,"POST");
			}
			
			function result_id(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var data = xhr.responseText;
					var json = (new Function('return' + data))();
					
					if(json[0].result == 'no'){
						swal("일치하는 가입 정보가 없습니다!","다시 확인 후 작성해 주세요!","warning");
						return;
					}
					if(json[0].result == 'yes'){
						swal({
						    title: "아이디: " + json[0].id + "입니다!",
						    text: "로그인 페이지로 이동합니다!",
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
						    location.href = "login_form.do";
						  });
					}
				}
			}
		</script>
	</head>
	<body style="background-image: url('resources/img/login_form.png'); background-size: 100% 100%;">
		<div class="container">
			<div class="inside">
				<div class="xbtn" onclick="location.href='login_form.do'" style="cursor: pointer;"></div>
				<h1> 아이디 찾기 </h1>
				<form action="" method="post">
					<div class="find_form">
						 <input type="text" name="name" placeholder="이름">
					</div>
					<div class="find_form">
						<input type="text" name="email" placeholder="aaa@naver.com">
					</div>
					<div class="find_form">
						<input type="button" class="check_btn" value="아이디 찾기" onclick="find_id(this.form)"> <br> 
						<input type="button" class="findPwd_btn" value="비밀번호 찾기" onclick="location.href='find_pwd.do'">
					</div>
				</form>
			</div>
		</div>
	</body>
</html>