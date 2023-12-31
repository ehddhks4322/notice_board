<h1>커뮤니티 게시판</h1>
공부도 할 겸 커뮤니티 게시판을 만들어보고 싶어서 제작하게 되었습니다.<br><br>
<b>Spring / Oracle DB / API / Apache Tomcat 등</b>을 활용하여<br>
<b>로그인 / 회원가입 / 아이디 찾기 / 비밀번호 찾기 / 글쓰기 / 글 상세 보기 / 댓글 등의 기능</b>을 구현하였습니다.<br>

![ER Diargram](https://github.com/ehddhks4322/notice_board/assets/117495667/66443a0a-d36b-4ddd-af8c-ba05d64c42d2)<br>
DB 구조도를 확인해 보면 <b>게시판, 회원, 댓글</b>로 나누어져 있습니다.<br><br>

<b>게시판</b>은 <b>[게시글 번호, 작성자, 제목, 내용, 게시글 비밀번호, IP, 작성일자, 조회 수, 기준 글 번호, 글 순서, 글의 깊이, 이미지]</b> 순으로 포함하고있습니다.<br>
<b>게시판의 ID는 회원의 ID를 참조하는 외래 키로 설정되어 있으며,<br> 
ON DELETE CASCADE 조건을 적용해 회원이 탈퇴할 경우 해당 회원의 게시글도 함께 삭제됩니다.</b><br><br>

<b>회원</b>은 <b>[회원 번호, 이름, 아이디. 비밀번호, 이메일, 주소]</b> 순으로 포함하고있습니다.<br><br>
여기서 이름과 이메일을 통하여 아이디를 찾고, 아이디와 이메일을 통하여 비밀번호 찾기를 하는데<br>
<b>javax.mail을 활용하여
비밀번호 찾기를 할 때 이메일로 발송된 번호를 입력해야만 비밀번호 재설정이 가능하도록 구현했습니다.</b><br><br>

<b>댓글</b>은 <b>[댓글 번호, 게시물 번호, 작성자, 내용, 작성일자. 기준 글 번호, 댓글 순서, 댓글의 깊이]</b> 순으로 포함하고있습니다.<br><br>
위의 게시판처럼 <b>댓글의 C_ID는 회원의 ID를 참조하는 외래 키로 설정되어 있으며,<br>
회원 탈퇴 시 ON DELETE CASCADE 조건을 적용해 댓글도 자동으로 삭제됩니다.</b><br><br>
그리고 <b>댓글의 B_IDX는 게시판의 IDX를 참조해서 외래 키로 설정되어 있으며,<br>
이 경우에도 ON DELETE CASCADE 조건을 적용하여, 게시글이 삭제될 때 해당하는 댓글들도 자동으로 삭제되도록 구현되어 있습니다.</b>
