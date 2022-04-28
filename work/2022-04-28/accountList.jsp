<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
 //DBCP로 변경
	Context initCtx = new InitialContext(); //JNDI를 사용하기 위한 객체 생성
	Context envCtx = (Context)initCtx.lookup("java:comp/env"); //등록된 JNDI 서비스로부터 자원을 검색
	DataSource ds = (DataSource)envCtx.lookup("jdbc/ParkCH"); //java:comp/env 영역에서 “jdbc/ParkCH”으로 설정된 이름의 DataSource 객체 획득
	Connection con = ds.getConnection(); //ds.getConnection()메소드를 사용해서 커넥션 풀로부터 커넥션 객체를 할당 받음
	
	
	//3. 생성된 연결을 통해 SQL문 실행 의뢰 준비
	String sql = "SELECT * FROM LOGIN";
	Statement stmt = con.createStatement();
	
	//4. SQL 실행
	ResultSet rs = stmt.executeQuery(sql);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사용자 목록</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container"><br>	
	<h1 class="text-center font-weight-bold">회원 정보</h1>
	<br>
	<table class="table table-hover">
		<tr>
			<th>아이디</th>
			<th>이메일</th>
			<th>이름</th>
			<th>비밀번호</th>
		</tr>
<% 
	//5. 결과집합 처리 
	while (rs.next()){
		String id = rs.getString("id");
		String email = rs.getString("email");
		String name = rs.getString("name");
		String pwd = rs.getString("pwd");
%>	
		<tr>
			<td><a href="accountUpdate.jsp?id=<%=id %>"><%=id %></a></td>
			<td><%=email %></td>
			<td><%=name %></td>
			<td><%=pwd %></td>
		</tr>
<%} 
	//6. 연결 해제
	rs.close();
	stmt.close();
	con.close();
%>
	</table>
	</div>	
	<!-- 게시글 -->
<button type="button" onclick="location.href='board.jsp'">게시글</button>
<button type="button" onclick="location.href='index.jsp'">메인</button>
</body>
</html>
