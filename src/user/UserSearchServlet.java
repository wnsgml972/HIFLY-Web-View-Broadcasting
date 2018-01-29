package user;


import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;


/*
 * 이제 웹의 인덱스 페이지에서 이러한 서블릿을 요청할 수 있도록 구현해야 함!
 */

/*
 * Servlet implementation class UserSearchServlet
 */
@WebServlet("/UserSearchServlet")
public class UserSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UserSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

/*	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");		
		String userID = request.getParameter("userID");	
		
		//사용자가 입력한 검색 정보를 토대로 JSON 형태로 출력해서 보여줌    -> 그것이 이 서블릿이 하는 역활!
		response.getWriter().write(getJSON(userID));
	}*/
	
	public String getJSON(String userID)
	{
		if(userID == null) userID = "";
		 

		UserDAO userDAO = new UserDAO();
		
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		
/*		ArrayList<UserDTO> userList = userDAO.search("userID");
		for(int i=0; i<userList.size(); i++)
		{
			result.append("[{\"value\": \"" + userList.get(i).getUserID() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getPassword() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getDroneID() + "\"}],");
		}*/
		result.append("]}");
		return result.toString();
	}
}
