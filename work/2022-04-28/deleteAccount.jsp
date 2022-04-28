<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"  %>
    
<%	request.setCharacterEncoding("utf-8");

	Context initCtx = new InitialContext();
	Context envCtx = (Context)initCtx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/jylee");
	Connection con = ds.getConnection();

	//3. 생성된 연결을 통해 SQL문 실행 의뢰 준비
	String sql = "DELETE FROM LOGIN WHERE ID=?";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("id"));
	
	//5. SQL 실행
	int i = pstmt.executeUpdate();
	
	//6. 객체 해제
	pstmt.close();
	con.close();
%>
	
<script>
		let ans = alert("삭제되었습니다!");
		if (!ans){
			location.href='accountList.jsp';
		}
</script>
