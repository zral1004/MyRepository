<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="/finalproject/js/bootstrap.js"></script>
<link rel="stylesheet" href="/finalproject/css/bootstrap.css">
<link rel="stylesheet" href="/finalproject/css/main.css">
<!DOCTYPE html>
<html>
<head>

<script>
CKEDITOR.replace('content', {
         
    width:'100%',
    height:'350'
         
});
</script>


</head>
<body>
<%@ include file="../header.jsp" %> 
<section id="free_board_title">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h2 class="title_text">WRITE</h2>
				</div>
			</div>
		</div>
	</section>


<section id="free_board_table_wrap">
 <div class="container"> 
  <div class="row" >
    <div class="col-md-12">     
        <form action="/finalproject/BoardWriterProcCon.do" method="post" >    
          <input type="hidden" name="userid" id="userid" value="${userid}">
          <table class="table table-striped">
            <tr>
                <td>작성자</td>
                <td><input type="text"  class="form-control" value="${userid}" readonly></td>
            </tr>
            <tr>
                <td>제목</td>
                <td><input type="text"  class="form-control" name="subject"></td>
            </tr>
            <tr>
                <td>이메일</td>
                <td><input type="email"  class="form-control" name="email"></td>
            </tr>
            <tr>
                <td>글내용</td>
                <td><textarea rows="10" cols="50" name="content" class="form-control"></textarea></td>
            </tr>
            <tr>
                <td colspan="2"  class="text-center">
                    <input type="submit" value="글쓰기" class="btn btn-success">
                    <input type="reset" value="다시작성" class="btn btn-warning">
                    <button type="button"  class="btn btn-primary" onclick="location.href='/finalproject/BoardListCon.do'">목록</button>
                </td>
            </tr>      
          </table>         
        </form>
     </div>
   </div>
</div>
</section> 
<%@ include file="../footer.jsp" %>
</body>
</html>