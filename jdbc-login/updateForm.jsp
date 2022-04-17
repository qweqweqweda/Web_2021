<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"%>
    
   <%  
    request.setCharacterEncoding("UTF-8");
	//클라이언트에서 전달된 데이터
	String id = request.getParameter("id");
	
	//1. JDBC드라이버를 로드
	Class.forName("org.mariadb.jdbc.Driver");
	//2. 연결통로(connection) 얻기
	String url = "jdbc:mariadb://localhost:3306/parkchdb";
	String user = "ParkCH";
	String pwd = "1111";
	
	Connection con = DriverManager.getConnection(url, user, pwd);
	//3. sql문
	String sql = "select * from login where id=?";
	
	//4 sql 실행
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, id);
	
	ResultSet rs = pstmt.executeQuery();
	
	String name = "";
	String pass = "";
	
	if(rs.next()){
		name = rs.getString("name");
		pass = rs.getString("pwd");
	}
	
	//4. 연결 해체
	rs.close();
	pstmt.close();
	con.close();
   %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사용자 입력</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	
</head>
<body>
	<div class="container">
		<br>
		<h2 class="text-center font-weight-bold">멤버 수정</h2>
		<hr/>
		
		<form action="updatePro.jsp" method="post">
			<div class="form-group">
		      <label for="id">ID:</label>
		      <input type="text" class="form-control" id="id" name="id" value ="<%=id %>">
		    </div>
		    <div class="form-group">
		      <label for="name">NAME:</label>
		      <input type="text" class="form-control" id="name" name="name" value ="<%=name %>">
		    </div>
		    <div class="form-group">
		      <label for="pwd">PASSWORD:</label>
			 <input type="password" class="form-control" id="pwd" name="pwd" value ="<%=pwd %>">
		    </div>
		    <br>
		    <div class="text-center">
				<input type="submit" value="변경저장">
				<button type="button" onclick="location.href='delete.jsp?id=<%=id%>'">삭제</button> <!-- type button 쓰기 -->
				<button type="button" onclick="location.href='list.jsp'">조회</button>
			</div>
		</form>
	
	</div>
</body>
</html>
