<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 변경</title>
		<link rel="stylesheet" href="resources/css/update_pwd.css">
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<script src="resources/js/httpRequest.js"></script>
		<script type="text/javascript">
			function change_pwd(f){
				var id = document.getElementById("id").value.trim();
				var m_pwd = document.getElementById("m_pwd").value.trim();
				var pwd = f.pwd.value.trim();
				var c_pwd = f.pwd_check.value.trim();
				var pwd_pt = /^([a-zA-Z|0-9]{8,16})$/;
				
				if(pwd == ''){
					swal("비밀번호 변경 불가!","비밀번호를 입력해 주세요!","warning");
					return;
				}
				if(c_pwd == ''){
					swal("비밀번호 변경 불가!","비밀번호 확인창에 입력해 주세요!","warning");
					return;
				}
				if(!pwd_pt.test(pwd)){
					swal("비밀번호 변경 불가!","영어와 숫자로 8~16 사이만 입력 가능합니다!","warning");
					return;
				}
				if(pwd != c_pwd){
					swal("비밀번호 변경 불가!","비밀번호와 비밀번호 확인창의 비밀번호 불일치!","warning");
					return;
				}
				console.log("m_pwd:", m_pwd);
				console.log("pwd:", pwd);
				if(m_pwd == pwd){
					swal("비밀번호 변경 불가!","이전 비밀번호와 같은 비밀번호는 사용 불가입니다!","warning");
					return;
				}
				
				var url = "result_pwd.do";
				var param = "id="+id+"&pwd="+pwd;
				
				sendRequest(url,param,resultPwd,"POST");
			}
			
			function resultPwd(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var data = xhr.responseText;
					var json = (new Function('return' + data))();
					
					if(json[0].result == 'yes'){
						swal({
						    title: "비밀번호를 변경하였습니다!",
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
					else{
						swal("비밀번호 변경에 실패했습니다!","계속 안될 시 고객센터에 문의해 주세요!","warning");
						return;
					}
				}
			}
		</script>
		
	</head>
	<body>
		<div class="container" style="background-color: #00bfff">
			<div class="inside">
				<div class="xbtn" onclick="location.href='login_form.do'" style="cursor: pointer;"></div>
				<h1> 비밀번호 변경 </h1>
				<form action="" method="post">
					<input type="hidden" id="id" value="${pw_vo.id}">
					<input type="hidden" id="m_pwd" value="${pw_vo.pwd}">
					<div class="find_form">
						<h5>
							새 비밀번호 <span>*영어와 숫자로 8~16 사이만 가능합니다!</span>
						</h5>
					 	<input type="password" name="pwd">
					</div>
					<div class="find_form">
						<h5>
							새 비밀번호 확인<span>*위에 입력한 비밀번호를 다시 입력해주세요!</span>
						</h5>
						<input type="password" name="pwd_check">
					</div>
					<div class="find_form">
						<input type="button" class="check_btn" value="비밀번호 변경" onclick="change_pwd(this.form)">
					</div>
				</form>
			</div>
		</div>
	</body>
</html>