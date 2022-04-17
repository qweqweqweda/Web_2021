<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.sql.*"%>
    <%
    	request.setCharacterEncoding("UTF-8");
    	//클라이언트에서 전달된 데이터
    	String id = request.getParameter("id");
    	String pass = request.getParameter("pwd");
    	String name = request.getParameter("name");
		//1. JDBC드라이버를 로드
		Class.forName("org.mariadb.jdbc.Driver");
		//2. 연결통로(connection) 얻기
		String url = "jdbc:mariadb://localhost:3306/parkCHdb";
		String user = "ParkCH";
		String pwd = "1111";
		
		Connection con = DriverManager.getConnection(url, user, pwd);
		//3. sql문
		String sql = "insert into login(id, pwd, name) values(?, ?, ?)";
		
		//4 sql 실행
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pass);
		pstmt.setString(3, name);
		
		int i = pstmt.executeUpdate();
		
		//4. 연결 해체
		pstmt.close();
		con.close();
		
		response.sendRedirect("list.jsp");
	%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	총<%=i %>개 입력
</body>
</html>
