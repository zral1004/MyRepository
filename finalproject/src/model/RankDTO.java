package model;

public class RankDTO {
	private String userid;
	private int asset;
	
	
	
	public String getUserid() {
		return userid == null ? "" : userid.trim();
	}
	public int getAsset() {
		return asset ;
	}
	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setAsset(int asset) {
		this.asset = asset;
	}
	
	
}