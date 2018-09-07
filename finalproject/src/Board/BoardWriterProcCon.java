package Board;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BoardBean;
import model.BoardDAO;


 

 
 
@WebServlet("/BoardWriterProcCon.do")
public class BoardWriterProcCon extends HttpServlet {
     
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        response.sendRedirect("/finalproject/Board/BoardWriteForm.jsp");
    }
 
     
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         
        reqPro(request, response);
    }
 
     
    protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         
        request.setCharacterEncoding("UTF-8");
         
        String userid=request.getParameter("userid");
        BoardBean bean=new BoardBean();
        bean.setId(userid);
        bean.setSubject(request.getParameter("subject"));
        bean.setEmail(request.getParameter("email"));
        bean.setContent(request.getParameter("content"));
         
        BoardDAO bdao=BoardDAO.getInstance();
        try {
			bdao.insertBoard(bean);
		} catch (SQLException e) {
			e.printStackTrace();
		}
         
        RequestDispatcher rd =request.getRequestDispatcher("/BoardListCon.do");
        rd.forward(request, response);
         
    }
 
     
     
}