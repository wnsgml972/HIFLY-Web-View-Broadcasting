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
	String sql = "select distinct movie from theater where theaterName=?";

	pstmt = conn.prepareStatement(sql);

	// select 를 수행하면 데이터정보가 ResultSet 클래스의 인스턴스로 리턴됨.
	String theaterName = request.getParameter("theaterName");
	
	pstmt.setString(1, theaterName);
	System.out.println(theaterName);
	ResultSet rs = pstmt.executeQuery();	
	if(rs.next()){
		String getMovieName = rs.getString("movie");		
		if(getMovieName == null){
			System.out.println("영화없음");
			out.println("2");			
		}		
		else{
			System.out.println("영화있음");
			System.out.println(getMovieName);
			out.println(getMovieName);
			while(rs.next()){
				getMovieName = rs.getString("movie");				
				out.println("&" + getMovieName);
				System.out.println(getMovieName);
			}
		}
	}
	else{
		System.out.println("영화없음");
		out.println("2");		
	}	
	rs.close();
	pstmt.close();
	conn.close();
%>