<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.sql.*"%>
    <%
    	request.setCharacterEncoding("UTF-8");
    	//클라이언트에서 전달된 데이터
    	String bTag = request.getParameter("bTag");
    	String bTitle = request.getParameter("bTitle");
    	String bString = request.getParameter("bString");
    	String bNo = request.getParameter("bNo");

    	 //DBCP로 변경
	Context initCtx = new InitialContext(); //JNDI를 사용하기 위한 객체 생성
	Context envCtx = (Context)initCtx.lookup("java:comp/env"); //등록된 JNDI 서비스로부터 자원을 검색
	DataSource ds = (DataSource)envCtx.lookup("jdbc/ParkCH"); //java:comp/env 영역에서 “jdbc/ParkCH”으로 설정된 이름의 DataSource 객체 획득
	Connection con = ds.getConnection(); //ds.getConnection()메소드를 사용해서 커넥션 풀로부터 커넥션 객체를 할당 받음
	

    	
		//3. sql문
		String sql = "delete from board where bNo =?";
		
		//4 sql 실행
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, bNo);
		
		int i = pstmt.executeUpdate();
		
		//4. 연결 해체
		pstmt.close();
		con.close();
		
		response.sendRedirect("board.jsp");
	%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	delete.
</body>
</html>
