package Board;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardBean;
import model.BoardDAO;


 
@WebServlet("/BoardInfoControl.do")
public class BoardInfoControl extends HttpServlet {
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        reqPro(request, response);
    }
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        reqPro(request, response);
    }
 
 
    protected void reqPro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         
        //num
        int num=Integer.parseInt(request.getParameter("num"));
         
        //
        BoardDAO bdao =new BoardDAO();
      
        BoardBean bean=bdao.boardView(num);
         
        request.setAttribute("bean", bean);
         
        //view .jsp 
        RequestDispatcher rd =request.getRequestDispatcher("/Board/BoardInfo.jsp");
        rd.forward(request, response);
    }
 
     
     
     
}