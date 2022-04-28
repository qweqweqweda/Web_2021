<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>login 데이터 조회</title>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<%
		//DBCP로 변경
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/jylee");
		Connection con = ds.getConnection();
	
		//3. 연결 설정
		String sql = "select * from board";
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		
	%>
	<div class="container mt-3">
	<table class = "table">
		<tr>
			<th>게시판</th>
			<th>제목</th>
		</tr>
		<tr>
	<%
		//4. 반환데이터 출력
		while(rs.next()){
			//rs.getString(1);
			String bNo = (rs.getString("bNo"));
			String bTag = (rs.getString("bTag"));
			String bTitle = (rs.getString("bTitle"));
			String bString = (rs.getString("bString"));
		
	%>		
			<td><%=bTag %></td>
			<td><a href="view.jsp?bNo=<%=bNo %>"><%=bTitle %></a></td>
		</tr>
	<%
		}
	%>
		</table>
		<br>
		<button type="button" onclick="location.href='insert.jsp'">글쓰기</button>
		</div>
	<% 
		//연결 해체
		rs.close();
		stmt.close();
		con.close();
	%>
</body>
</html>
