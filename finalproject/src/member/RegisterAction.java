package member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CoinDAO;
import model.CoinDTO;



/**
 * Servlet implementation class RegisterAction
 */
@WebServlet("/register.go")
public class RegisterAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

      request.setCharacterEncoding("utf-8");
      
      String userid=request.getParameter("userid");
      String email=request.getParameter("email");
      String password=request.getParameter("password");
      Long money=(long) 30000000;      //초기자금 3000만원 지급
      
      CoinDTO cdto=new CoinDTO();
      cdto.setEmail(email);
      cdto.setUserid(userid);
      cdto.setPassword(password);
      cdto.setMoney(money);
      
      CoinDAO dao=CoinDAO.getInstance();
       int flag= dao.join(cdto);
      if(flag==0)
      {
    	  response.setContentType("text/html;charset=utf-8");
    	  PrintWriter out =response.getWriter();
    	  out.println("<script>alert(\"아이디가 존재합니다.\"); history.back();</script>");
      }
      else 
      {
	  response.sendRedirect("index.jsp");
      }
	}

}
