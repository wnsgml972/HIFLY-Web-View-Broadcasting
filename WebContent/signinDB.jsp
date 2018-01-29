<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page import="user.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	UserDAO userDAO = new UserDAO();
	UserDTO user = new UserDTO();

	String userID = request.getParameter("input_id");
	String userPW = request.getParameter("input_pw");
	String user_email = request.getParameter("input_email");
	
	user = userDAO.search(userID);
	
	if(user.getUserID() != null)
	{
		out.println("1");
	}
	else if(user.getUserID() == null)
	{		
		if (userPW.length() < 5) 
		{
			out.println("2");
		}
		else
		{
			userDAO.signin(userID, userPW, user_email); //DB 회원가입 하는 부분			
			session.setAttribute("userID", userID);
			out.clear();
			out.println("3");
		}
	}
	userDAO.end();
%>