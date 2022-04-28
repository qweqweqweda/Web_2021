<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
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
    	Context initCtx = new InitialContext();
    	Context envCtx = (Context)initCtx.lookup("java:comp/env");
    	DataSource ds = (DataSource)envCtx.lookup("jdbc/jylee");
    	Connection con = ds.getConnection();
    	
		//3. sql문
		String sql = "update board set bTag=?, bTitle=?, bString=? where bNo =?";
		
		//4 sql 실행
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, bTag);
		pstmt.setString(2, bTitle);
		pstmt.setString(3, bString);
		pstmt.setString(4, bNo);
		
		int i = pstmt.executeUpdate();
		
		//4. 연결 해체
		pstmt.close();
		con.close();
		
		response.sendRedirect("board.jsp");
	%>
