<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>kdw 게시판</title>
		<link rel="stylesheet" href="resources/css/board_view.css">
		<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
		<script src="resources/js/httpRequest.js"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<script type="text/javascript">
			//이미지 슬라이드
			 $(document).ready(function(){
		        var currentImg = 0; // 초기 이미지
		        var totalImgs = $('.slider div').length; // 총 이미지 개수 (4개일 경우 0,1,2,3 *컴퓨터는 0부터 숫자를 체크하기떄문에*)
		        
		        function changeImg(){
		            $('.slider div').hide();
		            $('.slider div:eq(' + currentImg + ')').show(); //클래스가 slider인 요소들 중에서 div태그를 찾아내고 그 중에서 현재 이미지의 인덱스에 해당하는 요소를 선택하고 보여준다.
		        }
		
		        $('#nextBtn').click(function(){
		            if(currentImg < totalImgs - 1){
		                currentImg++;
		            } else {
		                currentImg = 0;
		            }
		            //3에서 다음을 누르게되면 3<3으로 참이여서 증감을하는데 증감을 하게되면 4<3 이므로 else절로 들어가서 0으로 이동시킨다(첫번째 이미지로 이동시킨다)
		            changeImg();
		        });
		
		        $('#prevBtn').click(function(){
		            if(currentImg > 0){
		                currentImg--;
		            } else {
		                currentImg = totalImgs - 1;
		            }
		            //초기 0에서 이전을 누르게되면 0>0이여서 참으로 감소하게되면 -1>0 이므로 else절로 들어가서 3으로 이동시킨다(마지막 이미지로 이동시킨다)
		            changeImg();
		        });
		
		        changeImg();
		        
		    });
			//글 삭제
			function del(){
				if(!confirm("삭제하시겠습니까?")){
					return;
				}
				
				var pwd = "${vo.pwd}"; //원본 비밀번호
				var c_pwd = document.getElementById("c_pwd").value; //입력한 비밀번호
				
				if(pwd != c_pwd){
					swal("비밀번호 불일치!!","비밀번호를 다시 확인 후 입력하세요!","warning");
					return;
				}
				
				var url = "board_del.do";
				var param = "idx=${vo.idx}";
				sendRequest(url,param,delCheck,"POST");
			}
			
			function delCheck(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var data = xhr.responseText;
					var json = (new Function('return' + data))();
					
					if(json[0].result == 'yes'){
						swal("삭제성공!","삭제가 정상적으로 완료되었습니다!","success");
						location.href="board.do?page=${param.page}"; 
					}else{
						swal("삭제실패!","","warning");
					}
				}
			}
			
			//댓글등록
			function c_reg(){
				var b_idx = f.b_idx.value;
				var c_id = f.c_id.value;
				var content = f.content.value;
				
				if(content == ''){
					swal("댓글을 입력하세요!","","warning");
					return;
				}
				
				if(content.length > 300){
					swal("댓글은 300자 이상불가!","","warning");
					return;
				}
				
				var url = "c_reg.do";
				var param = "b_idx="+b_idx+"&c_id="+c_id+"&content="+content;
				
				sendRequest(url,param,resultReg,"POST");
			}
			
			function resultReg(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var data = xhr.responseText;
					var json = (new Function('return' + data))();
					
					if(json[0].result == 'yes'){
						swal({
						    title: "등록 성공!",
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
							  location.reload();
						  });
					}else{
						swal("등록실패!","","warning");
						return;
					}
				}
			}
			
			//댓글 삭제
			function c_del(idx){
				if(!confirm("삭제하시겠습니까?")){
					return;
				}
				
				var f2 = document.f2;
				var m_id = f2.m_id.value; //현재 로그인한 아이디
				var c_id = document.getElementById('co_id_' + idx).value; //댓글 작성한 아이디
				console.log(m_id);
				console.log(c_id);
				if(m_id != c_id){
					swal("삭제불가!","글 작성자가 아닙니다!","warning");
					return;
				}
				
				var url = "c_del.do";
				var param = "idx="+idx;
				sendRequest(url,param,resultDel,"POST");
			}
			
			function resultDel(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var data = xhr.responseText;
					var json = (new Function('return' + data))();
					
					if(json[0].result == 'yes'){
						swal({
						    title: "삭제 성공!",
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
							  location.reload();
						  });
					}else{
						swal("삭제 실패!","","warning");
						return;
					}
				}
			}
		</script>
	</head>
	<body style="background-image: url('resources/img/main.jpg'); background-size: cover;">
		<div class="container">
			<div class="board-container">
			    <div class="board-header">
			        <h1>●게시글 상세보기●</h1>
			    </div>
			    
			    <div class="board-row">
			        <div class="board-col">
			            <label for="subject">제목</label>
			        </div>
			        <div class="board-col">
			            ${vo.subject}
			        </div>
			    </div>
			    
			    <div class="board-row">
			        <div class="board-col">
			            <label for="name">작성자</label>
			        </div>
			        <div class="board-col">
			            ${vo.id}
			        </div>
			    </div>
			    
			    <div class="board-row">
			        <div class="board-col">
			            <label for="regdate">작성일</label>
			        </div>
			        <div class="board-col">
			            ${vo.regdate}
			        </div>
			    </div>
			    
			    <div class="s_container">
				    <div class="slider">
				    	<c:if test="${vo.img1 ne 'no_file'}">
				        	<div><img id="img1" src="${pageContext.request.contextPath}/resources/upload/${vo.img1}"  alt="Image 1" width="300" height="200" style="cursor:pointer;" onclick="window.open(this.src)"></div>
				        </c:if>
				        <c:if test="${vo.img2 ne 'no_file'}">
				        	<div><img id="img2" src="${pageContext.request.contextPath}/resources/upload/${vo.img2}"  alt="Image 2" width="300" height="200" style="cursor:pointer;" onclick="window.open(this.src)"></div>
				        </c:if>
				        <c:if test="${vo.img3 ne 'no_file'}">
				        	<div><img id="img3" src="${pageContext.request.contextPath}/resources/upload/${vo.img3}"  alt="Image 3" width="300" height="200" style="cursor:pointer;" onclick="window.open(this.src)"></div>
				        </c:if>
				        <c:if test="${vo.img4 ne 'no_file'}">
				        	<div><img id="img4" src="${pageContext.request.contextPath}/resources/upload/${vo.img3}"  alt="Image 4" width="300" height="200" style="cursor:pointer;" onclick="window.open(this.src)"></div>
				        </c:if>
				    </div>
				    <c:if test="${vo.img1 ne 'no_file' or vo.img2 ne 'no_file' or vo.img3 ne 'no_file' or vo.img4 ne 'no_file'}">
					    <button id="prevBtn">이전</button>
					    <button id="nextBtn">다음</button>
				    </c:if>
			    </div>
			    
			    <div class="board-row">
			        <div class="board-col">
			            <label for="content" id="co_label">내용</label>
			        </div>
			        <div class="board-col" style="width: 500px; height: 200px;">
			            <pre id="cont">${vo.content}</pre>
			        </div>
			    </div>
			    
			    <div class="board-row">
			        <div class="board-col">
			            <label for="c_pwd">비밀번호</label>
			        </div>
			        <div class="board-col">
			            <input type="password" id="c_pwd">
			        </div>
			    </div>
			    
			    <div class="board-row">
			        <div class="board-col" colspan="2">
			            <!-- 목록보기 -->
			            <img src="resources/img/btn_list.gif" onclick="location.href='board.do'" style="cursor:pointer;">
			            
			            <!-- 답글달기(depth가 1보다 크면 답글을 못달게 만들기) -->
			            <%-- <c:if test="${vo.depth lt 1}">
			                <img src="resources/img/btn_reply.gif" onclick="reply()" style="cursor:pointer;">
			            </c:if> --%>
			            
			            <!-- 삭제 -->
			            <img src="resources/img/btn_delete.gif" onclick="del()" style="cursor:pointer;">
			        </div>
			    </div>
			    
			    <div>
			    	<h3>댓글&nbsp;</h3>
			    </div>
			    
			    <!-- 댓글 -->
			    <form name="f" method="post">
			    	<input type="hidden" value="${member.id}" name="c_id">
			    	<input type="hidden" value="${vo.idx}" name="b_idx">
				    <div>
				    	<!-- 댓글 작성(로그인 상태에만 보이게) -->
				    	<c:if test="${not empty member}">
				    		<div>
				    			<input type="text" name="content" placeholder="댓글입력(300자 이상X)" maxlength="300">
				    		</div>
				    		<div>
				    			<input type="button" value="등록" onclick="c_reg()">
				    		</div>
				    	</c:if>
				    </div>
			    </form>
			    
			    <!-- 댓글목록 -->
			    <form name="f2" method="post">
			    	<input type="hidden" value="${member.id}" name="m_id">
			    	<input type="hidden" value="${vo.idx}" name="b_idx">
			    	<div class="boder-com">
			    		<c:choose>
				    		<c:when test="${not empty c_list}">
				    			<c:forEach var="co" items="${c_list}">
				    				<input type="hidden" value="${co.idx}" name="idx">					
					    			<div>
					    				<input type="text" value="${co.c_id}" id="co_id_${co.idx}" class="c_id" readonly style="border: none; outline: none;"> <p id=c_reg>${co.regdate}</p>
					    			</div>
					    			<div>
					    				<p id="c_co">${co.content}</p>
					    			</div>
					    			
						    			<div style="border-bottom: 2px solid #40e0d0;">
							    			<c:if test="${co.content ne '삭제된 글입니다.'}">
							    				<a href="#" onclick="c_del(${co.idx})" style="text-decoration: none;" ><font color="black">삭제</font></a>
						    				</c:if>
						    			</div>
				    				
				    			</c:forEach>
				    		</c:when>
			    		</c:choose>
			    		<div>
	    					${c_pageMenu}
		    			</div>
			    		<div>
			    			
			    		</div>
			    	</div>
			    </form>
			</div>
		</div>
	</body>
</html>