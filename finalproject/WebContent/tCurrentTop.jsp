<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

                    <div>
                     <p class="coin_data_box_title">${coin }(${coinName})</p> <!--선택시 글자가 바꿈-->
                     <table class="table" >
						<thead>
							<tr>
							    <!-- 선택시 해당 거래소명은 변환-->		
								<td style="width:404;font-size:14px;color:#888;margin-bottom:5px;">${corp} 현재가/24시간 전 대비</td>
								<td style="width:148;font-size:14px;color:#888;margin-bottom:5px;">최고가</td>
								<td style="width:148;font-size:14px;color:#888;margin-bottom:5px;">최저가</td>
								<td style="width:151;font-size:14px;color:#888;margin-bottom:5px;">매도호가</td>
								<td style="width:151;font-size:14px;color:#888;margin-bottom:5px;">매수호가</td>
								<td style="width:121;font-size:14px;color:#888;margin-bottom:5px;">거래량</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th id="closing_price" style="width:404;">${closing_price}&nbsp
									<c:choose>
									<c:when test="${checker==null}">
										<span id="closing_24"  style="color : blue">${closing_24}</span>
									</c:when>
									<c:otherwise>
										<span id="closing_24" style="color : red">+${closing_24}</span>
									</c:otherwise>
									</c:choose>
								</th>
								<th id="max_price" style="width:148;">${max_price}</th>
								<th id="min_price" style="width:148;">${min_price}</th>
								<th id="sell_price" style="width:151;">${sell_price}</th>
								<th id="buy_price" style="width:151;">${buy_price}</th>
								<th id="volume_1day" style="width:121;">${volume_1day}</th>
								
							</tr>
						</tbody>
					</table>
                    </div>
                    <div>
                    ${closing_price}
                    </div>


</body>
</html>