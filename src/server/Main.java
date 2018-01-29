
package server;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;

public class Main
{
	private ServerSocket serverSocket = null;
	private Socket socket = null;
	
	private ServerSocket streamServerSocket = null;
	private Socket streamSocket = null;
	
	public static HashMap<String, String> powerHS = new HashMap<String, String>();
	
	public Main() {
		init();
		messageReceiver mthread = new messageReceiver();
		streamReceiver sthread = new streamReceiver();
		
		mthread.start();
		sthread.start();
		
		System.out.println("서버 시작!");
		
	}

	public void init()
	{
		try {
			serverSocket = new ServerSocket(20170);
			streamServerSocket = new ServerSocket(12329);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	class messageReceiver extends Thread
	{
		public void run() {
			while (true) {
				try {
					System.out.println("메시지 대기중!");
					socket = serverSocket.accept();

					System.out.println(socket.getInetAddress() + "  " + socket.getLocalAddress() + "접속!");

					ServiceThread sc = new ServiceThread(socket);
					sc.start();

				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	class streamReceiver extends Thread
	{
		public void run() {
			while (true) {
				try {
					System.out.println("스트림 대기중!");
					streamSocket = streamServerSocket.accept();

					System.out.println(streamSocket.getInetAddress() + "  " + streamSocket.getLocalAddress() + "접속!");

					StreamServiceThread sc = new StreamServiceThread(streamSocket);
					sc.start();

				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public static void main(String[] args) {
		new Main();
	}
}