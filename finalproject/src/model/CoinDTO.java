package model;

public class CoinDTO {
	private String userid;
	private String password;
	private String email;
	private long money;
	private String date;       
	private double BTC; //비트코인
	private double BCH; //비트코인 캐쉬
	private double ETH; //이더리움
	private double ETC; //이더 클래식
	private double XRP; //리플 
	
	public String getUserid() {
		return userid == null ? "" : userid.trim();
	}
	public String getPassword() {
		return password == null ? "" : password.trim();
	}
	public String getEmail() {
		return email == null ? "" : email.trim();
	}
	public long getMoney() {
		return money ;
	}
	public String getDate() {
		return date == null ? "" : date.trim();
	}
	public double getBTC() {
		return BTC ;
	}
	public double getBCH() {
		return BCH ;
	}
	public double getETH() {
		return ETH;
	}
	public double getETC() {
		return ETC;
	}
	public double getXRP() {
		return XRP;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setMoney(long money) {
		this.money = money;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public void setBTC(double bTC) {
		BTC = bTC;
	}
	public void setBCH(double bCH) {
		BCH = bCH;
	}
	public void setETH(double eTH) {
		ETH = eTH;
	}
	public void setETC(double eTC) {
		ETC = eTC;
	}
	public void setXRP(double xRP) {
		XRP = xRP;
	}
}
