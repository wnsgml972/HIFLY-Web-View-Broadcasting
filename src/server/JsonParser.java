package server;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import group.GroupManagementDAO;
import group.GroupManagementDTO;

public class JsonParser {

	private String testJsonInfo = "{\"books\":[{\"genre\":\"소설\",\"price\":\"100\",\"name\":\"사람은 무엇으로 사는가?\",\"writer\":\"톨스토이\",\"publisher\":\"톨스토이 출판사\"},{\"genre\":\"소설\",\"price\":\"300\",\"name\":\"홍길동전\",\"writer\":\"허균\",\"publisher\":\"허균 출판사\"},{\"genre\":\"소설\",\"price\":\"900\",\"name\":\"레미제라블\",\"writer\":\"빅토르 위고\",\"publisher\":\"빅토르 위고 출판사\"}],\"persons\":[{\"nickname\":\"남궁민수\",\"age\":\"25\",\"name\":\"송강호\",\"gender\":\"남자\"},{\"nickname\":\"예니콜\",\"age\":\"21\",\"name\":\"전지현\",\"gender\":\"여자\"}]}";
	private JSONParser jsonParser;
	
	public JsonParser()
	{
		jsonParser = new JSONParser();
	}
	
	
	public boolean writeGroupDatabase(String jsonInfo)
	{
		JSONObject jsonObject = null;
		JSONArray groupInfoArray = null;
		GroupManagementDAO groupDAO = new GroupManagementDAO();
				
		try {
			jsonObject = (JSONObject) jsonParser.parse(jsonInfo);
			
			// room의 배열을 추출
			groupInfoArray = (JSONArray) jsonObject.get("group");
			
			System.out.println("* group *");
			for (int i = 0; i < groupInfoArray.size(); i++) {
				//하지만 항상 하나밖에 없음
				// 배열 안에 있는것도 JSON형식 이기 때문에 JSON Object 로 추출
				JSONObject groupObject = (JSONObject) groupInfoArray.get(i);	//첫번째 꺼 부터 json형태의 room 객체 받음
				
				//여기서 데이터 베이스에 삽입하면됨
				//객체 형태로 날라옴 그냥 데이터베이스 클래스 만든거 써서 넣기만 하면됨
				if(!groupObject.get("URL").toString().equals("NULL"))
				{	
					groupDAO.makeRoom(groupObject.get("title").toString(), groupObject.get("description").toString(),
						groupObject.get("user_id").toString(), groupObject.get("room_password").toString(),
						groupObject.get("password_check").toString(), groupObject.get("URL").toString(), 
						groupObject.get("image_url").toString());
				}
				else {
					System.out.println("스트림 스레드(뒷부분) :  " + groupObject.get("user_id").toString());
					groupDAO.makeRoom(groupObject.get("title").toString(), groupObject.get("description").toString(),
							groupObject.get("user_id").toString(), groupObject.get("room_password").toString(),
							groupObject.get("password_check").toString(), Main.powerHS.get(groupObject.get("user_id").toString()), 
							groupObject.get("image_url").toString());
				}
			}
		
		} catch (ParseException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public String jsonGetUser_ID(String jsonInfo)
	{
		JSONObject jsonObject = null;
		JSONArray groupInfoArray = null;
		String id = null;
		
		try {
			jsonObject = (JSONObject) jsonParser.parse(jsonInfo);
			
			// room의 배열을 추출
			groupInfoArray = (JSONArray) jsonObject.get("group");
			for (int i = 0; i < groupInfoArray.size(); i++) {
				//하지만 항상 하나밖에 없음
				// 배열 안에 있는것도 JSON형식 이기 때문에 JSON Object 로 추출
				JSONObject groupObject = (JSONObject) groupInfoArray.get(i);	
				id = groupObject.get("user_id").toString();
			}
		} catch (ParseException e) {
			e.printStackTrace();

		}
		return id;
	}
}
