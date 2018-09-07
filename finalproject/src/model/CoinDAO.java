package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class CoinDAO {

	private static CoinDAO instance =new CoinDAO();
	public static CoinDAO getInstance()
	{
		return instance;
	}
	
	private Connection getConnection() throws Exception
	{
		Context initCtx=new InitialContext();
		Context envCtx=(Context)initCtx.lookup("java:comp/env");
		DataSource ds=(DataSource)envCtx.lookup("jdbc/jsp");
		return ds.getConnection();
	}
	
	public ArrayList<CoinDTO> myInfor(String coin, String corp, String userid){
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<CoinDTO> arr = new ArrayList<>();
		try {
			con=getConnection();
			String sql="select * from coinuser where";
			ps=con.prepareStatement(sql);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			closeConnection4(con, ps, rs);
		}
		
		return arr;
	}
	
	
    //회원가입
	public int join(CoinDTO cd)
	{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		String sql=null;
		int flag=0;
		
		try {
			con=getConnection();
			sql="select userid from coinuser where userid='"+cd.getUserid()+"'";
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			if(!rs.next()) 
			{
			sql="INSERT INTO coinuser VALUES(?,?,?,?)";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, cd.getUserid());
			ps.setString(2, cd.getPassword());
			ps.setString(3, cd.getEmail());
			ps.setLong(4, cd.getMoney());		
			flag=ps.executeUpdate();
		/*	String[] corp= {"kb","co","bt"};
			for(int i=0;i<3;i++) 
			{
			sql="insert into "+corp[i] +" (userid) values ('"+cd.getUserid()+"')";
			ps=con.prepareStatement(sql);
			flag=ps.executeUpdate();
			}*/
		  }
		}catch(Exception e)
		{
			e.printStackTrace();
		}finally
		{
			closeConnection1(con, ps);
		}
		return flag;
	}
	

	//로그인 
	public int login(String userid,String password)
	{
		Connection con=null;
		Statement st=null;
		ResultSet rs=null;
		
		int flag=-1;
		try 
		{
		 con=getConnection();
		 st=con.createStatement();
		 String sql="select password from coinuser where userid='"+userid+"'";
		 rs=st.executeQuery(sql);
		 
		 if(rs.next())
		 {
			 if(rs.getString("password").equals(password))
			 {
				 flag=1;//아이디 비번 둘다 맞을 경우
			 }
			 else
			 {
				 flag=0; //비번이 틀린경우
			 }		 
		 }
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
			closeConnection2(con, st, rs);
		}
		return flag;
		
	}
	
	
	
	//로그인시 세션값 
		public CoinDTO loginUser(String userid)
		{
			Connection con=null;
			Statement st=null;
			ResultSet rs=null;
			
			CoinDTO cdto=null;
			
			try {
				con=getConnection();
				String sql="select*from coinuser where userid='"+userid+"'";
				st=con.createStatement();
				rs=st.executeQuery(sql);
				if(rs.next())
				{
					cdto=new CoinDTO();
					
					cdto.setEmail(rs.getString("email"));
					cdto.setMoney(rs.getLong("money"));
				}
			}catch(Exception e)
			{
				e.printStackTrace();
			}
			finally
			{
				closeConnection2(con, st, rs);
			}
			return cdto;		
		}
		
		//비밀번호 변경
		public int ChangePwd(String userid,String password,String new_pwd)
		{
			Connection con=null;
			Statement st=null;
			ResultSet rs=null;
			int flag=1;
			String sql="";
			
			try {
			con=getConnection();
			
			sql="select password from coinuser where userid='"+userid+"'";
			st=con.createStatement();
			rs=st.executeQuery(sql);
			
			if(rs.next())
			{
				if(rs.getString("password").equals(password))
				 {
					 sql="update coinuser set password="+new_pwd+" where userid='"+userid+"'";
					 st=con.createStatement();
					 rs=st.executeQuery(sql);
				 }
				else
				{
					flag=0;
				}	
			}
			}catch(Exception e)
			{
				e.printStackTrace();
			}finally
			{
				closeConnection2(con, st, rs);
			}
			
			return flag;
			
		}
		
		
		
		public ArrayList<CoinDTO> myAll(String userid){
			Connection con = null;
			Statement st = null;
			ResultSet rs = null;
			ArrayList<CoinDTO> arr = new ArrayList<>();
			try {
				con=getConnection();
				String[] corpkind= {"BT", "CO", "KB"};
				for(int i=0;i<3;i++) {
				String sql="select * from coinuser c,"+corpkind[i]+" ck where ck.userid=c.userid AND c.userid='"+userid+"'";
				
				st=con.createStatement();
				rs=st.executeQuery(sql);
				if(rs.next()) {
				CoinDTO d = new CoinDTO();
				d.setMoney(rs.getLong("money"));
				d.setBTC(rs.getDouble("BTC"));
				d.setBCH(rs.getDouble("BCH"));
				d.setETH(rs.getDouble("ETH"));
				d.setETC(rs.getDouble("ETC"));
				d.setXRP(rs.getDouble("XRP"));
				
				arr.add(d);
				}
			  }
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConnection2(con, st, rs);
			}
			
			return arr;
		}
		
		
		public int buyCoin(String userid,String coin,String corp,double unit, int coinPrice, int sellbuy) {
			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			String sql="";
			int allPrice=(int) Math.round(unit*coinPrice);
			int flag=0;
			try {
				con=getConnection();
				sql="select money from coinuser where userid='"+userid+"'";
				ps=con.prepareStatement(sql);
				rs=ps.executeQuery();
				if(rs.next()) {
					if(Integer.parseInt(rs.getString(1))>=allPrice) {
						sql="update coinuser set money=money-"+allPrice+" where userid='"+userid+"'";
						ps=con.prepareStatement(sql);
						ps.executeUpdate();
						sql="update "+corp+"  set "+coin+"="+coin+"+"+unit+"  where userid='"+userid+"'";
						ps=con.prepareStatement(sql);						
						flag=ps.executeUpdate();//맞으면 1
						if(flag==1) {
							sql="insert into tradelist values ('"+userid+"','"+corp+"','"+coin+"', sysdate,"+coinPrice+","
									+unit+","+sellbuy+","+allPrice+")";
							ps=con.prepareStatement(sql);
							ps.executeUpdate();
						}
					}
				}
				
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConnection4(con, ps, rs);
			}
			return flag;
		}
		
		
		public int sellCoin(String userid,String coin,String corp,double unit, int coinPrice, int sellbuy) {
			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			String sql="";
			int allPrice=(int) Math.round(unit*coinPrice);
			int flag=0;
			
			try {
				con=getConnection();
				sql="select "+ coin +" from "+ corp +" where userid='"+userid+"'";
				ps=con.prepareStatement(sql);
				rs=ps.executeQuery();
				if(rs.next()) {
					if(rs.getDouble(1)>=unit) {
						sql="update coinuser set money=money+"+allPrice+" where userid='"+userid+"'";
						ps=con.prepareStatement(sql);
						ps.executeUpdate();
						sql="update "+corp+" set "+coin+"="+coin+"-"+unit+"  where userid='"+userid+"'";
						ps=con.prepareStatement(sql);
						flag=ps.executeUpdate();//맞으면 1
						if(flag==1) {
							sql="insert into tradelist values ('"+userid+"','"+corp+"','"+coin+"', sysdate,"+coinPrice+","
									+unit+","+sellbuy+","+allPrice+")";
							ps=con.prepareStatement(sql);
							ps.executeUpdate();
						}
					}
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConnection4(con, ps, rs);
			}
			
			return flag;
		}
		
		//거래내역 조회
		public ArrayList<TradeDTO> tradeList(String userid, String corp, String coin){
			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			ArrayList<TradeDTO> arr = new ArrayList<>();
			try {
				con=getConnection();
				String sql="select * from tradelist where userid='"+userid+"' and corp='"+corp+"' and coin='"+coin+"' and rownum<6 order by tradedate desc";
				ps=con.prepareStatement(sql);
				/*ps.setString(1, userid);
				ps.setString(2, corp);
				ps.setString(3, coin);*/
				rs=ps.executeQuery();
				while(rs.next()) {
					TradeDTO td = new TradeDTO();
					
					td.setAllprice(rs.getInt("allprice"));
					td.setBuy_sell(rs.getInt("buy_sell"));
					td.setLastprice(rs.getInt("lastprice"));
					td.setTradedate(rs.getString("tradedate"));
					td.setUnit(rs.getDouble("unit"));
					arr.add(td);
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return arr;
				
			
			
		}
		
		
		
		
		
		//현재가 셋팅
		public void setLast(CorpCoinDTO cd) {
			Connection con = null;
			PreparedStatement ps = null;
			try {
				con=getConnection();
				String sql="update lastprice set  bbtc=?,bbch=?,beth=?,betc=?,bxrp=?,cbtc=?,cbch=?"
																			 + ",ceth=?,cetc=?,cxrp=?,kbtc=?,kbch=?,keth=?,ketc=?,kxrp=?";			
				ps=con.prepareStatement(sql);
				ps.setInt(1, cd.getBBTC());
				ps.setInt(2, cd.getBBCH());
				ps.setInt(3, cd.getBETH());
				ps.setInt(4,  cd.getBETC());
				ps.setInt(5, cd.getBXRP());
				ps.setInt(6,  cd.getCBTC());
				ps.setInt(7,  cd.getCBCH());
				ps.setInt(8,  cd.getCETH());
				ps.setInt(9, cd.getCETC());
				ps.setInt(10,  cd.getCXRP());
				ps.setInt(11,  cd.getKBTC());
				ps.setInt(12,  cd.getKBCH());
				ps.setInt(13,  cd.getKETH());
				ps.setInt(14,  cd.getKETC());
				ps.setInt(15,  cd.getKXRP());
				ps.executeUpdate();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConnection1(con, ps);
			}		
		}
		
		
		
		
		
		//총 자산
		
		public int myAsset(String userid) {
			Connection con = null;
			Statement st = null;
			ResultSet rs = null;
			String sql="";
			int asset=0;
			try {
				con=getConnection();
				sql="select ROUND(asset+c.money) asset from  (select a.userid ,(a.bbtc*b.bbtc+a.cbtc*b.cbtc+a.kbtc*b.kbtc+a.bbch*b.bbch+a.cbch*b.cbch+a.kbch*b.kbch +a.beth*b.beth+a.ceth*b.ceth+a.keth*b.keth  +a.betc*b.betc+a.cetc*b.cetc+a.ketc*b.ketc   +a.bxrp*b.bxrp+a.cxrp*b.cxrp+a.kxrp*b.kxrp) asset from LASTPRICE b,(select userid,bbtc,cbtc,kbtc ,bbch,cbch,kbch,beth,ceth,keth ,betc,cetc,ketc ,bxrp,cxrp,kxrp from (select b.userid,b.btc bbtc,b.bch bbch,b.eth beth,b.etc betc,b.xrp bxrp,c.btc cbtc,c.bch cbch,c.eth ceth,c.etc cetc,c.xrp cxrp,k.btc kbtc,k.bch kbch,k.eth keth,k.etc ketc,k.xrp kxrp from bt b, co c, kb k where b.userid=c.userid and c.userid=k.userid)) a )  a, coinuser c where a.userid='"+userid+"' and a.userid=c.userid";
				st=con.createStatement();
				rs=st.executeQuery(sql);
				if(rs.next()) {
				asset=rs.getInt("asset");
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConnection2(con, st, rs);
			}				
			return asset;
		}
		
		
		//랭킹
		public ArrayList<RankDTO> rank() {
			Connection con = null;
			Statement st = null;
			ResultSet rs = null;
			ArrayList<RankDTO> arr = new ArrayList<>();
			try {
				con=getConnection();
				String sql="select userid, ROUND(asset) asset from(select a.userid ,(a.money+a.bbtc*b.bbtc+a.cbtc*b.cbtc+a.kbtc*b.kbtc+a.bbch*b.bbch+a.cbch*b.cbch+a.kbch*b.kbch +a.beth*b.beth+a.ceth*b.ceth+a.keth*b.keth  +a.betc*b.betc+a.cetc*b.cetc+a.ketc*b.ketc   +a.bxrp*b.bxrp+a.cxrp*b.cxrp+a.kxrp*b.kxrp) asset from LASTPRICE b,(select b.userid,u.money,b.btc bbtc,b.bch bbch,b.eth beth,b.etc betc,b.xrp bxrp,c.btc cbtc,c.bch cbch,c.eth ceth,c.etc cetc,c.xrp cxrp,k.btc kbtc,k.bch kbch,k.eth keth,k.etc ketc,k.xrp kxrp from bt b, co c, kb k , coinuser u where u.userid=b.userid and b.userid=c.userid and c.userid=k.userid) a order by asset desc)where  rownum<11";
				
				st=con.createStatement();
				rs=st.executeQuery(sql);
				while(rs.next()) {
				RankDTO rd = new RankDTO(); 
				
				rd.setUserid(rs.getString("userid"));
				rd.setAsset(rs.getInt("asset"));
				arr.add(rd);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeConnection2(con, st, rs);
			}				
			return arr;
		}
	//종료 함수들 
			private void closeConnection1(Connection con,PreparedStatement ps)
			{
			 try{
					if(ps!=null) ps.close();
					if(con!=null) con.close();
				}catch(Exception e)
				{
					e.printStackTrace();
				}
			}
			
			private void closeConnection2(Connection con,Statement st, ResultSet rs)
			{
				 try{
						if(rs!=null) rs.close();
						if(st!=null) st.close();
						if(con!=null) con.close();
					}catch(Exception e)
					{
						e.printStackTrace();
					}
			}
			
			
			private void closeConnection3(Connection con,Statement st)
			{
			 try{
					if(st!=null) st.close();
					if(con!=null) con.close();
				}catch(Exception e)
				{
					e.printStackTrace();
				}
			}
			private void closeConnection4(Connection con,PreparedStatement ps,ResultSet rs)
			{
				try {
					if (ps != null)
						ps.close();
					if (rs != null)
						rs.close();
					if (con != null)
						con.close();
				}catch(Exception e)
				{
					e.printStackTrace();
				}
			}
	
}
