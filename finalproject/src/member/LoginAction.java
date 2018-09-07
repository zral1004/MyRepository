package member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CoinDAO;
import model.CoinDTO;

/**
 * Servlet implementation class LoginAction
 */
@WebServlet("/login.go")
public class LoginAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		  request.setCharacterEncoding("utf-8");
			
			String type=request.getParameter("type");
			
			if(type==null) type="";
			
			if(type.equals("join"))
			{    
				
	            request.setAttribute("type", type);
	            RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
	            rd.forward(request, response);
			}
			else
			{
				request.setAttribute("type", type);
				RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
				rd.forward(request, response);
			}
			}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
		
		String userid = request.getParameter("userid");
		String password = request.getParameter("password");
		
		CoinDAO dao=CoinDAO.getInstance();
		int result=dao.login(userid,password);
		
		//out 객체 선언
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		
		if(result==1) //아이디,비번 둘다 맞는경우에 세션 생성
		{
		    CoinDTO cdto=dao.loginUser(userid);
			HttpSession session=request.getSession();
			session.setAttribute("login", cdto);
			session.setAttribute("userid", userid);
            session.setMaxInactiveInterval(60*60);			
		
		   response.sendRedirect("index.jsp");
		}
		else if(result==-1)
		{
		 out.println("<script> alert(\"아이디가 존재하지 않습니다.\"); history.back(); </script>");
		}
		else if(result==0)
		{
		 out.println("<script> alert(\"비밀번호가 틀렸습니다.\"); history.back(); </script>");		
		}
		else
		{
		 out.println("<script> alert(\"아이디 또는 비밀번호를 확인해주세요\"); history.back(); </script>");		
		}
	}

}
