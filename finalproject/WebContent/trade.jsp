<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css">
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

var coin = "BTC";
var corp = "BT";
var avail_won = 0;
var avail_coin = 0;
var last_price = 0;
var cancel_idx = 0;
var total_buy_price = 0;
var total_sell_price = 0;


function fShowData() {
	myInfor();
   /*  fGetChartData(); */
	HogaData();
}
/* 	function setLastPrice() {
	if($('#buy_price').text()*1.0 <= 0) $('#buy_price').val(last_price);
	if($('#sell_price').text()*1.0 <= 0) $('#sell_price').val(last_price);
	fCalcData();
}
function setHogaPrice(prc) {
	$('#buy_price').val(prc);
	$('#sell_price').val(prc);
	fCalcData();
} */
function fCalcData() {
	// 금액-수량 계산하기

	// 매수 데이터 계산
	// 1. 최대 구매가능 코인수
	/* if($('#buy_price').text() > 0) {
		var max_buy_coin = avail_won / $('#buy_price').text();
		$('#max_buy_coin').text(Floor(max_buy_coin, 4));
	} */
	// 2. 총 매수금액 계산하기
	if($('#buy_unit').val() > 0) {
		if( $('#buy_unit').val() * 1.0 > $('#max_buy_coin').text() * 1.0 ) {
			$('#buy_unit').val($('#max_buy_coin').text());
		}
		// 총 매수금액 계산하기
		total_buy_price = $('#buy_price').text() * $('#buy_unit').val();
	}else{
		total_buy_price = 0;
	}
	$('#total_buy_price').html(numberWithCommas(total_buy_price) + " <span>원</span>");
	$('#total_buy_coin').html(($('#buy_unit').val() * 1.0) + " <span>" + coin + "</span>");

	// 매도 데이터 계산
/* 	// 1. 최대 매도가능 금액
	if($('#sell_price').val() > 0) {
		var max_sell_price =parseFloat(avail_coin * $('#sell_price').val()).toFixed(2);
		$('#max_sell_price').text(max_sell_price);
	} */
	// 2. 총 매도금액 계산하기
	if($('#sell_unit').val() > 0) {
		if( avail_coin < $('#sell_unit').val() * 1.0 ) {
			$('#sell_unit').val(avail_coin);
		}
		// 총 매도금액 계산하기
		total_sell_price = $('#sell_price').text() * $('#sell_unit').val();
	}else{
		total_sell_price = 0;
	}
	$('#total_sell_price').html(numberWithCommas(total_sell_price) + " <span>원</span>");
	$('#total_sell_coin').html(($('#sell_unit').val()*1.0) + " <span>" + coin + "</span>");


}

 function Floor(n, pos) {
	var digits = Math.pow(10, pos);
	var num = Math.floor(n * digits) / digits;
	return num.toFixed(pos);
} 

 $(function(){
		
		tradeList();
		
		function HogaData(){
			
			if(corp=="BT"){		
			 	$.get('BT.detail?coin='+coin+'&corp='+corp, function(data) { 
					
			      /*   $('#tCurrentTop').html(data); */
			        $(data).filter("div").each(function(i){
			        	if(i==0){
			        		$("#tCurrentTop").html($(this).html());
			        	}else{
			        		$(".order_price").html($(this).html());	        		
			        		last_price=$("#buy_price").text();	  
			        	}      	
			        }) 		        
			      });
				

				}else if(corp=="CO"){		

			 $.get('CO.detail?coin='+coin+'&corp='+corp, function(data) { 
				
			        $(data).filter("div").each(function(i){
			        	if(i==0){
			        		$("#tCurrentTop").html($(this).html());
			        	}else{
			        		$(".order_price").html($(this).html());
			        		last_price=$("#buy_price").text();
			        	}      	
			        })
			  });


			}else if(corp=="KB"){		
			$.get('KB.detail?coin='+coin+'&corp='+corp, function(data) { 
				
		        $(data).filter("div").each(function(i){
		        	if(i==0){
		        		$("#tCurrentTop").html($(this).html());
		        	}else{
		        		$(".order_price").html($(this).html());
		        		last_price=$("#buy_price").text();
		        	}      	
		        })
			  });
			}
			
			};//호가 끝
		
			//현재가 셋팅
			function setLast(){
				$.get('set.Last',function(data){
					
				})
			};
		
			
			
			function myInfor(){
				var corpN=0;
				if(corp=="BT") {
					corpN=0;
				}else if(corp=="CO") {
					corpN=1;
				}else {
					corpN=2;
				}
				setLast();
	$.get('my.Infor?coin='+coin+'&corpN='+corpN+'&corp='+corp, function(data) { 
				var json = $.parseJSON(data);
				var moneyAmount = parseFloat(json.moneyAmount);
				var asset = parseFloat(json.asset);
				var coinAmount = parseFloat(json.coinAmount);
	            $('#moneyAmount').html(numberWithCommas(moneyAmount));
	            $('#asset').html(numberWithCommas(asset));
	            $('#coinAmount').html(numberWithCommas(coinAmount));
	            $('#avail_won').html(numberWithCommas(moneyAmount)+'원');
	            $('#avail_coin').html(coinAmount.toFixed(4));
	 
	            $("#BTC").html(numberWithCommas(parseFloat(json.BTC)));
	            $("#BCH").html(numberWithCommas(parseFloat(json.BCH)));
	            $("#ETH").html(numberWithCommas(parseFloat(json.ETH)));
	            $("#ETC").html(numberWithCommas(parseFloat(json.ETC)));
	            $("#XRP").html(numberWithCommas(parseFloat(json.XRP)));
	            
	            
	            avail_won=moneyAmount;
	            avail_coin=coinAmount;
	            $('#max_buy_coin').html(parseFloat(moneyAmount/last_price).toFixed(4));
	            $('#max_sell_price').html(Math.round(parseFloat(coinAmount*last_price)));
			      });
			}
			
			function tradeList(){
				$.get('trade.List?coin='+coin+'&corp='+corp, function(data) { 
					
					data = $.parseJSON(data);
					$("#tradeFiled").html("");
					var htmlStr="";
					if(data.length!=0)
						{
					for(var i=0;i<5;i++){
						htmlStr+="<tr align=center>";
						htmlStr+="<td>"+data[i].tradedate+"</td>";
						
						if(data[i].buy_sell==0){
						htmlStr+="<td style='color:red; '>매수</td>";
						htmlStr+="<td style='color:red; '>"+data[i].lastprice+"</td>";
						htmlStr+="<td style='color:red; '>"+data[i].unit+"</td>";
						htmlStr+="<td style='color:red; '>"+data[i].allprice+"</td>";
						
						htmlStr+="</tr>";
						$("#tradeFiled").html(htmlStr);  
						}else{
							htmlStr+="<td style='color:blue; '>매도</td>";	
							htmlStr+="<td style='color:blue; '>"+data[i].lastprice+"</td>";
							htmlStr+="<td style='color:blue; '>"+data[i].unit+"</td>";
							htmlStr+="<td style='color:blue; '>"+data[i].allprice+"</td>";	
							
							htmlStr+="</tr>";
							$("#tradeFiled").html(htmlStr);  				
						}	
					}
						}
					else{
						htmlStr+="<tr>";
						htmlStr+="<td colspan='5' align=center>&nbsp&nbsp(거래내역 없음)</td>"
					    htmlStr+="</tr>";		
					    $("#tradeFiled").html(htmlStr);
						
					}
									 

				  	
				});
				 
			};
			
			
		// 매수-매도 탭 버튼
		$('ul.nav-tabs a').click(function (e) {
			e.preventDefault();
			$(this).tab('show');
		});

		// 퍼센트 버튼 클릭시
		$('.btn_buy_percent').click(function (e) {
			if($('#buy_price').text() > 0) {
				var pct_buy_coin = (avail_won * $(this).data('pct')/ 100) / $('#buy_price').text();
				$('#buy_unit').val(Floor(pct_buy_coin, 4));
				fCalcData();
			}
		}); 
		$('.btn_sell_percent').click(function (e) {
			if(avail_coin > 0) {
				var pct_sell_coin = (avail_coin * $(this).data('pct') / 100);
				$('#sell_unit').val(Floor(pct_sell_coin, 4));
				
				fCalcData();
			}
		});

		// 구매하기
		$('#btn_buy').click(function (e) {
			if(total_buy_price > 0) {
				$('#modal_buy_price').text(numberWithCommas(total_buy_price));
				$('#order_buy_Modal').modal('show'); 
			}
		});
		$('#btn_order_buy').click(function() {
			$('#order_buy_Modal').modal('hide');
			$.ajax({
				type:"POST",
				url:"trade.io",
				data:"coin="+coin+"&corp="+corp+"&coinPrice="+$('#buy_price').text()+"&unit="+$('#buy_unit').val()+"&type=B",
				success:function(data){
					if( data.trim() == "1" )
					{
						myInfor();
						$('#order_buysuccess_Modal').modal('show'); 
						$('#buy_unit').val(0);
						fCalcData();
						tradeList();
						
						
					}else{
						$('#order_alert_Modal').modal('show');
						$('#buy_unit').val(0);
						fCalcData();
						
					}
				},
				error:function(e){
					// alert(e.responseText);
				}
			});
		});
		

		// 판매하기
		$('#btn_sell').click(function (e) {
			if($('#sell_unit').val() * 1.0 > 0) {
				$('#modal_sell_unit').text($('#sell_unit').val());
				$('#order_sell_Modal').modal('show');
			}
		});
		$('#btn_order_sell').click(function() {
			$('#order_sell_Modal').modal('hide');
			$.ajax({
				type:"POST",
				url:"trade.io",
				data:"coin="+coin+"&corp="+corp+"&coinPrice="+$('#sell_price').text()+"&unit="+$('#sell_unit').val()+"&type=S",
				success:function(data){
					if( data.trim()== '1' )
					{
						myInfor();
						$('#order_sellsuccess_Modal').modal('show');
						$('#sell_unit').val(0);
						fCalcData();
						tradeList();
						
					}else{
						$('#order_alert_Modal').modal('show');
						$('#sell_unit').val(0);
						fCalcData();
						
					}
				},
				error:function(e){
					// alert(e.responseText);
				}
			});
		});

		// 거래소 선택 버튼
		$('.market_btn').click(function (e) {
			$(".market_btn").removeClass('market_sec');
			$(this).addClass('market_sec');
			corp = $(this).data('corp');

			// 코인 전체 보이기
			$(".coin_btn").attr('style', 'display:inline-block');


			// 선택 코인이 BTC인 경우 선택값 변경하기
			if(coin == "BTC") {
				$('.coin_btn').each(function(i, e){
					if($(e).data('coin') == "BTC") {
						$(e).addClass('coin_sec');
					}else{
						$(e).removeClass('coin_sec');
					}
				});
			}

			// 거래소나 코인 변경시 값 초기화
			$('#buy_price').val("");
			$('#sell_price').val("");
			$('#buy_unit').val("");
			$('#sell_unit').val("");
			myInfor();
			HogaData();
			tradeList();
		});

		// 코인 선택 버튼
		$('.coin_btn').click(function (e) {
			$(".coin_btn").removeClass('coin_sec');
			$(".coinAmount").removeClass('coin_red');
			$(this).addClass('coin_sec');
			coin = $(this).data('coin');
        
			if(coin=="BTC")
				{
				 $("#BTCTag").addClass('coin_red');
				 $("#BTC").addClass('coin_red');
				}
			else if(coin=="BCH")
				{
				 $("#BCHTag").addClass('coin_red');
				 $("#BCH").addClass('coin_red');
	
				}
			else if(coin=="ETH")
				{
				 $("#ETHTag").addClass('coin_red');
				 $("#ETH").addClass('coin_red');
				}
			else if(coin=="ETC")
			{
				 $("#ETCTag").addClass('coin_red');
				 $("#ETC").addClass('coin_red');
			}
			else{
				 $("#XRPTag").addClass('coin_red');
				 $("#XRP").addClass('coin_red');
			}
			
			
			// 거래소나 코인 변경시 값 초기화
			$('#buy_price').val("");
			$('#sell_price').val("");
			$('#buy_unit').val("");
			$('#sell_unit').val("");

			//fShowData();
			HogaData();
			myInfor();
			tradeList();
			fCalcData();
		});

		fCalcData();
		HogaData();
		myInfor();
		setInterval(function() {
			HogaData();
		
		}, 3000);

		setInterval(function() {
			myInfor();
		}, 3000);

		setInterval(function() {
			/* fGetChartData(); */
		}, 60000);
	});
	function numberWithCommas(x) {
	    return Math.round(x).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>
</head>
<body>

 <!-- nav 헤더-->
  <%@ include file="header.jsp" %>


<div class="body_wrapper">
       <section id="trade_market" class="trade_sec_market">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 market_tabbar">
                        <a href="javascript:void(0)"><button type="button" class="btn btn-default market_btn market_sec" data-corp="BT">빗썸</button></a>
                        <a href="javascript:void(0)"><button type="button" class="btn btn-default market_btn" data-corp="CO">코인원</button></a>
                        <a href="javascript:void(0)"><button type="button" class="btn btn-default market_btn" data-corp="KB">코빗</button></a>
                    </div>
                </div>
            </div>
        </section>

        <section id="trade_coin" class="trade_sec_coin">
            <div class="">
                <div class="row">
                    <div class="col-lg-12 coin_tabbar">
                        <div class="coin_group">
                            <a href="javascript:void(0)"><button type="button" class="btn btn-default btn-sm coin_btn coin_sec" data-coin="BTC"><img src='img/btc.png' width='12'> 비트코인</button></a>
                            <a href="javascript:void(0)"><button type="button" class="btn btn-default btn-sm coin_btn" data-coin="BCH"><img src='img/bch.png' width='12'> 비트코인 캐쉬</button></a>
                            <a href="javascript:void(0)"><button type="button" class="btn btn-default btn-sm coin_btn" data-coin="ETH"><img src='img/eth.png' width='12'> 이더리움</button></a>
                            <a href="javascript:void(0)"><button type="button" class="btn btn-default btn-sm coin_btn" data-coin="ETC"><img src='img/etc.png' width='12'> 이더 클래식</button></a>
                            <a href="javascript:void(0)"><button type="button" class="btn btn-default btn-sm coin_btn" data-coin="XRP"><img src='img/ripple.png' width='12'> 리플</button></a>          
                        </div>
                    </div>
                </div>
            </div>
        </section>

    <!--임시 테이블로 구성, 각 거래소별 정보-->
    <section id="trade_section_1">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 coin_data_box" id="tCurrentTop">
                        <!--callback 처리-->
                    </div> 
                </div>
            </div>
     </section>


 <!--매도,매수 -->
  <section id="trade_section_2">
  <div class="container">
     <div class="row">	
               <div class="tab_wrapper">
                            <div class="tab_box col-md-12">
                                <ul class="nav nav-tabs nav-justified">
                                  <li id="first-tab" class="sell_tab active col-xs-6"><a href="#first" data-toggle="tab">매수</a></li>
                                  <li id="second-tab" class="buy_tab col-xs-6"><a href="#second" data-toggle="tab">매도</a></li>
                                </ul>
                            </div>
                            <div class="tab-content">
                                <div class="col-xs-12 tab-pane fade active in" id="first" aria-labelledby="first-tab" style="padding:0px;">
                                    <form id="sell_tab_form" class="sell_tab_form" action="#" method="post">
                                        <div class="total_cash">
                                            <p class="total_cahs_title">사용가능</p>
                                            <p class="total_cahs_price" id="avail_won"></p>
                                        </div>
                                        <div class="form-group form_sell_price">
                                            <label for="buy_price" class="col-sm-2 col-xs-12 control-label sell_price_label">주문가격</label>
                                            <div class="col-sm-7 col-xs-12">
                                                <p class="order_price" id="buy_price"></p>
                                            </div>
                                            <div class="col-sm-3 col-xs-12 sell_price_text">
                                                <p>최대 구매 가능 수량 &nbsp;&nbsp;<span id='max_buy_coin'>0</span></p>
                                            </div>
                                        </div>
                                        <div class="form-group form_sell_amount">
                                            <label for="sell_input1" class="col-sm-2 col-xs-12 control-label sell_amount_label">주문수량</label>
                                            <div class="col-sm-7 col-xs-12">
                                                <input type="text" class="form-control order_amount" id="buy_unit" placeholder="매수수량" onKeyup="fCalcData()" onBlur="fCalcData()">
                                            </div>
                                            <div class="col-sm-3 col-xs-12 amount_btns">
                                                <button class="btn btn-xs btn-default btn_buy_percent" data-pct='30' type="button">
                                                    30%
                                                </button>
                                                <button class="btn btn-xs btn-default btn_buy_percent" data-pct='50' type="button">
                                                    50%
                                                </button>
                                                <button class="btn btn-xs btn-default max_btn btn_buy_percent" data-pct='100' type="button">
                                                                                                     최대
                                                </button>
                                                
                                            </div>
                                        </div>
                                        <div class="order_cash">
                                            <p class="order_cahs_title">매수금액</p>
                                            <p class="order_cahs_price" id="total_buy_price">0 <span>원</span></p>
                                        </div>
                                        <div class="order_total_amount">
                                            <p class="order_total_amount_title">총 매수량</p>
                                            <p class="order_total_amount_price" id="total_buy_coin">0 <span></span></p>
                                        </div>
                                        <div class="order_sell_btn_box">
                                            <button type="button" class="btn btn-lg btn-danger" id="btn_buy">매수하기</button>
                                        </div>
                                    </form>
                                </div>
                                
                                <!--매도하기 -->
                                <div class="col-xs-12 tab-pane fade" id="second" aria-labelledby="second-tab" style="padding:0px;">
                                    <form id="buy_tab_form" class="buy_tab_form" action="index.html" method="post">
                                        <div class="total_cash">
                                            <p class="total_cahs_title">사용가능</p>
                                            <p class="total_cahs_price" id="avail_coin"></p>
                                        </div>
                                        <div class="form-group form_sell_price">
                                            <label for="sell_input2" class="col-sm-2 control-label sell_price_label">매도가격</label>
                                            <div class="col-sm-7">
												<p class="order_price" id="sell_price"  ></p>
                                            </div>
                                            <div class="col-sm-3 buy_price_text">
                                                <p>최대 판매 가능 금액 <span id='max_sell_price'>0</span>원</p>
                                            </div>
                                        </div>
                                        <div class="form-group form_sell_amount">
                                            <label for="sell_input1" class="col-sm-2 control-label sell_amount_label">매도수량</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control order_amount" id="sell_unit" placeholder="매도수량" onKeyup="fCalcData()">
                                            </div>
                                            <div class="col-sm-3 amount_btns">
                                                <button class="btn btn-xs btn-default btn_sell_percent" data-pct='30' type="button">
                                                    30%
                                                </button>
                                                <button class="btn btn-xs btn-default btn_sell_percent" data-pct='50' type="button">
                                                    50%
                                                </button>
                                                <button class="btn btn-xs btn-default max_btn btn_sell_percent" data-pct='100' type="button">
                                                    최대
                                                </button>
                                            </div>
                                        </div>
                                        <div class="order_cash">
                                            <p class="order_cahs_title">매도금액</p>
                                            <p class="buy_cahs_price" id="total_sell_price">0 <span>원</span></p>
                                        </div>
                                        <div class="order_total_amount">
                                            <p class="order_total_amount_title">총 매도량</p>
                                            <p class="buy_total_amount_price" id="total_sell_coin">0 <span></span></p>
                                        </div>
                                        <div class="order_buy_btn_box">
                                            <button type="button" class="btn btn-lg btn-primary" id="btn_sell">매도하기</button>
                                        </div>
                                    </form>
                                </div> 
                            </div>
                      
					  </div>  <!--table wrapper -->
                      <!--개인 자산현황-->
						<div class="my_account_box col-md-4">
							<p class="my_account_title" style="text-align:right"> <!-- 선택시 해당 거래소명은 변환-->
								<span style="color: #34495E;">${login.email}</span> 님의 자산현황
							</p>
							<!--ul,li대신 테이블로 임시 대처 --> 
							<table class="table">
							 	 <tr>
									<th>원화</th><td id="moneyAmount" style="text-align:right"></td>
								</tr>
										
								<!-- <tr>
								 <th>코인</th><td id="coinAmount" style="text-align:right"></td>
								</tr> -->
							<tr>
								<th>자산</th>
								<td id="asset" style="text-align: right"></td>
							</tr>
							<tr>
								<th id="BTCTag" class="coinAmount coin_red">BTC</th>
								<td id="BTC" style="text-align:right;" class="coinAmount coin_red"></td>
							</tr>
							<tr>
								<th id="BCHTag" class="coinAmount ">BCH</th>
								<td id="BCH" style="text-align:right;"class="coinAmount"></td>
							</tr>
							<tr>
								<th id="ETHTag" class="coinAmount ">ETH</th>
								<td id="ETH" style="text-align:right;" class="coinAmount"></td>
							</tr>
							<tr>
								<th id="ETCTag" class="coinAmount ">ETC</th>
								<td id="ETC" style="text-align:right;" class="coinAmount"></td>
							</tr>
							<tr>
								<th id="XRPTag" class="coinAmount ">XRP</th>
								<td id="XRP" style="text-align:right;" class="coinAmount"></td>
							</tr>
						</table>
							
												
						<div style="margin-top: -6px;"> 
					    <button type="button" class="btn btn-info btn-lg"  onclick="proc2()" style="width:100%;
					    border-radius: 0; font-size: 13px;">
                                                  실시간 거래소 시세확인</button></div>
						</div>
						</div>
						
						
                    </div>
    	      </div>
     </section>


    
    <!--거래 내역 테이블 -->
     <section id="trade_section_4" >
            <div class="container">
                <div class="row">
                    <div class="order_history_box col-xxs-12 col-ss-12 col-s-12 col-xs-12 col-md-12">
                        <p class="order_history_title">거래내역<span class="unit">(최근 5건만 보여집니다.)</span></p>
                        <table class="table order_history_table" style='align:center'>
                            <thead style="float:none;">
                                <tr align=center>
                                    <td class="left" style='width:340'><b>거래일자</b></td>
                                    <td class="left" ><b>구분</b></td>
                                    <td ><b>체결가격 KRW</b></td>
                                    <td><b>체결수량 </b></td>
                                    <td class="oh_mb_none"><b>체결금액 KRW</b></td>
                                </tr>
                            </thead>
                            <tbody id="tradeFiled">
                            
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
    
    
       
       
    <!-- footer -->
	<%@ include file="footer.jsp" %>
    <!--footer끝 -->
</div><!-- body 전체 div -->

<!-- Modal -->
	    <div id="order_buy_Modal" class="modal fade cointap_modal">
	      <div class="modal-dialog">
	        <!-- Modal content-->
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal">&times;</button>
	            <h4 class="modal-title">매수 주문</h4>
	          </div>
	          <div class="modal-body">
	            <p><span id='modal_buy_price'>0</span> 원을 매수 하시겠습니까?</p>
	          </div>
	          <div class="modal-footer">
	            <button type="button" class="btn-sm btn-primary" id="btn_order_buy">확인</button>
	            <button type="button" class="btn-sm btn-danger" data-dismiss="modal">닫기</button>
	          </div>
	        </div>
	      </div>
	    </div>

		 <div id="order_sell_Modal" class="modal fade cointap_modal">
	      <div class="modal-dialog">
	        <!-- Modal content-->
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal">&times;</button>
	            <h4 class="modal-title">매도 주문</h4>
	          </div>
	          <div class="modal-body">
	            <p><span id='modal_sell_unit'>0</span> 코인을 매도 하시겠습니까?</p>
	          </div>
	          <div class="modal-footer">
	            <button type="button" class="btn-sm btn-primary" id="btn_order_sell">확인</button>
	            <button type="button" class="btn-sm btn-danger" data-dismiss="modal">닫기</button>
	          </div>
	        </div>
	      </div>
	    </div>
	    
	      <div id="order_buysuccess_Modal" class="modal fade cointap_modal">
	      <div class="modal-dialog">
	        <!-- Modal content-->
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal">&times;</button>
	           <!--  <h4 class="modal-title">매도 주문</h4> -->
	          </div>
	          <div class="modal-body">
	            <p >구매되었습니다.</p>
	          </div>
	          <div class="modal-footer">
	            <button type="button" class="btn-sm btn-primary" data-dismiss="modal">확인</button>
	          </div>
	        </div>
	      </div>
	    </div>
	    
	    <div id="order_sellsuccess_Modal" class="modal fade cointap_modal">
	      <div class="modal-dialog">
	        <!-- Modal content-->
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal">&times;</button>
	           <!--  <h4 class="modal-title">매도 주문</h4> -->
	          </div>
	          <div class="modal-body">
	            <p >판매되었습니다.</p>
	          </div>
	          <div class="modal-footer">
	            <button type="button" class="btn-sm btn-primary" data-dismiss="modal">확인</button>
	          </div>
	        </div>
	      </div>
	    </div>
	    
	      <div id="order_alert_Modal" class="modal fade cointap_modal">
	      <div class="modal-dialog">
	        <!-- Modal content-->
	        <div class="modal-content">
	          <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal">&times;</button>
	           <!--  <h4 class="modal-title">매도 주문</h4> -->
	          </div>
	          <div class="modal-body">
	            <p>금액이 부족합니다.</p>
	          </div>
	          <div class="modal-footer" style="align:center;">
	            <button type="button" class="btn-sm btn-danger" data-dismiss="modal">확인</button>
	          </div>
	        </div>
	      </div>
	    </div>
         <!-- 주식표  -->
         <div id="myModal" class="modal fade" role="dialog">
	      <div class="modal-dialog">
	        <!-- Modal content-->
	        <div class="modal-content" style="width: 655px;">
	          <div class="modal-header" >
	            <button type="button" class="close" data-dismiss="modal">&times;</button>
	           <!--  <h4 class="modal-title">매도 주문</h4> -->
	          </div>
	          <div class="modal-body">
	           <table>
	            <thead>
            <tr>
                <th style="border-right:1px solid #ddd;"></th>
                <th>코인원(KRW)</th>
                <th>빗썸(KRW)</th>
                <th>코빗(KRW)</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th><img src="img/btc.png" width=12px;>비트코인</th>
                <td id="coinone_BTC"></td>
                <td id="bithumb_BTC"></td>
                <td id="korbit_BTC"></td>
            </tr>
            <tr>
                <th><img src="img/bch.png" width=12px;>비트코인 캐쉬</th>
                <td id="coinone_BCH"></td>
                <td id="bithumb_BCH"></td>
                <td id="korbit_BCH"></td>
            </tr>
            <tr>
                <th><img src="img/eth.png" width=12px;>이더리움</th>
                <td id="coinone_ETH"></td>
                <td id="bithumb_ETH"></td>
                <td id="korbit_ETH"></td>
            </tr>
            <tr>
                <th><img src="img/etc.png" width=12px;>이더리움 클래식</th>
                <td id="coinone_ETC"></td>
                <td id="bithumb_ETC"></td>
                <td id="korbit_ETC"></td>
            </tr>            
            <tr>
                <th><img src="img/ripple.png" width=12px;>리플</th>
                <td id="coinone_XRP"></td>
                <td id="bithumb_XRP"></td>
                <td id="korbit_XRP"></td>
            </tr>
            </tbody>
        </table>
        
	          </div>
	          <div class="modal-footer" style="align:center;">
	            <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
	          </div>
	        </div>
	      </div>
	    </div>
</body>
</html>

<script>
function show(){
	try{
        /* 빗썸 */
   	 $.get('https://api.bithumb.com/public/ticker/ALL', function(data) {
        	// 거래소별 시세 
            var bithumb_btc = parseFloat(data['data']['BTC']['closing_price']);
            var bithumb_bch = parseFloat(data['data']['BCH']['closing_price']);
            var bithumb_eth = parseFloat(data['data']['ETH']['closing_price']);
            var bithumb_etc = parseFloat(data['data']['ETC']['closing_price']);
            var bithumb_xrp = parseFloat(data['data']['XRP']['closing_price']);
            
            //빗썸 비트코인 정보  
            var bithumb_btc_24H_fluctate = parseFloat(data['data']['BTC']['24H_fluctate']);
            var bithumb_btc_24H_fluctate_rate = parseFloat(data['data']['BTC']['24H_fluctate_rate']);
           //빗썸 비트코인캐쉬 정보
            var bithumb_bch_24H_fluctate = parseFloat(data['data']['BCH']['24H_fluctate']);
            var bithumb_bch_24H_fluctate_rate = parseFloat(data['data']['BCH']['24H_fluctate_rate']);       
           //빗썸 이더리움 정보      
            var bithumb_eth_24H_fluctate_rate = parseFloat(data['data']['ETH']['24H_fluctate_rate']);
            var bithumb_etc_24H_fluctate_rate=parseFloat(data['data']['ETC']['24H_fluctate_rate']);
            var bithumb_xrp_24H_fluctate_rate=parseFloat(data['data']['XRP']['24H_fluctate_rate']);
          // 거래소별 시세  입력 table1
         if(bithumb_btc_24H_fluctate_rate>=0){//증가일때
       	 $(".modal-body tbody").find("#bithumb_BTC").text( 
            numberWithCommas(bithumb_btc)+'(+'+numberWithCommas(bithumb_btc_24H_fluctate_rate)+'%)▲').css('color','red'); 
         }
         else{//하락일때
       	  $(".modal-body tbody").find("#bithumb_BTC").text(
       			  numberWithCommas(bithumb_btc)+'('+numberWithCommas(bithumb_btc_24H_fluctate_rate)+'%)▼').css('color','blue'); 
         } 
         
          if(bithumb_bch_24H_fluctate_rate>=0)
        	  {$(".modal-body tbody").find("#bithumb_BCH").text( 
        	   numberWithCommas(bithumb_bch)+'(+'+numberWithCommas(bithumb_bch_24H_fluctate_rate)+'%)▲').css('color','red');
        	  }
          else{
       	   $(".modal-body tbody").find("#bithumb_BCH").text( 
               numberWithCommas(bithumb_bch)+'('+numberWithCommas(bithumb_bch_24H_fluctate_rate)+'%)▼').css('color','blue'); 
               }   
          
          if(bithumb_eth_24H_fluctate_rate>=0)
        	  {$(".modal-body tbody").find("#bithumb_ETH").text( 
               numberWithCommas(bithumb_eth)+'(+'+numberWithCommas(bithumb_eth_24H_fluctate_rate)+'%)▲').css('color','red');
        	  }
          else{$(".modal-body tbody").find("#bithumb_ETH").text( 
        	  numberWithCommas(bithumb_eth)+'('+numberWithCommas(bithumb_eth_24H_fluctate_rate)+'%)▼').css('color','blue');
              }
          
          if(bithumb_etc_24H_fluctate_rate>=0)
        	  {
       	   $(".modal-body tbody").find("#bithumb_ETC").text( 
           numberWithCommas(bithumb_etc)+'(+'+numberWithCommas(bithumb_etc_24H_fluctate_rate)+'%)▲').css('color','red');
        	  }
          else{
       	   $(".modal-body tbody").find("#bithumb_ETC").text( 
        	   numberWithCommas(bithumb_etc)+'('+numberWithCommas(bithumb_etc_24H_fluctate_rate)+'%)▼').css('color','blue');
          }
          
          if(bithumb_xrp_24H_fluctate_rate>=0)
        	  {$(".modal-body tbody").find("#bithumb_XRP").text( 
          numberWithCommas(bithumb_xrp)+'(+'+numberWithCommas(bithumb_xrp_24H_fluctate_rate)+'%)▲').css('color','red');
        	  }
          else{$(".modal-body tbody").find("#bithumb_XRP").text( 
        	  numberWithCommas(bithumb_xrp)+'('+numberWithCommas(bithumb_xrp_24H_fluctate_rate)+'%)▼').css('color','blue');
          }
         });//빗썸 거래소 끝
         
         /* 코인원 */
   	 $.get('https://api.coinone.co.kr/ticker?currency=all', function(data) {
            var coinone_btc = parseFloat(data['btc']['last']);   //해당 코인의 최신값(last)
            var coinone_bch = parseFloat(data['bch']['last']);
            var coinone_eth = parseFloat(data['eth']['last']);
            var coinone_etc = parseFloat(data['etc']['last']);
            var coinone_xrp = parseFloat(data['xrp']['last']);
            
            var yesterday_last=parseFloat(data['btc']['yesterday_last']);  //해당코인의 어제 최고가(yesterday_last)
            var yesterday_last2=parseFloat(data['bch']['yesterday_last']);
            var yesterday_last3=parseFloat(data['eth']['yesterday_last']);
            var yesterday_last4=parseFloat(data['etc']['yesterday_last']);
            var yesterday_last5=parseFloat(data['xrp']['yesterday_last']);
            
            var coninone_btc_24H_fluctate=((coinone_btc/yesterday_last)-1)*100; //24시간 단위 상승률,하락률
            var coninone_bch_24H_fluctate=((coinone_bch/yesterday_last2)-1)*100;                   
            var coninone_eth_24H_fluctate=((coinone_eth/yesterday_last3)-1)*100;                    
            var coninone_etc_24H_fluctate=((coinone_etc/yesterday_last4)-1)*100;                    
            var coninone_xrp_24H_fluctate=((coinone_xrp/yesterday_last5)-1)*100;
        
            if(coninone_btc_24H_fluctate>=0)
            {$(".modal-body tbody").find("#coinone_BTC").text( 
            numberWithCommas(coinone_btc)+'(+'+parseFloat(coninone_btc_24H_fluctate).toFixed(4)+'%)▲').css('color','red'); 
            }
            else
            {
           	 $(".modal-body tbody").find("#coinone_BTC").text(
            numberWithCommas(coinone_btc)+'('+parseFloat(coninone_btc_24H_fluctate).toFixed(4)+'%)▼').css('color','blue');	
            }
            if(coninone_bch_24H_fluctate>=0)
            {$(".modal-body tbody").find("#coinone_BCH").text(
           numberWithCommas(coinone_bch)+'(+'+parseFloat(coninone_bch_24H_fluctate).toFixed(4)+'%)▲').css('color','red');
            }
            else
            {$(".modal-body tbody").find("#coinone_BCH").text(
            numberWithCommas(coinone_bch)+'('+parseFloat(coninone_bch_24H_fluctate).toFixed(4)+'%)▼').css('color','blue');
            }
            if(coninone_eth_24H_fluctate>=0)
            {$(".modal-body tbody").find("#coinone_ETH").text(
            numberWithCommas(coinone_eth)+'(+'+parseFloat(coninone_eth_24H_fluctate).toFixed(4)+'%)▲').css('color','red');
            }
            else
            {
              $(".modal-body tbody").find("#coinone_ETH").text(
            numberWithCommas(coinone_eth)+'('+parseFloat(coninone_eth_24H_fluctate).toFixed(4)+'%)▼').css('color','blue');
            }
            if(coninone_eth_24H_fluctate>=0)
            {$(".modal-body tbody").find("#coinone_ETH").text(	
            numberWithCommas(coinone_eth)+'(+'+parseFloat(coninone_eth_24H_fluctate).toFixed(4)+'%)▲').css('color','red');
            }
            else{
           	 $(".modal-body tbody").find("#coinone_ETH").text(
            	 numberWithCommas(coinone_eth)+'('+parseFloat(coninone_eth_24H_fluctate).toFixed(4)+'%)▼').css('color','blue');	
            }
            if(coninone_etc_24H_fluctate>=0){
           	 $(".modal-body tbody").find("#coinone_ETC").text(
            numberWithCommas(coinone_etc)+'(+'+parseFloat(coninone_etc_24H_fluctate).toFixed(4)+'%)▲').css('color','red');
            }
            else{
           	 $(".modal-body tbody").find("#coinone_ETC").text(
            	 numberWithCommas(coinone_etc)+'('+parseFloat(coninone_etc_24H_fluctate).toFixed(4)+'%)▼').css('color','blue');
            }
            if(coninone_xrp_24H_fluctate>=0)
            {
           	 $(".modal-body tbody").find("#coinone_XRP").text(
            numberWithCommas(coinone_xrp)+'(+'+parseFloat(coninone_xrp_24H_fluctate).toFixed(4)+'%)▲').css('color','red');
            }
            else
            	{
           	 $(".modal-body tbody").find("#coinone_XRP").text(
            	numberWithCommas(coinone_xrp)+'('+parseFloat(coninone_xrp_24H_fluctate).toFixed(4)+'%)▼').css('color','blue');
            	}
            });  //코인원 끝 
            
         /* 코빗 */       
   	    $.get('korbit.do?cUrl=https://api.korbit.co.kr/v1/ticker/detailed?currency_pair=btc_krw', function(data) {
            data = JSON.parse(data); //json데이터로 전달 안되어 변환               
              var korbit_btc = parseFloat(data.last);
              var korbit_btc_changePercent=parseFloat(data['changePercent']);
           
              if(korbit_btc_changePercent>=0)
          	{     $(".modal-body tbody").find("#korbit_BTC").text( 
              	 numberWithCommas(korbit_btc)+'(+'+numberWithCommas(korbit_btc_changePercent)+'%)▲').css('color','red');
          	}
              else
              {
           	   $(".modal-body tbody").find("#korbit_BTC").text(   
          	         numberWithCommas(korbit_btc)+'('+numberWithCommas(korbit_btc_changePercent)+'%)▼').css('color','blue');
              }
          });
          $.get('korbit.do?cUrl=https://api.korbit.co.kr/v1/ticker/detailed?currency_pair=bch_krw', function(data) {
              data = JSON.parse(data); //json데이터로 전달 안되어 변환
              var korbit_bch = parseFloat(data['last']);
              var korbit_bch_changePercent=parseFloat(data['changePercent']);
              if(korbit_bch_changePercent>=0)
              	{$(".modal-body tbody").find("#korbit_BCH").text(
              	 numberWithCommas(korbit_bch)+'(+'+numberWithCommas(korbit_bch_changePercent)+'%)▲').css('color','red');
              	}
                  else
                   {$(".modal-body tbody").find("#korbit_BCH").text(
                    numberWithCommas(korbit_bch)+'('+numberWithCommas(korbit_bch_changePercent)+'%)▼').css('color','blue');
                   }
           });
          $.get('korbit.do?cUrl=https://api.korbit.co.kr/v1/ticker/detailed?currency_pair=eth_krw', function(data) {
              data = JSON.parse(data); //json데이터로 전달 안되어 변환
              var korbit_eth = parseFloat(data['last']);
              var korbit_eth_changePercent=parseFloat(data['changePercent']);
    
              if(korbit_eth_changePercent>=0)
              	{
           	   $(".modal-body tbody").find("#korbit_ETH").text(
              	numberWithCommas(korbit_eth)+'(+'+numberWithCommas(korbit_eth_changePercent)+'%)▲').css('color','red');
              	}
              else{
           	   $(".modal-body tbody").find("#korbit_ETH").text(
              numberWithCommas(korbit_eth)+'('+numberWithCommas(korbit_eth_changePercent)+'%)▼').css('color','blue');
              }
              });
          $.get('korbit.do?cUrl=https://api.korbit.co.kr/v1/ticker/detailed?currency_pair=etc_krw', function(data) {
              data = JSON.parse(data); //json데이터로 전달 안되어 변환
              var korbit_etc = parseFloat(data['last']);
              var korbit_etc_changePercent=parseFloat(data['changePercent']);
              
              if(korbit_etc_changePercent>=0)
              	{
           	   $(".modal-body tbody").find("#korbit_ETC").text(
              numberWithCommas(korbit_etc)+'(+'+numberWithCommas(korbit_etc_changePercent)+'%)▲').css('color','red');
              	}else
              		{
              		$(".modal-body tbody").find("#korbit_ETC").text(
             numberWithCommas(korbit_etc)+'('+numberWithCommas(korbit_etc_changePercent)+'%)▼').css('color','blue');
              		}
              		});
          $.get('korbit.do?cUrl=https://api.korbit.co.kr/v1/ticker/detailed?currency_pair=xrp_krw', function(data) {
              data = JSON.parse(data); //json데이터로 전달 안되어 변환
              var korbit_xrp = parseFloat(data['last']);
              var korbit_xrp_changePercent=parseFloat(data['changePercent']);
              
               if(korbit_xrp_changePercent>=0)
              	 {
               	$(".modal-body tbody").find("#korbit_XRP").text(
              	 numberWithCommas(korbit_xrp)+'(+'+numberWithCommas(korbit_xrp_changePercent)+'%)▲').css('color','red');
              	 }
               else{
               	$(".modal-body tbody").find("#korbit_XRP").text(
               numberWithCommas(korbit_xrp)+'('+numberWithCommas(korbit_xrp_changePercent)+'%)▼').css('color','blue');
               }
           });
          
          /* $("#myModal").modal('show'); */
   	}catch(e)
   	{
   		
   	}finally {
            setTimeout("show()", 10000);  //10초후 재시작
       }
   }  
   
   function proc2(){
   	try{
   	show();
   	 $("#myModal").modal('show');
   	}
   	catch(e){
   		
   	}finally{
   		
   	}
   }

</script>