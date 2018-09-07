package model;

public class CoinDTO {
	private String userid;
	private String password;
	private String email;
	private long money;
	private String date;       
	private double BTC; //��Ʈ����
	private double BCH; //��Ʈ���� ĳ��
	private double ETH; //�̴�����
	private double ETC; //�̴� Ŭ����
	private double XRP; //���� 
	
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
