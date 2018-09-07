package coin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 * Servlet implementation class korbit
 */
@WebServlet("/korbit.do")
public class KorbitChartAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public KorbitChartAction() {
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
       
        HttpURLConnection connection;
        String protocol="GET";
       BufferedReader bReader;
       JSONArray jarr = new JSONArray();
       JSONObject json =null;
       String json_shortcut = null;
       URL url = new URL(request.getParameter("cUrl"));
       connection =(HttpURLConnection)url.openConnection();
       connection.setRequestMethod(protocol);
       bReader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
       json_shortcut = bReader.readLine();
       PrintWriter out = response.getWriter();
       out.println(json_shortcut);
        
        /*String[] arr = {"https://api.korbit.co.kr/v1/ticker?currency_pair=btc_krw",
        							 "https://api.korbit.co.kr/v1/ticker?currency_pair=eth_krw",
        							 "https://api.korbit.co.kr/v1/ticker?currency_pair=xrp_krw"};
        HttpURLConnection connection;
        String protocol="GET";
       BufferedReader bReader;
       JSONArray jarr = new JSONArray();
       JSONObject json =null;
       String json_shortcut = null;
       for(int i=0;i<arr.length;i++) {
	        URL url = new URL(arr[i]);
	        connection =(HttpURLConnection)url.openConnection();
	        connection.setRequestMethod(protocol);
	        bReader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
	        json_shortcut = bReader.readLine();
	   
	        
	        JSONParser parser = new JSONParser();
	       try {
			JSONObject object = (JSONObject)parser.parse(json_shortcut);
	         json = new JSONObject();
	       System.out.println("object : " + object);
	       System.out.println("object  last: " + object.get(i));
	      //  json.put("data", json_shortcut);
	        jarr.add(json_shortcut);
	        json.put("data", jarr);
	    //    System.out.println(jarr);
	        
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	        
       }
       PrintWriter out = response.getWriter();
       out.println(json.toString());*/
        
/*        InputStream in = url.openStream();
        CachedOutputStream bos = new CachedOutputStream();
        IOUtils.copy(in, bos);
        in.close();
        bos.close();
        String data = bos.getOut().toString();    
        PrintWriter out = response.getWriter();
        out.println(data);
         
        JSONObject json = new JSONObject();
        json.put("data", data);*/
       
        }
		
		


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
