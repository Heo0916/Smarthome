<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.json.simple.JSONObject"%>

<%
    //커넥션 선언
    Connection con = null;
    try {
        //드라이버 호출, 커넥션 연결
        Class.forName("org.mariadb.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mariadb://10.100.111.84:3306/home","root","1234");
 
        //ResultSet : 쿼리문에 대한 반환값
        ResultSet rs = null;
 
        //DB에서 뽑아온 데이터(JSON) 을 담을 객체. 후에 responseObj에 담기는 값
        List dustlist = new LinkedList();
 
      
 
        String query = "select DATE_FORMAT(a.date, '%Y-%m-%d %H:00:00') date, avg(dust1) as dust1, avg(dust2) as dust2, avg(temp) as temp, avg(hum) as hum, avg(co) as co from air as a where date and DATE_FORMAT(a.date,'%Y-%m-%d %H:00')=DATE_FORMAT(a.date,'%Y-%m-%d %H:00') group by DATE_FORMAT(a.date,'%Y-%m-%d %H:00')";
        PreparedStatement pstm = con.prepareStatement(query);
 
        rs = pstm.executeQuery();
        
        //ajax에 반환할 JSON 생성
        JSONObject responseObj = new JSONObject();
        JSONObject lineObj = null;
        
        //소수점 2번째 이하로 자름
        DecimalFormat f1 = new DecimalFormat("");
        //rs의 다음값이 존재할 경우
        while(rs.next()){
     	String date = rs.getString("date");

    	float dust1 = rs.getFloat("dust1");

    	float dust2 = rs.getFloat("dust2");

    	float temp = rs.getFloat("temp");

    	float hum = rs.getFloat("hum");
    	
    	float co = rs.getFloat("co");

 		lineObj = new JSONObject();

    	lineObj.put("date", date);

    	lineObj.put("dust1", (int)dust1);

    	lineObj.put("dust2", (int)dust2);

    	lineObj.put("temp", (int)temp);

    	lineObj.put("hum", (int)hum);
    	
    	lineObj.put("co", (int)co);

    	dustlist.add(lineObj);

	} 


	
	responseObj.put("dustlist", dustlist);

	out.print(responseObj.toString());

	} catch (Exception e) {

	e.printStackTrace();

	} finally {

	if (con != null) {

    try {

        con.close();

    } catch (Exception e) {

        e.printStackTrace();

    }

	}



	}

	%>
