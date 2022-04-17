<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<form action="insertPro.jsp" method="post">
		아이디 : <input type = "text" name = "id"><br>
		비밀번호 : <input type = "password" name = "pwd"><br>
		이름 : <input type = "text" name = "name"><br>
		<input type = "submit" value = "로그인">
		
	</form>
</body>
</html>
