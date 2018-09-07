package Board;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.BoardDAO;
import model.CommentBean;

/**
 * Servlet implementation class commentInsert
 */
@WebServlet("/comment.go")
public class commentAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public commentAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//댓글 삽입하고 갱신용
		
		request.setCharacterEncoding("utf-8");

		String msg = request.getParameter("msg");
		int bnum = Integer.parseInt(request.getParameter("num"));

		CommentBean cb = new CommentBean();
		cb.setBnum(bnum);
		cb.setMsg(msg);
		BoardDAO dao = BoardDAO.getInstance();
		dao.CommentInsert(cb);

		ArrayList<CommentBean> arr = dao.commentList(bnum);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		JSONArray jarr = new JSONArray();
		for (CommentBean c : arr) {
			JSONObject obj = new JSONObject();

			obj.put("cnum", c.getCnum());
			obj.put("msg", c.getMsg());
			obj.put("regdate", c.getRegdate());
			obj.put("bnum", c.getBnum());

			jarr.add(obj);
		}
		out.println(jarr.toString());	
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //게시판 열람시 호출용
		request.setCharacterEncoding("utf-8");
        
		if(request.getParameter("num")!=null)
		{
			
		
		
		int bnum = Integer.parseInt(request.getParameter("num"));
        
		CommentBean cb = new CommentBean();
		cb.setBnum(bnum);
		BoardDAO dao = BoardDAO.getInstance();
		

		ArrayList<CommentBean> arr = dao.commentList(bnum);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		JSONArray jarr = new JSONArray();
		for (CommentBean c : arr) {
			JSONObject obj = new JSONObject();

			obj.put("cnum", c.getCnum());
			obj.put("msg", c.getMsg());
			obj.put("regdate", c.getRegdate());
			obj.put("bnum", c.getBnum());

			jarr.add(obj);
		}
		out.println(jarr.toString());
		}
	}

}
