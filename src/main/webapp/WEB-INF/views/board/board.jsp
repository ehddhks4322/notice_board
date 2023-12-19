<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>kdw 게시판</title>
		<link rel="stylesheet" href="resources/css/main.css">
		<style type="text/css">
			a{text-decoration: none;}
		/* 	table{border-collapse: collapse;} */
		</style>
	</head>
	<body style="background-image: url('resources/img/main.jpg'); background-size: cover;">
		<div class="container">
			<table border="1" width="700" align="center">
				<tr>
					<td colspan="5" align="right">
						 <c:choose>
							<c:when test="${empty member}"> 
								<input type="button" value="로그인" onclick="location.href='login_form.do'">
								<input type="button" value="회원가입" onclick="location.href='member_insert.do'">
							 </c:when> 
							 <c:when test="${not empty member}">
								<input type="button" value="로그아웃" onclick="location.href='logout.do'">
								<input type="button" value="마이페이지" onclick="location.href='mypage.do'">
							</c:when> 
						 </c:choose> 
					</td>
				</tr>
				<tr>
					<td colspan="5"><img src="resources/img/title_04.gif"></td>
				</tr>
				
				<tr>
				    <th>번호</th>
				    <th>제목</th>
				    <th>작성자</th>
				    <th>작성일</th>
				    <th>조회수</th>
				</tr>
				
				<c:forEach var="bd" items="${list}">
				    <tr>
				        <td>${bd.idx}</td>
				        <td>
				            <c:forEach begin="1" end="${bd.depth}">&nbsp;</c:forEach>
				            <c:if test="${bd.depth ne 0}">▶</c:if>
				            <a href="board_view.do?idx=${bd.idx}&page=${param.page}">
				                <font color="black">${bd.subject}</font>
				            </a>
				        </td>
				        <td>${bd.id}</td>
				        <td>${bd.regdate}</td>
				        <td>${bd.readhit}</td>
				    </tr>
				</c:forEach>
				
				<tr>
				    <td colspan="5" align="center" id="page">${pageMenu}</td>
				</tr>
				
				<tr>
				    <td colspan="5" align="right">
				        <img src="resources/img/btn_reg.gif" onclick="location.href='insert_form.do'" style="cursor:pointer;">
				    </td>
				</tr>
			</table>
		</div>
	</body>
</html>