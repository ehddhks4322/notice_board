<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>MyPage</title>
		<link rel="stylesheet" href="resources/css/mypage.css">
		<script src="resources/js/httpRequest.js"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<script type="text/javascript">
			function secession(){			
				if(!confirm("탈퇴하시겠습니까?")){
					return;
				}
				
				var url = "secession.do";
				var param = "id=${member.id}";
				sendRequest(url,param,resultFn,"POST");
			}
			
			function resultFn(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var data = xhr.responseText;
					var json = (new Function('return' + data))();
					
					if(json[0].result == 'yes'){
						swal({
					        title: "탈퇴완료!",
					        text: "회원탈퇴가 성공적으로 완료되었습니다!",
					        icon: "success",
					    }).then((value) => {
					        if (value) {
					            //확인을 누를시"secession_out.do" 이동
					            location.href = "secession_out.do";
					        }
					    });
					} else{
						swal("탈퇴실패!","","warning");
					}
				}
			}
		</script>
	</head>
	<body style="background-image: url('resources/img/mypage2.png'); background-size: 100% 100%; background-repeat: no-repeat; height: 100vh; margin: 0;">
		<div class="container">
			<div class="xbtn" onclick="location.href='board.do'" style="cursor: pointer;"></div>
			<h1 style="margin-bottom: 5px;">My Info</h1>
			<h3 style="margin: 0 0 40px 0; font-weight: normal; font-size: 17px; color: #e83d1e;">● 회원 정보 ●</h3>
				<div class="mypage_form">
					<h5>
						아이디 <span>*</span>
					</h5>
					<div class="id_div">
						<input id="id" value="${member.id}" disabled> 
					</div>
				</div>
					
				<div style="margin-bottom: 10px;">
					<h5>
						이름 <span>*</span>
					</h5>
					<input id="name" value="${member.name}" disabled>
				</div>
				
				<div class="email_div" style="margin-bottom: 20px;">
					<h5>
						이메일 <span>*</span>
					</h5>
					<input value="${member.email}" disabled>
				</div>
	
				<div class="add_div">
					<div class="mypage_form">
						<h5>
							주소 <span>*</span>
						</h5>
						<input id="addr" value="${member.addr}" disabled>
					</div>
				</div>
	
				<input type="button" value="확인" class="check_button" onclick="location.href='board.do'">
				<input type="button" value="회원탈퇴" class="secession_btn" onclick="secession()">
		</div>
	</body>
</html>