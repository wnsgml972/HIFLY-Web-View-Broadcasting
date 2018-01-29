package user;

public class UserDTO 
{
	private String userID;
	private String userPW;
	private String email;
	private String loginCheck;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getPassword() {
		return userPW;
	}
	public void setPassword(String userPW) {
		this.userPW = userPW;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String loginCheck() {
		return loginCheck;
	}
	public void loginCheck(String loginCheck) {
		this.loginCheck = loginCheck;
	}
}
