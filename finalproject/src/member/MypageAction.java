package member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CoinDAO;

/**
 * Servlet implementation class MypageAction
 */
@WebServlet("/mypage.go")
public class MypageAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MypageAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd=request.getRequestDispatcher("mypage.jsp");
		rd.forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	  request.setCharacterEncoding("utf-8");
	  
	  String userid=request.getParameter("userid");
	  String password=request.getParameter("pwd");
	  String new_pwd=request.getParameter("new_pwd");
	  
	  
	    response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
	
	
	  CoinDAO dao=CoinDAO.getInstance();
	  int flag=dao.ChangePwd(userid,password,new_pwd);
	  
	  if(flag==0)
	  {
		  out.println("<script> alert(\"기존 비밀번호가 맞지 않습니다.\"); history.back(); </script>");
	  }
	  else
	  {
		  HttpSession session=request.getSession();
		  session.invalidate();
		  response.sendRedirect("login.go");	
	  }
	}

}
