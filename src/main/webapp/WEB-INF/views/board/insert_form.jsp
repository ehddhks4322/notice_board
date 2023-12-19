<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>kdw 게시판</title>
		<link rel="stylesheet" href="resources/css/insert_form.css">
		<script src="resources/js/httpRequest.js"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<script type="text/javascript">
			function send_check(){
				var f = document.f;
				
				var id = f.id.value;
				var subject = f.subject.value;
				var content = f.content.value;
				var pwd = f.pwd.value;
				
				if(subject == ''){
					swal("제목을 입력해 주세요!","","warning");
					return;
				}
				if(content == ''){
					swal("내용을 입력해 주세요!","","warning");
					return;
				}
				if(content.length > 4000){
					swal("내용은 4000자를 초과할 수 없습니다!","","warning");
					return;
				}
				
				f.action = "b_insert.do";
				f.method = "POST";
				f.submit();
				
			}
		</script>
	</head>
	<body style="background-image: url('resources/img/insert_form2.png'); background-size: 100% 100%; background-repeat: no-repeat; height: 100vh; margin: 0;">
		<div class="container">
			<form name="f" enctype="multipart/form-data">
				<table border="1" width="700" height="700" align="center">
					<tr>
						<td colspan="2" align="center"><p1>●게시글 작성●</p1></td>
					</tr>
					
					<tr>
						<th>제목</th>
						<td><input type="text" name="subject" placeholder="제목을 입력하세요!" style="width:90%; height:90%; font-size: 15px"></td>
					</tr>
					
					<tr>
						<th>작성자</th>
						<td><input type="text" name="id" value="${member.id}" style="width:90%; height:90%; font-size: 15px" readonly="readonly"></td>
					</tr>
					
					<tr>
						<th>이미지</th>
						<td style="color: black;">
							<input type="file" name="img1">
							<input type="file" name="img2">
							<input type="file" name="img3">
							<input type="file" name="img4">
						</td>
					</tr>
					
					<tr>
						<th>내용</th>
						<td><textarea rows="10" cols="50" name="content" style="resize:none; width:99%; height:97%;" placeholder="내용을 입력해주세요!" maxlength="4000"></textarea></td>
					</tr>
					
					<tr>
						<th>비밀번호</th>
						<td><input name="pwd" type="password" value="${member.pwd}" style="width:90%; height:90%; font-size: 15px" readonly="readonly"></td>
					</tr>
					
					<tr>
						<td colspan="2" align="right">
							<img src="resources/img/btn_reg.gif" onclick="send_check()" style="cursor:pointer;">
							<img src="resources/img/btn_back.gif" onclick="location.href='board.do'" style="cursor:pointer;">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>