<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="java.sql.*" %>
<%	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");

 //DBCP로 변경
	Context initCtx = new InitialContext(); //JNDI를 사용하기 위한 객체 생성
	Context envCtx = (Context)initCtx.lookup("java:comp/env"); //등록된 JNDI 서비스로부터 자원을 검색
	DataSource ds = (DataSource)envCtx.lookup("jdbc/ParkCH"); //java:comp/env 영역에서 “jdbc/ParkCH”으로 설정된 이름의 DataSource 객체 획득
	Connection con = ds.getConnection(); //ds.getConnection()메소드를 사용해서 커넥션 풀로부터 커넥션 객체를 할당 받음
	

	//3. 생성된 연결을 통해 SQL문 실행 의뢰 준비
	String sql = "UPDATE LOGIN SET NAME=?, EMAIL=?, PWD=? WHERE ID=?";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, name);
	pstmt.setString(2, email);
	pstmt.setString(3, pwd);
	pstmt.setString(4, id);
	
	//4. SQL 실행
	int i = pstmt.executeUpdate();
	
	//5. 객체 해제
	pstmt.close();
	con.close();
	%>

	<script>
		let ans = alert("변경되었습니다!");
		if (!ans){
			location.href='accountList.jsp';
		}
	</script>
