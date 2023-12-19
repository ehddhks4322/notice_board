<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 찾기</title>
		<link rel="stylesheet" href="resources/css/find_pwd.css">
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<script src="resources/js/httpRequest.js"></script>
		<script type="text/javascript">
			var b_isSend = false;
			var num;
			//인증번호 전송
			function send(f){
				var id = f.id.value;
				var email = f.email.value;
				var id_pt = /^([a-zA-Z|0-9]{2,12})$/;
				var email_pt = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
				
				if(id == ''){
					swal("아이디를 입력해 주세요!","","warning");
					return;
				}
				if(!id_pt.test(id)){
					swal("아이디를 제대로 입력해 주세요!","영어로 2~12자리!","warning");
					return;
				}
				if(email == ''){
					swal("이메일을 입력해 주세요!","","warning");
					return;
				}
				if(!email_pt.test(email)){
				    swal("올바른 이메일 형식이 아닙니다!","","warning");
				    return;
				}
				
				
				var url = "send.do";
				var param = "id="+id+"&email="+email;
				
				sendRequest(url,param,result_send,"POST");
				
			}
			
			function result_send(){
				 if(xhr.readyState == 4 && xhr.status == 200){
					 var data = xhr.responseText;
					 var json = (new Function('return' + data))();
					 
					 if(json[0].result == 'yes'){
						 swal({
						        title: "인증번호가 발송되었습니다!",
						        text: "이메일을 확인해주세요!",
						        icon: "success"
						    });
					 
						 isSend = true;
						 
						 num = json[0].authCode; //이메일로 발송된 인증번호
						 
					 } else {
						 swal("회원정보 불일치!","입력하신 회원정보가 없습니다!","warning");
						 return;
					 }
					 
				 }
					
			}
			
			function check_num(){
				var c_num = document.getElementById('authCode').value; //사용자가 입력한 인증번호
				if(!isSend){
					swal("인증번호 전송완료 후 버튼을 눌러주세요!", "", "warning");
					return;
				}
				
				if(c_num == num){
					swal({
					    title: "인증확인 되었습니다!",
					    text: "비밀번호 변경페이지로 이동합니다!",
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
					    location.href = "update_pwd.do";
					  });
				} else{
					swal("인증번호 불일치!","인증번호를 다시 확인 후 입력해주세요!","warning");
					return;
				}
			}			
			
			
		</script>
	</head>
	<body style="background-image: url('resources/img/login_form.png'); background-size: 100% 100%;">
		<form class="main-form first" method="post">
			<div class="container">
				<div class="xbtn" onclick="location.href='login_form.do'" style="cursor: pointer;"></div>
					<div class="find_form">
						<h1 style="text-align: center; margin-top: 0; font-weight: 600; font-family: 'Montserrat', sans-serif;">
							비밀번호 찾기
						</h1>
					</div>
						<div class="find_form">
							 <input type="text" name="id" placeholder="아이디">
						</div>
						<div class="find_form">
							<input type="text" name="email" placeholder="aaa@naver.com">
							<input type="button" id="send_button" value="전송" class="send_button" onclick="send(this.form)">
						</div>
						<div class="find_form">
							<input type="text" id="authCode" placeholder="인증번호" class="find_form_input"/> 
							<input type="button" id="check_n" value="확인" class="check_button" onclick="check_num()"/>
						</div>
						<!-- <div class="find_form">
							<input type="button" id="find_btn" value="비밀번호 변경" onclick="change_pwd(this.form)"/>
						</div> -->			
				
			</div>
		</form>
	</body>
</html>