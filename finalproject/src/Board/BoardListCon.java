package Board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BoardBean;
import model.BoardDAO;



/**
 * Servlet implementation class BoardListCon
 */
@WebServlet("/BoardListCon.do")
public class BoardListCon extends HttpServlet {


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		reqPro(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		reqPro(request, response);
	}
	protected void reqPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session=request.getSession();
		
		request.setCharacterEncoding("utf-8");
		
		String pageNum=request.getParameter("pageNum") == null?"1":request.getParameter("pageNum");
		String field = request.getParameter("field") == null ? "" : request.getParameter("field");
	    String word = request.getParameter("word") == null ? "" : request.getParameter("word");
		
	    int currentPage = Integer.parseInt(pageNum);
	    int pageSize = 10;
	    int startRow = (currentPage - 1) * pageSize + 1;
	    int endRow = currentPage * pageSize;
	    
	    
	    BoardDAO dao=BoardDAO.getInstance();
	    
	    ArrayList arr=dao.boardList(field,word,startRow,endRow);
	    
	    int count=dao.boardCount(field,word);
	    
	    int totpage=count/pageSize+(count%pageSize==0? 0:1);
	    int blockpage=5;
	    int startpage=(currentPage-1)/blockpage*blockpage+1;
	    int endpage=startpage+blockpage-1;
	    if(endpage>totpage) endpage=totpage;
	    
	    request.setAttribute("startpage", Integer.valueOf(startpage));
	    request.setAttribute("endpage", Integer.valueOf(endpage));
	    request.setAttribute("currentPage", Integer.valueOf(currentPage));
	    request.setAttribute("blockpage", Integer.valueOf(blockpage));
	    request.setAttribute("totpage", Integer.valueOf(totpage));

	    request.setAttribute("field", field);
	    request.setAttribute("word", word);

	    request.setAttribute("arrList", arr);
	    request.setAttribute("cnt", Integer.valueOf(count));
		/*
		int pageSize=10;
		
		
		if(pageNum==null) {
			pageNum="1";
		}
		
		int count=0;
		
		int number=0;
		int currentPage=Integer.parseInt(pageNum);
		
		    BoardDAO bdao =new BoardDAO();
		    count =bdao.getAllCount();//102¹ÝÈ¯µÊ
		 
		    int startRow =(currentPage-1)*pageSize+1; //1
		    int endRow =currentPage *pageSize; //10
		
		    Vector<BoardBean> v =bdao.getAllBoard(startRow,endRow);
		    number = count  - (currentPage - 1) * pageSize;
	         
	        /////// BoardList.jsp 
	        request.setAttribute("v",v);
	        request.setAttribute("number", number);
	        request.setAttribute("pageSize", pageSize);
	        request.setAttribute("count", count);
	        request.setAttribute("currentPage", currentPage);*/
	         
	         
	        RequestDispatcher rd =request.getRequestDispatcher("/Board/Board.jsp");
	        rd.forward(request, response);
	}
}
