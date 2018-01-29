<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	Connection conn = null;
	PreparedStatement pstmt = null;
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://127.0.0.1/jspdb";
	String db_id = "root";
	String db_pw = "1234";
	Class.forName(jdbc_driver);

	conn = DriverManager.getConnection(jdbc_url, db_id, db_pw);
	String sql = "insert into user values(?,?,?)";

	pstmt = conn.prepareStatement(sql);

	// select 를 수행하면 데이터정보가 ResultSet 클래스의 인스턴스로 리턴됨.				
	String userID = (String) request.getSession().getAttribute("ID");
	String getID = request.getParameter("input_id");
	System.out.println(userID + " " + getID);
	if (userID == null || getID == null) {
		out.println("1");
	} else if (userID.equals(getID)) {
		String userPW = request.getParameter("input_pw");
		String user_email = request.getParameter("input_email");
		if (userPW.length() < 5) {
			out.println("2");
		} else {
			pstmt.setString(1, userID);
			pstmt.setString(2, userPW);
			pstmt.setString(3, user_email);
			session.setAttribute("userID", userID);
			pstmt.executeUpdate();
			out.clear();
			out.println("3");
		}
	} else {
		System.out.println("세션없음");
		out.println("1");

	}	
	pstmt.close();
	conn.close();
%>