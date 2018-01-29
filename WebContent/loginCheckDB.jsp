<%@ page import="java.sql.*"%>
<%@ page import="user.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%	
	String userID = request.getParameter("input_id");
	String userPW = request.getParameter("input_pw");
	
	UserDAO userDAO = new UserDAO();
	UserDTO user = userDAO.search(userID, userPW);

	System.out.println(userID + "   "  + userPW);
	
	if(user != null)
	{
		if(user.getUserID() == null)
		{
			out.println("2");
		}
		else if(user.getUserID().equals(userID)){
			out.println("1");
			session.setAttribute("signedUser", userID); 

			System.out.print("실행");
		}
		else{
			out.println("2");
		}
	}
	else
	{
		out.println("2");
	}
	userDAO.end();
%>