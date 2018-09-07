package coin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import model.CoinDAO;
import model.CoinDTO;
import model.CorpCoinDTO;


/**
 * Servlet implementation class myInfor
 */
@WebServlet("/my.Infor")
public class MyInforAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyInforAction() {
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
		long moneyAmount=0;
		
		int corpN=Integer.parseInt(request.getParameter("corpN"));
		String corp= request.getParameter("corp");

		//현재 페이지 코인 수		
		String coin=request.getParameter("coin");
		
		
		HttpSession session=request.getSession();
		String userid=session.getAttribute("userid").toString();
			
		CoinDAO dao = CoinDAO.getInstance();
		ArrayList<CoinDTO> arr = dao.myAll(userid);
		CorpCoinDTO cd= new CorpCoinDTO();
		
		double coinAmount=0;
		if(coin.equals("BTC")) {
			coinAmount=arr.get(corpN).getBTC();	
			
		}else if(coin.equals("BCH")) {
			coinAmount=arr.get(corpN).getBCH();	
		}else if(coin.equals("ETH")) {
			coinAmount=arr.get(corpN).getETH();	
		}else if(coin.equals("ETC")) {
			coinAmount=arr.get(corpN).getETC();	
		}else if(coin.equals("XRP")) {
			coinAmount=arr.get(corpN).getXRP();	
		}
		
		
		double BTC=arr.get(corpN).getBTC();
		double BCH=arr.get(corpN).getBCH();
		double ETH=arr.get(corpN).getETH();
		double ETC=arr.get(corpN).getETC();
		double XRP=arr.get(corpN).getXRP();
		
		
		
		//원화(현금)
		moneyAmount=arr.get(0).getMoney();
		//자산(현금+코인)
		int asset=  dao.myAsset(userid); 

		PrintWriter out = response.getWriter();     
       JSONObject jobj = new JSONObject();

       jobj.put("moneyAmount", moneyAmount);
       jobj.put("asset", asset);
       jobj.put("coinAmount", coinAmount);
       
       jobj.put("BTC", BTC);
       jobj.put("BCH", BCH);
       jobj.put("ETH", ETH);
       jobj.put("ETC", ETC);
       jobj.put("XRP", XRP);
       
       out.println( jobj.toString());
       
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
