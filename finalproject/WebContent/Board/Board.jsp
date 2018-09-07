<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>

<!DOCTYPE>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="/finalproject/js/bootstrap.js"></script>
<link rel="stylesheet" href="/finalproject/css/bootstrap.css">
<link rel="stylesheet" href="/finalproject/css/main.css?ver=1">

<html>
<head>
<script>
function check(){
	if(search.word.value==""){
		alert("값을 입력하세요");
		return;
	}
	search.submit();
}

$(function(){
   $("#btn_search").click(function(){
	 getSearch(1,"","");  
   });
});   
   //검색찾기
   function getSearch(pageNum,field,word)
     {
	   var field=(field=="")?$("#field").val():field;
	   var word=(word=="")?$("#word").val():word;
	   $("#fb").load("BoardListCon.do",{"pageNum":pageNum,"field":field,"word":word},function(data){
			$("#fb").html(data);
		})
	   
     }   
 
   function fview(num) //상세보기
   {
   	$.ajax({
   		 type:"get",
   		 url:"/finalproject/BoardInfoControl.do",
   		 data:{"num":num},
   		 success:function(data)
   		 {   
   			 $("#view").html(data);
   		 }
   	});
   }

   function del(num){
		
	   if(confirm("삭제하시겠습니까?"))  
		   {
		     location.href="delete.go?num="+num;
		   } 
	}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>
<div id="fb">
<%@ include file="../header.jsp" %>

	<section id="free_board_title">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h2 class="title_text">Free Board</h2>
				</div>
			</div>
		</div>
	</section>
	
	<div id=view></div>
	
	<section id="free_board_table_wrap">
		<div class="container">
			<div class="row">
			  <div  style="width: 1200px; height: 658px; table-layout: fixed;">
				<div class="col-lg-12 free_board" style="width: 1168px; height: 658px; table-layout: fixed;">

					<table class="table">
						<thead>
							<tr>
								<th>NO</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
						 <c:forEach items="${arrList}" var="arr">
							<tr>
							<td style="text-align:center; width:10%;">${arr.num}</td>
							<td style="text-align:left; width:50%;">
							<a href="#" onclick="fview(${arr.num});">${arr.subject}</a></td>
							<td>${arr.id}</td>
							<td>${arr.reg_date}</td>
							<td>${arr.readcount}</td>
							</tr>
						 </c:forEach>
							
						</tbody>
					</table>
                </div>    
                            </div>
					<div class="col-lg-12 board_search">
						<form name="search" id="search">
							<select class="form-control board_select" name="field" id="field"
								size=1 style="height: 34px;">
								<option value="subject">제목</option>
								<option value="id">작성자</option>
							</select> <input type="text" name="word" id="word" class="form-control"
								placeholder="검색어를 입력하세요">
							<button type="button" class="btn btn-primary btn-sm btn_search"
								value="검색" id="btn_search">검색</button>
						</form>
						
						<div class="boardBtn">
						<c:if test="${sessionScope.userid != null }">
							<a href="javascript:void(0)"><button type="button"
									class="btn btn-primary btn-md btn_write" onclick="location.href='/finalproject/BoardWriterProcCon.do'">글쓰기</button>
									</a> 
									</c:if>
									<a href="javascript:void(0)"><button type="button"
									class="btn btn-primary btn-md btn_list"
									onclick="location.href='/finalproject/BoardListCon.do'">목록</button></a>
						</div>
					</div>

					<!-- 페이징처리 -->
					<div class="board_paging">

						<!-- 이전 -->
						<c:if test="${startpage>blockpage}">
						   <a href="javascript:getSearch(${startpage-blockpage},'${field}','${word}')">&laquo</a>
						</c:if>
						<!-- 페이지 번호 -->
						<c:forEach begin="${startpage}" end="${endpage}" var="i">
							<c:if test="${i==currentPage}">${i}</c:if>
							<c:if test="${i!=currentPage}">
								<a href="javascript:getSearch(${i},'${field}','${word}')">${i}&nbsp</a>
							</c:if>
						</c:forEach>
						<!-- 다음 -->
						<c:if test="${endpage<totpage}">
							<a href="javascript:getSearch(${startpage+blockpage},'${field}','${word}')">&raquo</a>
						</c:if>
					</div>
			   
			</div>
			<!--row -->
		</div>
		<!-- container -->
	</section>


	<%@ include file="../footer.jsp" %>
	</div>
</body>
</html>