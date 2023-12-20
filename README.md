<h1>커뮤니티 게시판</h1>
공부도 할겸 커뮤니티 게시판을 만들어보고 싶어서 제작하게되었습니다.<br>
Spring / Oracle DB / API / Apache Tomcat 등을 활용하여<br>
로그인 / 회원가입 / 아이디 찾기 / 비밀번호 찾기 / 글 쓰기 / 글 상세보기 / 댓글등의 기능을 넣었습니다.<br>

![ER Diargram](https://github.com/ehddhks4322/notice_board/assets/117495667/66443a0a-d36b-4ddd-af8c-ba05d64c42d2)<br>
DB 구조도를 확인 해보면 게시판, 회원, 댓글로 나뉘어져있습니다.<br><br>

게시판은 순서대로 게시글 번호, 작성자, 제목, 내용, 게시글 비밀번호, IP, 작성일자, 조회수, 기준글 번호, 글 순서, 글의 깊이, 이미지 순으로 되어있습니다.<br>
게시판의 ID는 회원의 ID를 참조해서 외래키로 쓰고있으며,<br> 
조건에 ON DELETE CASCADE 를 넣어서 회원탈퇴 할 시 게시글도 같이 삭제되게 되어있습니다.<br><br>

회원은 순서대로 회원 번호, 이름, 아이디. 비밀번호, 이메일, 주소 순으로 되어있습니다.<br><br>
여기서 이름과 이메일을 통하여 아이디 찾기를 하고, 아이디와 이메일을 통하여 비밀번호 찾기를 하는데<br>
비밀번호 찾기를 할 때 이메일 인증을 통하여 이메일로 발송된 번호를 입력해야 비밀번호 재설정을 하게 만들었습니다.<br><br>

댓글은 순서대로 댓글 번호, 게시물 번호, 작성자, 내용, 작성일자. 기준글 번호, 댓글 순서, 댓글의 깊이 순으로 되어있습니다.<br><br>
위의 게시판처럼 댓글의 C_ID는 회원의 ID를 참조해서 외래키로 쓰고있으며,<br>
조건에 ON DELETE CASCADE 를 넣어서 회원 탈퇴시 같이 삭제됩니다.<br><br>
그리고 댓글의 B_IDX는 게시판의 IDX를 참조해서 외래키로 쓰고있으며,<br>
이것도 역시 조건에 ON DELETE CASCADE 넣어 게시판의 글이 삭제되면 댓글도 같이 삭제되게 되어있습니다.
