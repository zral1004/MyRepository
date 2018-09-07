package coin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import model.CoinDAO;
import model.CorpCoinDTO;

/**
 * Servlet implementation class setLast
 */
@WebServlet("/set.Last")
public class SetLastAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetLastAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		CoinDAO dao = CoinDAO.getInstance();
		CorpCoinDTO cd = new CorpCoinDTO();
		//ÄÚºø
		
		String[] kUrlArr= {"https://api.korbit.co.kr/v1/ticker?currency_pair=btc_krw",
											  "https://api.korbit.co.kr/v1/ticker?currency_pair=bch_krw",
											  "https://api.korbit.co.kr/v1/ticker?currency_pair=eth_krw",
											  "https://api.korbit.co.kr/v1/ticker?currency_pair=etc_krw",
											  "https://api.korbit.co.kr/v1/ticker?currency_pair=xrp_krw"};
        HttpURLConnection connection;
        String protocol="GET";
       BufferedReader bReader;
       JSONParser jsonParser = new JSONParser();
       
       for(int i=0;i<kUrlArr.length;i++) {
    	 URL url= new URL(kUrlArr[i]);
    	 connection =(HttpURLConnection)url.openConnection();
         connection.setRequestMethod(protocol);
         bReader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
         String json_shortcut = bReader.readLine();
       
         
         try {
			JSONObject object = (JSONObject) jsonParser.parse(json_shortcut);
			if(i==0) {
					cd.setKBTC(Integer.parseInt((String) object.get("last")));	
			}else if(i==1) {
					cd.setKBCH(Integer.parseInt((String) object.get("last")));
			}else if(i==2) {
					cd.setKETH(Integer.parseInt((String) object.get("last")));	
			}else if(i==3) {
					cd.setKETC(Integer.parseInt((String) object.get("last")));
			}else if(i==4) {
					cd.setKXRP(Integer.parseInt((String) object.get("last")));
			}			
			  
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
         
       }
       
       //ÄÚÀÎ¿ø
       
       
       URL url= new URL("https://api.coinone.co.kr/ticker?currency=all&format=json");
  	 connection =(HttpURLConnection)url.openConnection();
       connection.setRequestMethod(protocol);
       bReader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
       String json_shortcut2 = bReader.readLine();
       
       try {
		JSONObject object = (JSONObject) jsonParser.parse(json_shortcut2);
		String[] coinKind= {"btc", "bch", "eth", "etc", "xrp"};
		for(int i=0;i<coinKind.length;i++ ) {
			JSONObject object2=(JSONObject) object.get(coinKind[i]);
			if(i==0) {
				cd.setCBTC(Integer.parseInt((String) object2.get("last")));	
		}else if(i==1) {
				cd.setCBCH(Integer.parseInt((String) object2.get("last")));
		}else if(i==2) {
				cd.setCETH(Integer.parseInt((String) object2.get("last")));	
		}else if(i==3) {
				cd.setCETC(Integer.parseInt((String) object2.get("last")));
		}else if(i==4) {
				cd.setCXRP(Integer.parseInt((String) object2.get("last")));
		}		
		}

		
	} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
       
      //ºø½æ
       
       URL url2= new URL("https://api.bithumb.com/public/ticker/ALL");
    	 connection =(HttpURLConnection)url2.openConnection();
         connection.setRequestMethod(protocol);
         bReader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
         String json_shortcut3 = bReader.readLine();
         try {
			JSONObject object = (JSONObject) jsonParser.parse(json_shortcut3);
			String[] coinKind2= {"BTC", "BCH", "ETH", "ETC", "XRP"};
			JSONObject object2=(JSONObject) object.get("data");
			for(int i=0;i<coinKind2.length;i++ ) {
				
				JSONObject object3=(JSONObject) object2.get(coinKind2[i]);
				
			
			if(i==0) {
					cd.setBBTC(Integer.parseInt((String) object3.get("closing_price")));	
			}else if(i==1) {
					cd.setBBCH(Integer.parseInt((String) object3.get("closing_price")));
			}else if(i==2) {
					cd.setBETH(Integer.parseInt((String) object3.get("closing_price")));	
			}else if(i==3) {
					cd.setBETC(Integer.parseInt((String) object3.get("closing_price")));
			}else if(i==4) {
					cd.setBXRP(Integer.parseInt((String) object3.get("closing_price")));
			}		
				
			}
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
         dao.setLast(cd);
         PrintWriter out = response.getWriter();
         out.println('1');
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
