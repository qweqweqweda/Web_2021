<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"%>
    
   <%  
    request.setCharacterEncoding("UTF-8");
	//클라이언트에서 전달된 데이터
	String bNo = request.getParameter("bNo");
	
	//DBCP로 변경
	Context initCtx = new InitialContext();
	Context envCtx = (Context)initCtx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/jylee");
	Connection con = ds.getConnection();
	
	//3. sql문
	String sql = "select * from board where bNo=?";
	
	//4 sql 실행
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, bNo);
	
	ResultSet rs = pstmt.executeQuery();
	
	String bTag = "";
	String bTitle= "";
	String bString = "";
	
	if(rs.next()){
		bTag = rs.getString("bTag");
		bTitle = rs.getString("bTitle");
		bString = rs.getString("bString");
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
	
</head>
<body>
	<div>
		<br>
		<h2>  <%=bTag %> </h2>
		<hr/>
		      <%=bTitle %> <br>
		      <%=bString %> <br>
		    <br>
		    <div class="text-center">
				<button type="button" onclick="location.href='updateForm.jsp?bNo=<%=bNo%>'">수정</button>
				<button type="button" onclick="location.href='deleteForm.jsp?bNo=<%=bNo%>'">삭제</button> <!-- type button 쓰기 -->
				<button type="button" onclick="location.href='board.jsp'">조회</button>
			</div>
		</form>
	
	</div>
</body>
</html>
