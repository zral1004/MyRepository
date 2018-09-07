package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



import model.CoinDAO;

public class BoardDAO {
	
	private static BoardDAO instance = new BoardDAO();

	  public static BoardDAO getInstance() {
	    return instance;
	  }

	  private Connection getConnection()
	    throws Exception
	  {
	    Context initCtx = new InitialContext();
	    Context envCtx = (Context)initCtx.lookup("java:comp/env");
	    DataSource ds = (DataSource)envCtx.lookup("jdbc/jsp");
	    return ds.getConnection();
	  }
	

	  
	  public void insertBoard(BoardBean bean) throws SQLException {
		  
	         
	        Connection con=null;
	        PreparedStatement ps=null;
	        ResultSet rs=null;
	        int ref=0; 
	        int re_step=1; 
	        int re_level=1; 
	        try{
	             con=getConnection();

	             
	            String sql =" insert into BOARD (NUM, ID, EMAIL, SUBJECT, REG_DATE, REF,RE_STEP, RE_LEVEL, READCOUNT, CONTENT) values(board_seq.NEXTVAL,?,?,?,sysdate,?,?,?,0,?) ";
	            ps=con.prepareStatement(sql);
	           
	            ps.setString(1, bean.getId());
	            ps.setString(2, bean.getEmail());
	            ps.setString(3, bean.getSubject());
	            ps.setInt(4, ref);
	            ps.setInt(5, re_step);
	            ps.setInt(6, re_level);
	            ps.setString(7, bean.getContent());
	           
	            ps.executeUpdate();
	        }catch(Exception e){
	            e.printStackTrace();
	        }finally{
	           
	          closeConnection4(con, ps, rs);
	        }
	    }
	
	public ArrayList<BoardBean> boardList(String field, String word, int startpage, int endpage)
	  {
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    String sql = "";
	    ArrayList arr = new ArrayList();
	    try {
	      con = getConnection();
	      if (word.equals(""))
	      {
	        sql = "select*from(select rownum rn,ss.* from(select*from board order by num desc) ss) where rn between ? and ? ";
	      }
	      else
	      {
	          sql = "select*from(select rownum rn,ss.* from(select*from board where " + 
	          field + " like '%" + word + "%' order by num desc) ss) " + 
	          "where rn between ? and ? ";
	      }
	      ps = con.prepareStatement(sql);
	      ps.setInt(1, startpage);
	      ps.setInt(2, endpage);

	      rs = ps.executeQuery();

	      while (rs.next())
	      {
	        BoardBean bean = new BoardBean();
	        bean.setNum(rs.getInt("num"));
	        bean.setId(rs.getString("id"));
	        bean.setSubject(rs.getString("subject"));
	        bean.setReg_date(rs.getString("reg_date"));
	        bean.setReadcount(rs.getInt("readcount"));
	        bean.setContent(rs.getString("content"));
	        
	        arr.add(bean);
	      }

	    }
	    catch (Exception e)
	    {
	      e.printStackTrace();
	    } finally {
	      closeConnection4(con, ps, rs);
	    }
	    return arr;
	  }
	
	 public int boardCount()
	  {
	    Connection con = null;
	    Statement st = null;
	    ResultSet rs = null;
	    int count = 0;
	    try
	    {
	      con = getConnection();
	      String sql = "select count(*) from board";
	      st = con.createStatement();
	      rs = st.executeQuery(sql);

	      if (rs.next())
	      {
	        count = rs.getInt(1);
	      }
	    }
	    catch (Exception e)
	    {
	      e.printStackTrace();
	    } finally {
	      closeConnection3(con, st);
	    }
	    return count;
	  }
	
	 public int boardCount(String field, String word)
	  {
	    Connection con = null;
	    Statement st = null;
	    ResultSet rs = null;
	    String sql = "";
	    int count = 0;
	    try
	    {
	      con = getConnection();
	      st = con.createStatement();

	      if (word.equals(""))
	      {
	        sql = "select count(*) from board";
	      }
	      else
	      {
	        sql = "select count(*) from board where " + field + " like '%" + word + "%'";
	      }

	      rs = st.executeQuery(sql);

	      if (rs.next())
	      {
	        count = rs.getInt(1);
	      }
	    }
	    catch (Exception e)
	    {
	      e.printStackTrace();
	    } finally {
	      closeConnection3(con, st);
	    }
	    return count;
	  }
	
	 public BoardBean boardView(int num)
	  {
	    Connection con = null;
	    Statement st = null;
	    ResultSet rs = null;

	    BoardBean bean= new BoardBean();
	    try
	    {
	      con = getConnection();
	      st = con.createStatement();
	      st.executeUpdate("UPDATE board SET readcount=readcount+1 where num=" + num);

	      String sql = "select*from board where num=" + num;
	      rs = st.executeQuery(sql);

	      if (rs.next())
	      {
	    	  bean.setNum(num);
	    	  bean.setId(rs.getString("id"));
	    	  bean.setSubject(rs.getString("subject"));
	    	  bean.setReg_date(rs.getString("reg_date"));
	    	  bean.setContent(rs.getString("content"));
	          bean.setEmail(rs.getString("email"));
	          bean.setReadcount(rs.getInt("readcount"));
	      }

	    }
	    catch (Exception e)
	    {
	      e.printStackTrace();
	    }
	    finally {
	      closeConnection2(con, st, rs);
	    }
	    return bean;
	  }
	 //�Խñ� ����
	 
	 public void boardDel(int num)
	 {
		 Connection con=null;
		 Statement st=null;
		 
		 try{
		 con=getConnection();	 
		 String sql="delete from board where num="+num;
		 st=con.createStatement();
		 st.executeQuery(sql);
		 }
		 catch(Exception e)
		 {
			 e.printStackTrace();	 
		 }finally {
			 closeConnection3(con, st);
		 }
	 }
	 
	 
	 
	 
	 //��� �Է�
	 public void CommentInsert(CommentBean cb)
	    {
	    	Connection con=null;
	    	PreparedStatement ps=null;
	    	
	    	try {
	    		con=getConnection();
	    		String sql="insert into reply values(reply_seq.nextval,?,to_char(sysdate,'yyyy/mm/dd'),?)";
	    		ps=con.prepareStatement(sql);
	    		
	    		
	    		ps.setString(1, cb.getMsg());
	    		ps.setInt(2, cb.getBnum());
	    		
	    		ps.executeUpdate();
	    	}catch(Exception e)
	    	{
	    		e.printStackTrace();
	    	}finally
	    	{
	    		closeConnection1(con, ps);
	    	}

	    }
	 
	 public ArrayList<CommentBean> commentList(int bnum) {
	    	Connection con=null;
	    	Statement st=null;
	    	ResultSet rs=null;
	    			
	    	ArrayList<CommentBean> arr=new ArrayList<>();		
	       try {
	    	   con=getConnection();
	    	   String sql="SELECT *FROM reply WHERE bnum ="+bnum+" ORDER BY cnum DESC";
	    	   st=con.createStatement();
	    	   rs=st.executeQuery(sql);
	    	   
	    	   while(rs.next())
	    	   {
	    		    CommentBean cb=new CommentBean();
					cb.setCnum(rs.getInt(1));	
					cb.setMsg(rs.getString(2));
					cb.setRegdate(rs.getString(3));
					cb.setBnum(bnum);
	    		   
					arr.add(cb);
	    	   }
	    	   
	       }catch(Exception e)
	    	{
	    	   e.printStackTrace();
	    	}finally {
	    		closeConnection2(con, st, rs);
	    	}
	    	return arr;
	    }
	 
	 
	 private void closeConnection1(Connection con, PreparedStatement ps)
	  {
	    try
	    {
	      if (ps != null) ps.close();
	      if (con != null) con.close(); 
	    }
	    catch (Exception e)
	    {
	      e.printStackTrace();
	    }
	  }

	  private void closeConnection2(Connection con, Statement st, ResultSet rs)
	  {
	    try {
	      if (rs != null) rs.close();
	      if (st != null) st.close();
	      if (con != null) con.close(); 
	    }
	    catch (Exception e)
	    {
	      e.printStackTrace();
	    }
	  }

	  private void closeConnection3(Connection con, Statement st)
	  {
	    try
	    {
	      if (st != null) st.close();
	      if (con != null) con.close(); 
	    }
	    catch (Exception e)
	    {
	      e.printStackTrace();
	    }
	  }

	  private void closeConnection4(Connection con, PreparedStatement ps, ResultSet rs) {
	    try {
	      if (ps != null)
	        ps.close();
	      if (rs != null)
	        rs.close();
	      if (con != null)
	        con.close();
	    }
	    catch (Exception e) {
	      e.printStackTrace();
	    }
	  }
	
}
