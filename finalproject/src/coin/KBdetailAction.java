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
 * Servlet implementation class KorDetail
 */
@WebServlet("/KB.detail")
public class KBdetailAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public KBdetailAction() {
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
        String coin =(request.getParameter("coin")).toLowerCase();
        String bcoin=request.getParameter("coin");
       
       HttpURLConnection connection;
       String protocol="GET";
      BufferedReader bReader;
      String json_shortcut = null;
      URL url = new URL("https://api.korbit.co.kr/v1/ticker/detailed?currency_pair="+coin+"_krw");
      connection =(HttpURLConnection)url.openConnection();
      connection.setRequestMethod(protocol);
      bReader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
      json_shortcut = bReader.readLine();
      JSONParser jsonParser = new JSONParser();
      JSONObject jsonObj;
      try {
		jsonObj = (JSONObject) jsonParser.parse(json_shortcut);
		String last=(String) jsonObj.get("last");//���簡
		String high=(String) jsonObj.get("high");//�ְ�
		String low=(String) jsonObj.get("low");//������
		String ask=(String) jsonObj.get("ask");//�ŵ�ȣ��
		String bid=(String) jsonObj.get("bid");//�ż�ȣ��
		double volume =Math.round(Double.parseDouble((String) jsonObj.get("volume")));//�ŷ���(�ݿø�)
		double Nchange=Integer.parseInt((String) jsonObj.get("change"));//24�ð� ���ݺ�ȭ��	
		double Nlast=Integer.parseInt((String) jsonObj.get("last"));//������� ���簡�� ���ڷ�
		double Nfluctate_rate2=Nchange/(Nchange+Nlast)*100;//24�ð� ���ݺ�ȭ��		
		double Nfluctate_rate = Double.parseDouble(String.format("%.2f",Nfluctate_rate2));//�Ҽ��� 2�ڸ�����
		String closing_24=" "+(int)Nchange+'('+Nfluctate_rate+"%)";
		request.setAttribute("closing_price", last);
		request.setAttribute("max_price", high);
		request.setAttribute("min_price", low);
		request.setAttribute("sell_price", ask);
		request.setAttribute("buy_price", bid);
		request.setAttribute("volume_1day", (int)volume);
		request.setAttribute("closing_24", closing_24);
		
		request.setAttribute("24H_fluctate", Nchange);
		
		if(Nchange>=0) {		
			request.setAttribute("checker", "red");
		}
	    
		String coinName="";
			if(bcoin.equals("BTC")) {
				coinName="��Ʈ����";
			}else if(bcoin.equals("BCH")) {
				coinName="��Ʈ����ĳ��";
			}else if(bcoin.equals("ETH")) {
				coinName="�̴�����";
			}else if(bcoin.equals("ETC")) {
				coinName="�̴�����Ŭ����";
			}else if(bcoin.equals("XRP")) {
				coinName="����";
			}
			request.setAttribute("coinName", coinName);
			request.setAttribute("coin", bcoin);
			request.setAttribute("corp", "�ں�");
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
