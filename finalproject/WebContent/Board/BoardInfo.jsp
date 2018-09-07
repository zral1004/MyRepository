<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>

$(function(){
  $.ajax({
	   url:"comment.go?num="+$("#num").val(),
	   type:"post",
	   success:function(data)
	   {	  
		   if(data.length!=0){
		    data=$.parseJSON(data);
			var htmlStr="";		
			for(var i=0;i<data.length;i++)
				{
				    htmlStr+="<p style='border-bottom: 1px solid #3babde; width:100%;'>"+data[i].regdate+"</p>";
				    htmlStr+="<p style='border-bottom: 1px solid #ddd; width:100%;'>"+data[i].msg+"</p>";			    
				}		
			$("#area").html(htmlStr);
	        }
	   }
	});
  

   $("#commentBtn").click(function(){
		if($("#msg").val().length == 0)
			{
			alert("댓글을 입력하세요");
			return false;
			}
	        $.ajax({
					type : "get",
					url : "comment.go",
					data : {
						"msg" : $("#msg").val(),
						"num" : $("#num").val()
					},
					success : function(data) 
					{ 
						/* alert(data); */
						data=$.parseJSON(data);
						var htmlStr="";
						
						for(var i=0;i<data.length;i++)
							{
							htmlStr+="<p style='border-bottom: 1px solid #3babde; width:95%; margin-left:20px;'>"+data[i].regdate+"</p>";
						    htmlStr+="<p style='border-bottom: 1px solid #ddd; width:95%; margin-left:20px;'>"+data[i].msg+"</p>";
							}				
						$("#area").html(htmlStr);
						/* } */
					}
				});
			//else 
            $("#msg").val("");
		});
   
   })
     

</script>

<section id="free_board_table_wrap">
	<div class="container">
		<div class="row">
			<input type="hidden" id="num" name="num" value="${bean.num}">
			<div class="col-lg-12 free_board"
				style="padding: 40px 10px 40px 10px;">
				<div class="view_title">
					<!-- 글 제목-->
					<p class="view_title_text">${bean.subject}</p>
					<!-- 글 작성일 -->
					<p class="view_title_date">작성일&nbsp${bean.reg_date}</p>					
				</div>
                <div class="view_writer">
					<!-- 글쓴이 -->
					<p class="view_writer_text">${bean.id}</p>
					<!-- 조회수  -->
					<p class="view_count">조회수&nbsp${bean.readcount}</p>					
				</div>
				<div class="view_content">
					<!--내용  -->
					<p>${bean.content}</p>
				</div>
                
				<div class="view_button text-center" style="align: center;">
					<input type="button" class="btn btn-primary" value="목록보기"
						onclick="location.href='BoardListCon.do'">
					  <c:set value="${userid}" var="user"/>
				       <c:if test="${bean.id==user}">
						 <input type="button" class="btn btn-warning" value="삭제하기"
						  onclick="del(${bean.num})">
				        </c:if>	 		
				</div>
                <!-- 댓글버튼 -->
				<div class="view_reple">
					<textarea id="msg" rows="4" required="required"
						placeholder="댓글을 입력해주세요."></textarea>
					<button type="button" value="댓글쓰기" id="commentBtn"
						class="btn btn-default">등록</button>
				</div>
                 <!-- 댓글 출력 영역-->
				<div id="area"></div>

			</div>
		</div>
	</div>
</section>
