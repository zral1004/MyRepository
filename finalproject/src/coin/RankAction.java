package coin;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CoinDAO;
import model.RankDTO;

/**
 * Servlet implementation class RankAction
 */
@WebServlet("/rank.go")
public class RankAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RankAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		CoinDAO dao = CoinDAO.getInstance();
		ArrayList<RankDTO> arr=dao.rank();
		
		DecimalFormat df=new DecimalFormat("#,##0");
		for(int i=0;i<arr.size();i++) {
			String userid=arr.get(i).getUserid();
			String asset=df.format(arr.get(i).getAsset());
			
			request.setAttribute("userid"+i, userid);
			request.setAttribute("asset"+i, asset);
		}
		RequestDispatcher rd =request.getRequestDispatcher("rank.jsp");
		rd.forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
