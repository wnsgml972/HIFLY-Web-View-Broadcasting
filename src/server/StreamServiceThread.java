
package server;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

import group.GroupManagementDAO;
import group.GroupManagementDTO;

public class StreamServiceThread extends Thread {
	
	private Socket socket = null;
	private DataInputStream inputStream;
	private DataOutputStream outputStream;	
	
	public StreamServiceThread(Socket socket) {
		this.socket = socket;
		try {
			inputStream = new DataInputStream(socket.getInputStream());
			outputStream = new DataOutputStream(socket.getOutputStream());
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void run()
	{
		String data = "";
		
		while(true){
			
			try 
			{
				System.out.println("읽기전  (용석이 img_url)");
				
				data = inputStream.readUTF();
				
				System.out.println("data (용석이 img_url)  :  " + data + "\n\n");
				
				String twoData[] = data.split("&HIFLY&");
				
				System.out.println(twoData[0] + "       "   + twoData[1]);
				
				new Thread(new Runnable() {					
					@Override
					public void run()
					{
						/*
						 * 
						 * ffmpeg를 이용해 썸네일을 저장
						 */

						try {
							Thread.sleep(8000);
						
						List<String> commands = new ArrayList<String>();
						commands.add("C:\\ffmpeg\\bin\\ffmpeg.exe");
						commands.add("-i");
						commands.add(twoData[1]);
						commands.add("-r");
						commands.add("1");
						commands.add("-an");
						commands.add("-updatefirst");
						commands.add("1");
						commands.add("-y");

						commands.add("C:\\Users\\\"Kim Jun Hee\"\\git\\StreamingService\\StreamingService\\WebContent\\images\\thumnail" + twoData[0] + ".jpg");
						System.out.println("커멘드 다 지나감");

						ProcessBuilder pb = new ProcessBuilder(commands);
						pb.redirectErrorStream(true);
						Process ffmpeg =  pb.start();
						System.out.println("ffmpeg 프로세스 스타트");
						
						Thread.sleep(5000);
						ffmpeg.destroyForcibly();	
						
						GroupManagementDAO groupDAO = new GroupManagementDAO();
						GroupManagementDTO group = new GroupManagementDTO();
						groupDAO.updateImgURL(twoData[0], "images/thumnail" + twoData[0] + ".jpg");
						
						System.out.println("썸네일 등록 완료!");
						
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}).start();
				
				GroupManagementDAO groupDAO = new GroupManagementDAO();
				GroupManagementDTO group = new GroupManagementDTO();
				group = groupDAO.search(twoData[0]);
				System.out.println("스트림 스레드(앞부분) :  " + group.getUser_id());				
				groupDAO.updateURL(twoData[0], twoData[1]);	
				Main.powerHS.put(twoData[0], twoData[1]);
				
				
			} catch (Exception e)
			{				
				try{
					System.out.println("썸네일 스레드 종료");
					inputStream.close();
					outputStream.close();
					socket.close();
					return ;
				}catch(Exception e1){
					e1.printStackTrace();
				}
				
				System.out.println("왜 데이터가 null이 들어와서 나를 괴롭힐까");
				e.printStackTrace();
			}
		}
	}
	
	private String read() throws IOException
	{
		String data = "";
		data = inputStream.readUTF();
		return data;
	}
	private void write(String data)
	{
		try {
			outputStream.writeUTF(data);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
