
package server;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;

import group.GroupManagementDAO;
import group.GroupManagementDTO;
import user.*;

public class ServiceThread extends Thread {
	private Socket socket = null;
	private BufferedReader in = null;
	private BufferedWriter out = null;
	private JsonParser jsonparser = new JsonParser();

	private String user_id;
	public static int checkTime = 0;
	
	public ServiceThread(Socket socket) {
		this.socket = socket;
		try {

			in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			out = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void run()
	{
		String data = "";
		user_id = null;

		
		//polling 유지!
		new Thread(new Runnable() {
			
			@Override
			public void run() {

				try {
					while(true){
						
						System.out.println(checkTime + "@@@@@@@@@@@@@");
						checkTime++;
						Thread.sleep(1000);
						
						if(checkTime == 10)
						{
							if(user_id != null)
							{
								//user 로그아웃 시키기
								UserDAO userDAO = new UserDAO();
								System.out.println(user_id);
								userDAO.logout(user_id);
								
								//방 남아있다면 삭제
								GroupManagementDAO groupDAO = new GroupManagementDAO();
								groupDAO.deleteRoomUser(user_id);
							}
							return;
						}
					}
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}								

			}
		}).start();
		
		while(true){			
			try 
			{
				System.out.println("읽기전");

				data = read();
				System.out.println("data  :  " + data + "\n\n");
				
				if(data.contains("HIFLY"))
				{
					if(data.contains("HIFLYgroup")){
						System.out.println("json 함수 들어옴");
						jsonGroup(data);
						
						System.out.println("json  끝 난 후  ID" + user_id);
						
					}
					else if(data.contains("HIFLYlogincheck")){
						loginCheck(data);
					}
					else if(data.contains("HIFLYsignup")){
						signUp(data);
					}
					else if(data.contains("HIFLYstop")){
						stop(data);
					}
					else if(data.contains("HIFLYlogout")){
						logout(data);
					}
					else if(data.contains("HIFLYpolling")){
						checkTime = 0 ;
					}
				}
				
				new Thread(new Runnable() {
					
					@Override
					public void run() {
						while(true){
							try {
								//System.out.println("쓰레드 연결 확인중~~~~  " + user_id);
								if(socket.isClosed())
								{
									if(user_id != null)
									{
										//user 로그아웃 시키기
										UserDAO userDAO = new UserDAO();
										System.out.println(user_id);
										userDAO.logout(user_id);
										
										//방 남아있다면 삭제
										GroupManagementDAO groupDAO = new GroupManagementDAO();
										groupDAO.deleteRoomUser(user_id);
									}
									System.out.println("쓰레드 연결 확인 종료");
									return;
								}
								Thread.sleep(3000);
							} catch (InterruptedException e) {
								System.out.println("접속 끊김");
								e.printStackTrace();
							}
						}
					}
				}).start();

				
			} catch (Exception e)
			{
				try{
					in.close();
					out.close();
					socket.close();
					
					System.out.println(user_id);
					
					if(user_id != null)
					{
						//user 로그아웃 시키기
						UserDAO userDAO = new UserDAO();
						System.out.println(user_id);
						userDAO.logout(user_id);
						
						//방 남아있다면 삭제
						GroupManagementDAO groupDAO = new GroupManagementDAO();
						groupDAO.deleteRoomUser(user_id);
					}
					
					System.out.println("접속자 끊어짐");
					return;
				}catch(Exception e1){
					e1.printStackTrace();
				}
				e.printStackTrace();
			}
		}
	}
	
	private String read() throws IOException
	{
		String data = "";

		data = in.readLine();
		return data;
	}
	private void write(String data)
	{
		try {
			out.write(data + "\n");
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	private void loginCheck(String data) throws IOException
	{
		String []temp = data.split("&");
		String userID = temp[1].substring(9, temp[1].length());
		String userPW = temp[2].substring(9, temp[2].length());
		UserDAO userDAO = new UserDAO();
		UserDTO user = userDAO.search(userID);

		System.out.println(userID + "   "  + userPW);
		
		if(user.getUserID() != null)
		{
			user = userDAO.search(userID, userPW);
			
			if(user.getUserID() == null)
			{
				System.out.println("111");
				write("HIFLYlogincheck&nopassword");
			}
			else if(user.getUserID().equals(userID) && user.getPassword().equals(userPW)){
				System.out.println("222");
				write("HIFLYlogincheck&ok");

				userDAO.login(user.getUserID());
				System.out.print("로그인 성공");
				user_id = userID;
			}
			else{
				System.out.println("333");
				write("HIFLYlogincheck&nopassword");
			}
		}
		else
		{
			System.out.println("444");
			write("HIFLYlogincheck&noid");
		}
		userDAO.end();
	}
	
	private void jsonGroup(String data) throws Exception
	{
		boolean check = false;
		
		data = data.substring(11, data.length());
		System.out.println(data);
		check = jsonparser.writeGroupDatabase(data);	//성공하면 true
		user_id = jsonparser.jsonGetUser_ID(data);
		
		System.out.println("parser 후 user_id" + user_id);
		
		if(check)
		{
			System.out.println("jsonparser 성공");
			write("HIFLYgroup&ok");
		}
		else
		{
			System.out.println("jsonparser 실패");
			write("HIFLYgroup&no");
		}
	}
	
	private void signUp(String data) throws IOException
	{
		String []temp = data.split("&");
		String userID = temp[1].substring(9, temp[1].length());
		String userPW = temp[2].substring(9, temp[2].length());
		String email = temp[3].substring(12, temp[3].length());

		UserDAO userDAO = new UserDAO();
		UserDTO user = userDAO.search(userID);		
		System.out.println(userID + "   "  + userPW +  "   " +email);
		
		if(user.getUserID() != null)
		{
			System.out.println("111 회원가입 실패");
			write("HIFLYsignup&id");
		}
		else
		{
			System.out.println("222 회원가입 성공");				
			userDAO.signin(userID, userPW, email);
			write("HIFLYsignup&ok");
		}
		userDAO.end();
	}
	
	private void stop(String data) throws IOException
	{
		System.out.println(data);
		String []temp = data.split("&");
		
		String id = temp[1];
		GroupManagementDAO groupDAO = new GroupManagementDAO();
		System.out.println(id);
		groupDAO.deleteRoomUser(id);
		
		System.out.println("삭제 성공");
	}
	private void logout(String data) throws IOException
	{
		System.out.println(data);
		String []temp = data.split("&");
		
		String id = temp[1];
		UserDAO userDAO = new UserDAO();
		System.out.println(id);
		userDAO.logout(id);
		
		System.out.println("로그아웃 성공");
	}
}
