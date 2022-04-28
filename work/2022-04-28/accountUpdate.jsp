<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*" %>
<% 	String id = request.getParameter("id");
	
 //DBCP로 변경
	Context initCtx = new InitialContext(); //JNDI를 사용하기 위한 객체 생성
	Context envCtx = (Context)initCtx.lookup("java:comp/env"); //등록된 JNDI 서비스로부터 자원을 검색
	DataSource ds = (DataSource)envCtx.lookup("jdbc/ParkCH"); //java:comp/env 영역에서 “jdbc/ParkCH”으로 설정된 이름의 DataSource 객체 획득
	Connection con = ds.getConnection(); //ds.getConnection()메소드를 사용해서 커넥션 풀로부터 커넥션 객체를 할당 받음
	
	String sql = "select * from login where id = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, id);
	
	ResultSet rs = pstmt.executeQuery();
	
	String email ="";
	String name ="";
	String pwd ="";
	
	if(rs.next()){
		email = rs.getString("email");
		name = rs.getString("name");
		pwd = rs.getString("pwd");
	}
%>	
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>멤버 정보 변경</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="container">
		<br>
		<h2 class="text-center font-weight-bold">사용자 정보 변경</h2>
		<hr/>
		<form action="accountUpdatePro.jsp" method="post">
		  <div class="form-group">
	      <label for="id">ID:</label>
	      <input type="text" class="form-control" id="id" name="id" value="<%=id%>" readonly>
	    </div>
	    <div class="form-group">
	      <label for="email">E-Mail:</label>
	      <input type="text" class="form-control" id="email" name="email" value="<%=email%>">
	    </div>
	    <div class="form-group">
	      <label for="name">NAME:</label>
	      <input type="text" class="form-control" id="name" name="name" value="<%=name%>">
	    </div>
	    <div class="form-group">
	      <label for="pwd">PASSWORD:</label>
	      <input type="password" class="form-control" id="pwd" name="pwd" value="<%=pwd%>">
	    </div>
	    <br>
	    <div class="text-center">
	    		<input type="submit" value="변경" class="btn btn-secondary">  
					<input type="button" value="삭제" class="btn btn-secondary" onclick="location.href='deleteAccount.jsp?id=<%=id%>'">
					<input type="button" value="목록" class="btn btn-secondary" onclick="location.href='accountList.jsp'">
			</div>
		</form>
	</div>
</body>
</html>
