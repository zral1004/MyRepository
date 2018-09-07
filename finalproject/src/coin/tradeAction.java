package coin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import model.CoinDAO;

/**
 * Servlet implementation class tradeAction
 */
@WebServlet("/trade.io")
public class tradeAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public tradeAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		    request.setCharacterEncoding("utf-8");
         
	        HttpSession session=request.getSession();
	        
	        response.setContentType("text/html;charset=utf-8");
	        PrintWriter out=response.getWriter();
	        
	        
	        if(session.getAttribute("login")==null)
	        {          	
	        	out.println("<script> alert(\"로그인이 필요한 페이지 입니다.\");  location.href=\"login.go?type=join\"; </script>");  	
	        }
	        else
	        {
	        	RequestDispatcher rd =request.getRequestDispatcher("trade.jsp");
	    		rd.forward(request, response);
	        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String coin=request.getParameter("coin");
		String corp=request.getParameter("corp");
		int coinPrice= Integer.parseInt(request.getParameter("coinPrice"));
		double unit=Double.parseDouble(request.getParameter("unit"));
		String type=request.getParameter("type");
		HttpSession session=request.getSession();
		String userid=session.getAttribute("userid").toString();
		int flag=0;
		CoinDAO dao = new CoinDAO();
		 PrintWriter out = response.getWriter();	        		
		
		if(type.equals("B")) {//구매
			flag=dao.buyCoin(userid, coin, corp, unit, coinPrice, 0);		
		}
		if(type.equals("S")) {//판매
			flag=dao.sellCoin(userid, coin, corp, unit, coinPrice, 1);		
		}
		out.println(flag);
	}

}
