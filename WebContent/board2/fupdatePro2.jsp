<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO2"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// center/fupdatePro.jsp
//  request이용,  업로드 폴더 /upload 물리적경로
// , 업로드파일크기 10M  ,  한글처리 , 파일이름 동일하면 이름변경
//  MultipartRequest 객체생성
String uploadPath=request.getRealPath("/upload2");
int maxSize=10*1024*1024;
MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

// request 파라미터 가져와서 변수에 저장
int num=Integer.parseInt(multi.getParameter("num"));
 String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
//file
String file=multi.getFilesystemName("file");
if(file==null){
	// 새롭게 수정할 파일이 없으면 기존 파일이름 "oldfile" 저장
	file = multi.getParameter("oldfile");
}

// BoardBean bb 바구니객체생성
BoardBean bb=new BoardBean();
// 바구니에 파라미터값 저장
bb.setNum(num);
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
// file
bb.setFile(file);

// BoardDAO bdao 객체생성
BoardDAO2 bdao=new BoardDAO2();
// int check=   numCheck(num,pass)
int check=bdao.numCheck(num, pass);
// check ==1  글수정  updateBoard(bb) notice.jsp 이동
// check ==0  "비밀번호틀림" 뒤로이동
// check == -1 "num없음" 뒤로이동
if(check==1){
	bdao.updateBoard(bb);
	response.sendRedirect("fnotice2.jsp");
}else if(check==0){
	%>
	<script>
		alert("비밀번호틀림");
		history.back();
	</script>
	<%
}else{
	%>
	<script>
		alert("num없음");
		history.back();
	</script>
	<%
}
%>