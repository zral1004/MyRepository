package model;

public class TradeDTO {
	private String tradedate;
	private int lastprice;
	private double unit;
	private int buy_sell;
	private int allprice;
	
	
	public String getTradedate() {
		return tradedate == null ? "" : tradedate.trim();
	}
	public int getLastprice() {
		return lastprice ;
	}
	public double getUnit() {
		return unit ;
	}
	public int getBuy_sell() {
		return buy_sell;
	}
	public int getAllprice() {
		return allprice ;
	}
	public void setTradedate(String tradedate) {
		this.tradedate = tradedate;
	}
	public void setLastprice(int lastprice) {
		this.lastprice = lastprice;
	}
	public void setUnit(double unit) {
		this.unit = unit;
	}
	public void setBuy_sell(int buy_sell) {
		this.buy_sell = buy_sell;
	}
	public void setAllprice(int allprice) {
		this.allprice = allprice;
	}

}
