<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<c:import url="/top" />

<%-- <%@ include file="/WEB-INF/views/mypage/likelistScript.jsp" %> --%>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<style>
tr>td>a{
	color: black;
	text-decoration: none;
	font-weight: bold;
}
</style>

<script>
function maincheck(ck) // ck=> true, false
{   	
    var len=document.getElementsByClassName("subchk").length;
    if(ck)  // main이 체크가 되면
    {  // class='subchk'를 checked속성을 true
	    for(i=0;i<len;i++)
	    {
	 	   document.getElementsByClassName("subchk")[i].checked=true;
	    }	   
    }	 
    else
    {
	    for(i=0;i<len;i++)
	    {
		    document.getElementsByClassName("subchk")[i].checked=false;
	    }
    }	    
}

function subcheck()
{	
    var chk=0;
    // 체크박스의 항목이 전부 체크 되었느냐를 확인
    var len=document.getElementsByClassName("subchk").length;
    // 하나씩 체크하기
    for(i=0;i<len;i++)
    {
	    if(document.getElementsByClassName("subchk")[i].checked) chk++;
    }	
   
    if(chk==len)
    {
	    document.getElementById("mainchk").checked=true;
    }	
    else
    {
	    document.getElementById("mainchk").checked=false;
    }	   
}

</script>

<%
   String ctx = request.getContextPath();
%>
    
<div>
	<table width="900" align="center">
	<tr>
		<td> <input type="checkbox" onclick="maincheck(this.checked)" style="width:20px;height:20px;" id="mainchk"> </td>
		<td> 상품이미지 </td>
		<td> 상품명 </td>
		<td> 상품가격 </td>
		<td> 날짜 </td>
		<td> 삭제하기 </td>
	</tr>

	<c:if test="${likeArr eq null or empty likeArr}">
		<tr>
			<td>좋아요를 누르면 관심 상품 목록에 추가됩니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${likeArr ne null and not empty likeArr}">	
		<c:forEach var="like" items="${likeArr}">
		<tr>
         <td> <input type="checkbox" class="subchk" onclick="subcheck()" value="${like.pnum}"> </td>
         <td> <a href="<%=ctx%>/prodDetail?pnum=${like.pnum}"><img src="../../resources/images/${like.pimage1}" width="100"></a> </td>
         <td> <a href="<%=ctx%>/prodDetail?pnum=${like.pnum}">${like.pname}</a> </td>
         <td> <fmt:formatNumber value="${like.lprice}"/>원 </td>
         <td> ${like.lindate} </td>
         <td> <button class="likedel_btn" data-pnum="${like.pnum}">삭제</button></td>
       </tr>
			
		</c:forEach>
		
	</c:if>
	<tr height="80">
       <td colspan="6">
       	<button class="checkdel_btn">선택삭제</button>
        <input type="button" value="장바구니이동" onclick="move_cart()">
       </td>
     </tr>

	</table>
</div>

<form action="/mypage/like_del" method="post" class="like_delete_form">
	<input type="hidden" id="pnum" name="pnum" class="likedel_pnum">
	<input type="hidden" id="idx" name="idx" value=258>
</form>

<form action="/mypage/select_del" method="post" class="select_delete_form">
	<input type="hidden" id="pnum" name="pnum" class="selectdel_pnum">
	<input type="hidden" id="idx" name="idx" value=258>
</form>

<script>
$(".likedel_btn").on("click", function(e){
	e.preventDefault();
	const pnum=$(this).data("pnum");
	$(".likedel_pnum").val(pnum);
	$(".like_delete_form").submit();
});

$(".checkdel_btn").on("click", function(e){
	e.preventDefault();
	var len=document.getElementsByClassName("subchk").length;
	var str="";
	for(i=0; i<len; i++){
		if(document.getElementsByClassName("subchk")[i].checked){
			str+=document.getElementsByClassName("subchk")[i].value+",";
		}
	}
	alert(str);
	$(".selectdel_pnum").val(str);
	$('.select_delete_form').submit();
});

</script>

<c:import url="/foot" />