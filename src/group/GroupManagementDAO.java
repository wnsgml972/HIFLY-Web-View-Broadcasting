package group;

import java.sql.*;
import java.util.Vector;

//User Database Assess Object
public class GroupManagementDAO 
{
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public GroupManagementDAO()
	{
	    String jdbc_driver = "com.mysql.jdbc.Driver";
	    String jdbc_url = "jdbc:mysql://127.0.0.1/drone_user";
		String user = "root";
		String password = "1234";
		
		try {
			// JDBC 드라이버 로드
			Class.forName(jdbc_driver);
			// 데이터베이스 연결정보를 이용해 Connection 인스턴스 확보
			conn = DriverManager.getConnection(jdbc_url, user, password);

		} catch (Exception e) 
		{
			System.out.println(e);
		}
	}
		
	public void makeRoom(String title, String description, String user_id
			, String room_password, String password_check, String URL, String image_url)
	{
		String sql = "insert into `group`(title, room_password, description, user_id, password_check, URL, image_url) values(?,?,?,?,?,?,?)";
		
		System.out.println("make room 들어옴!");
		// select 를 수행하면 데이터정보가 ResultSet 클래스의 인스턴스로 리턴됨.		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, room_password);
			pstmt.setString(3, description);
			pstmt.setString(4, user_id);
			pstmt.setString(5, password_check);
			pstmt.setString(6, URL);
			pstmt.setString(7, image_url);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("성공");
	}
	public void deleteRoom(String group_id)
	{
		String sql = "delete from `group` where group_id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, group_id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void deleteRoomUser(String user_id)
	{
		String sql = "delete from `group` where user_id = ?";		
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateImgURL(String user_id, String img)
	{
		String sql = "update `group` set image_url=? where user_id = ?";		
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, img);
			pstmt.setString(2, user_id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void updateURL(String user_id, String url)
	{
		String sql = "update `group` set URL=? where user_id = ?";		
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, url);
			pstmt.setString(2, user_id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public GroupManagementDTO search(int group_id)
	{
		String sql = "select * from `group` where group_id = ?";
		GroupManagementDTO group = new GroupManagementDTO();
		
		// select 를 수행하면 데이터정보가 ResultSet 클래스의 인스턴스로 리턴됨.
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, group_id);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				group.setGroup_id(Integer.toString(rs.getInt("group_id")));
				group.setTitle(rs.getString("title"));
				group.setDescription(rs.getString("description"));
				group.setUser_id(rs.getString("user_id"));
				group.setRoom_password(rs.getString("room_password"));
				group.setPassword_check(rs.getString("password_check"));
				group.setURL(rs.getString("URL"));
				group.setImage_url(rs.getString("image_url"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return group;
	}
	public GroupManagementDTO search(String user_id)
	{
		String sql = "select * from `group` where user_id = ?";
		GroupManagementDTO group = new GroupManagementDTO();
		
		// select 를 수행하면 데이터정보가 ResultSet 클래스의 인스턴스로 리턴됨.
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				group.setGroup_id(Integer.toString(rs.getInt("group_id")));
				group.setTitle(rs.getString("title"));
				group.setDescription(rs.getString("description"));
				group.setUser_id(rs.getString("user_id"));
				group.setRoom_password(rs.getString("room_password"));
				group.setPassword_check(rs.getString("password_check"));
				group.setURL(rs.getString("URL"));
				group.setImage_url(rs.getString("image_url"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return group;
	}
	
	public Vector<GroupManagementDTO> getAllGroup()
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	    String jdbc_driver = "com.mysql.jdbc.Driver";
	    String jdbc_url = "jdbc:mysql://127.0.0.1/drone_user";
		String user = "root";
		String password = "1234";
		
		try {
			// JDBC 드라이버 로드
			Class.forName(jdbc_driver);
			// 데이터베이스 연결정보를 이용해 Connection 인스턴스 확보
			conn = DriverManager.getConnection(jdbc_url, user, password);

		} catch (Exception e) 
		{
			System.out.println(e);
		}
		
		Vector<GroupManagementDTO> vector = new Vector<GroupManagementDTO>();
		String sql = "select * from `group`";
		
		// select 를 수행하면 데이터정보가 ResultSet 클래스의 인스턴스로 리턴됨.
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next())
			{
				vector.add(search(rs.getInt("group_id")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return vector;
	}
	
	public void end()
	{
		try {
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
