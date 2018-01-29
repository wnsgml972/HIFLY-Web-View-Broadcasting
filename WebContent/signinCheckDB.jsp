<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="user.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	UserDAO userDAO = new UserDAO();
	UserDTO user = new UserDTO();
	String userID = request.getParameter("input_id");
	user = userDAO.search(userID);
	
	if (user.getUserID() != null) {
		out.println("오류");
	}
	
	if (user.getUserID() == null) {
		System.out.println("사용o");
		out.println("1");
		request.getSession().removeAttribute("ID");
		request.getSession().setAttribute("ID", userID);
	} else {
		out.println("2");
		System.out.println("사용x");
	}
	userDAO.end();
%>