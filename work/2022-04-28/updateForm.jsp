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
	Context initCtx = new InitialContext(); //JNDI를 사용하기 위한 객체 생성
	Context envCtx = (Context)initCtx.lookup("java:comp/env"); //등록된 JNDI 서비스로부터 자원을 검색
	DataSource ds = (DataSource)envCtx.lookup("jdbc/ParkCH"); //java:comp/env 영역에서 “jdbc/ParkCH”으로 설정된 이름의 DataSource 객체 획득
	Connection con = ds.getConnection(); //ds.getConnection()메소드를 사용해서 커넥션 풀로부터 커넥션 객체를 할당 받음
	

	
	//3. sql문
	String sql = "select * from board where bNo=?";
	
	//4 sql 실행
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, bNo);
	
	ResultSet rs = pstmt.executeQuery();
	
	String bTag = "";
	String bString = "";
	String bTitle = "";
	
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
		<h2>수정</h2>
		<hr/>
		
		<form action="updatePro.jsp" method="post">
		      <select name = "bTag"> 
				<option value = "선택">선택</option>
				<option value = "자유게시판">자유게시판</option>
				<option value = "후기게시판">후기게시판</option>
				<option value = "질문게시판">질문게시판</option>
			  </select><br>
			  <input type ="hidden" name = "bNo" value = "<%=bNo %>"><br>
		      <input type="text" name="bTitle" value ="<%=bTitle %>"><br>
		      <textarea name = "bString" cols='100' rows='15'><%=bString %></textarea>
		    <br>
		    <div class="text-center">
				<input type="submit" value="변경저장">
				<button type="button" onclick="location.href='deleteForm.jsp?id=<%=bNo%>'">삭제</button> <!-- type button 쓰기 -->
				<button type="button" onclick="location.href='list.jsp'">조회</button>
			</div>
		</form>
	
	</div>
</body>
</html>
