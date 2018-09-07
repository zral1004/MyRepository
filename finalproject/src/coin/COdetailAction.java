package coin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 * Servlet implementation class COdetail
 */
@WebServlet("/CO.detail")
public class COdetailAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public COdetailAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=utf-8");
        String[] arr= {"first","last","low","high","volume","yesterday_volume","yesterday_first","yesterday_last","yesterday_high","yesterday_low"};
        String coin =(request.getParameter("coin")).toLowerCase();
        String bcoin=request.getParameter("coin");

        

        HttpURLConnection connection;
        String protocol="GET";
       BufferedReader bReader;
       String json_shortcut = null;
       URL url = new URL("https://api.coinone.co.kr/ticker?currency=all&format=json");
       /*URL url = new URL("https://api.bithumb.com/public/ticker/ALL");*/
       connection =(HttpURLConnection)url.openConnection();
       connection.setRequestMethod(protocol);
       bReader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
       json_shortcut = bReader.readLine();
       
       JSONParser jsonParser = new JSONParser();
       JSONObject jsonObj,jsonObj2;
       
       try {
		jsonObj = (JSONObject) jsonParser.parse(json_shortcut);
		jsonObj2 = (JSONObject) jsonObj.get(coin);
		double last= Integer.parseInt((String) jsonObj2.get("last")); 
		double yesterday_last=Integer.parseInt((String) jsonObj2.get("yesterday_last"));	
		double Nfluctate= last-yesterday_last;
		double Nfluctate_rate2=Nfluctate/yesterday_last*100;		
		double Nfluctate_rate = Double.parseDouble(String.format("%.2f",Nfluctate_rate2));
		String high = (String) jsonObj2.get("high");
		String low	= (String) jsonObj2.get("low");
		double volume =Math.round(Double.parseDouble((String) jsonObj2.get("volume")));
		
		
		String closing_24="  "+(int)Nfluctate+'('+Nfluctate_rate+"%)";
			request.setAttribute("closing_24", closing_24);
			request.setAttribute("closing_price", (int)last);
			request.setAttribute("max_price", high);
			request.setAttribute("min_price", low);
			//내림만 됨
			request.setAttribute("volume_1day",(int)volume);
			request.setAttribute("24H_fluctate", Nfluctate);
			if(Nfluctate>=0) {		
				request.setAttribute("checker", "red");
			}
		
		//호가
		BufferedReader bReader2;
		 String protocol2="GET";
		HttpURLConnection connection2;
		String json_shortcut2 = null;
		 URL url2 = new URL("https://api.coinone.co.kr/orderbook?currency="+coin+"&format=json");
	       connection2 =(HttpURLConnection)url2.openConnection();
	       connection2.setRequestMethod(protocol2);
	       bReader2 = new BufferedReader(new InputStreamReader(connection2.getInputStream(),"UTF-8"));
	      json_shortcut2 = bReader2.readLine();
	      JSONObject jsonObj3;
	      jsonObj3 = (JSONObject) jsonParser.parse(json_shortcut2);
	      JSONArray askArray = (JSONArray) jsonObj3.get("ask");
	      //안이 배열형식이라 어레이에넣어서 빼야함
	      for(int i=0 ; i<1 ; i++){
              JSONObject tempObj = (JSONObject) askArray.get(0);
              request.setAttribute("sell_price", tempObj.get("price"));
          }
	      JSONArray bidArray = (JSONArray) jsonObj3.get("bid");
	      for(int i=0 ; i<1 ; i++){
              JSONObject tempObj2 = (JSONObject) bidArray.get(0);
              request.setAttribute("buy_price", tempObj2.get("price"));
          }
	      request.setAttribute("corp", "코인원");
	      String coinName="";
			if(bcoin.equals("BTC")) {
				coinName="비트코인";
			}else if(bcoin.equals("BCH")) {
				coinName="비트코인캐시";
			}else if(bcoin.equals("ETH")) {
				coinName="이더리움";
			}else if(bcoin.equals("ETC")) {
				coinName="이더리움클래식";
			}else if(bcoin.equals("XRP")) {
				coinName="리플";
			}
			request.setAttribute("coinName", coinName);
			request.setAttribute("coin", bcoin);
	  	RequestDispatcher rd =request.getRequestDispatcher("tCurrentTop.jsp");
	    rd.forward(request, response);
	       

		
	} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
       
       
       
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
