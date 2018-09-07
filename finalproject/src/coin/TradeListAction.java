package coin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.CoinDAO;
import model.TradeDTO;

/**
 * Servlet implementation class tradeList
 */
@WebServlet("/trade.List")
public class TradeListAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TradeListAction() {
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
		HttpSession session=request.getSession();
		String userid=session.getAttribute("userid").toString();
		String corp=request.getParameter("corp");
		String coin=request.getParameter("coin");
		 JSONArray jarr = new JSONArray();
		CoinDAO dao = CoinDAO.getInstance();
	    ArrayList<TradeDTO> tarr=  dao.tradeList(userid, corp, coin);
	   for(TradeDTO d : tarr) {
	    JSONObject jobj = new JSONObject();   
		jobj.put("tradedate", d.getTradedate());
		jobj.put("allprice", d.getAllprice());
		jobj.put("buy_sell", d.getBuy_sell());
		jobj.put("lastprice", d.getLastprice());
		jobj.put("unit", d.getUnit());
		jarr.add(jobj);
	   }
	   PrintWriter out = response.getWriter(); 
	   out.println( jarr.toString());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
