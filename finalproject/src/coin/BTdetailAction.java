package coin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
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
 * Servlet implementation class BTdetail
 */
@WebServlet("/BT.detail")
public class BTdetailAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BTdetailAction() {
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
        String[] arr= {"opening_price","closing_price","min_price","max_price","average_price","units_traded","volume_7day","buy_price","sell_price","24H_fluctate_rate"};
        String coin =request.getParameter("coin");
        
       HttpURLConnection connection;
       String protocol="GET";
       BufferedReader bReader;
       String json_shortcut = null;
       URL url = new URL("https://api.bithumb.com/public/ticker/ALL");
       connection =(HttpURLConnection)url.openConnection();
       connection.setRequestMethod(protocol);
       bReader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
       json_shortcut = bReader.readLine();
       
       
       JSONParser jsonParser = new JSONParser();
       JSONObject jsonObj,jsonObj2,jsonObj3;
       
	try {
		/*jsonObj = (JSONObject) jsonParser.parse(json_shortcut);*/
		jsonObj = (JSONObject) jsonParser.parse(json_shortcut);
		jsonObj2 = (JSONObject) jsonObj.get("data");
		jsonObj3 = (JSONObject) jsonObj2.get(coin);
		double volume_1day =Math.round(Double.parseDouble((String) jsonObj3.get("volume_1day"))) ;
		request.setAttribute("volume_1day", (int)volume_1day);
		long N24H_fluctate2=(long)jsonObj3.get("24H_fluctate");

		if(N24H_fluctate2>=0) {		
			request.setAttribute("checker", "red");
		}
		
		String closing_24=" "+jsonObj3.get("24H_fluctate")+'('+jsonObj3.get("24H_fluctate_rate")+"%)";
		for(int i=0;i<arr.length;i++) {
			request.setAttribute(arr[i],jsonObj3.get(arr[i]));
		}
		request.setAttribute("closing_24",closing_24);
		request.setAttribute("coin", coin);
		String coinName="";
		if(coin.equals("BTC")) {
			coinName="비트코인";
		}else if(coin.equals("BCH")) {
			coinName="비트코인캐시";
		}else if(coin.equals("ETH")) {
			coinName="이더리움";
		}else if(coin.equals("ETC")) {
			coinName="이더리움클래식";
		}else if(coin.equals("XRP")) {
			coinName="리플";
		}
		request.setAttribute("coinName", coinName);
		request.setAttribute("corp", "빗썸");
		   
	       
	} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	RequestDispatcher rd =request.getRequestDispatcher("tCurrentTop.jsp");
    rd.forward(request, response);
       
    
       
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
