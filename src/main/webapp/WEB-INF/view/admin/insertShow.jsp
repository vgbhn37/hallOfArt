<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>HallOfArt - Admin</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="/css/admin_styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<style>
	.insertShow_content{
		width: 100%;
		min-height: 800px;
		border: 1px solid black;
	}
	#showList{
		border: 1px solid grey;
		margin: auto;
		margin-top: 50px;
		max-width: 1000px;
		width: 90%;
		text-align: center;
	}
	.contentTr{
		text-align: left;
	}
	.insert_content{
		border: 1px solid black;
		width: 85%;
		min-height: 800px;
		padding: 0 40px;
		margin: auto;
		background-color: white;
		display: flex;
		flex-direction: column;
		overflow: hidden;
	}
	textarea{
		width: 300px;
		height: 150px;
		resize: none;
		border: 1px solid #999;
	}
	input, select{
		width: 300px;
		border-radius: 0px;
		border: 1px solid #999;
		height: 75%;
	}
	.insertShowTb{
		max-width: 800px;
		width: 80%;
		text-align: center;
		margin: auto;
	}
	.insertShowTb td{
 		height: 35px;
		padding: 0px 10px;
	}
	#booking{
		display: block;
		background-color: white;
		border: 1px solid lightblue;
		width: 200px; height: 60px;
		text-align: center;
		border-radius: 10px;
		font-size: 30px;
		padding-top: 7px;
		margin: auto;
		margin-top: 30px;
		text-decoration: none;
		color: black;
	}
	#halltimeTd{
/* 		text-align: center; */
		width: 100%; 
		height: 100%;
		margin: auto;
		margin-top: 8px;
	}
	#showImg{
		width: 250px;
	}
	#hallInfoTd{
		font-size: 20px;
	}
</style>

</head>
<%@ include file="/WEB-INF/view/layout/admin_header.jsp"%>

        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
	                <h1 class="mt-4">공연/전시 입력 - ${name}</h1>
                    <div class="insert_content">
						<form method="post" id="apply_frm" action="insert" style="width:100%">
				  			<table class="insertShowTb">
				  				<tr>
									<td colspan="2"  style="text-align: center;">
										<br>
										<h3>
											대관 정보
											<c:forEach var="hall" items="${halls}">
												<c:if test="${hall.name eq name}">
													<input type="hidden" name="hallTbId" value="${hall.id}">
													<input type="hidden" name="name" value="${hall.name}">
												</c:if>
											</c:forEach>
										</h3>
									</td>
								</tr>
				       			<tr>
				       				<td rowspan="2">대관 날짜</td>
				       				<td>
				       					Start :&nbsp;<input type="text" class="datepicker" id="datepicker1" name="startDate" autocomplete="off" style="width: 200px;" readonly="readonly">
				       					<button type="button" id="date1resetBtn">reset</button>
				   					</td>
				       			</tr>
				       			<tr>
				       				<td>
				       					End :&nbsp;&nbsp;<input type="text" class="datepicker" id="datepicker2" name="endDate" autocomplete="off" style="width: 200px;" readonly="readonly">
				       					<button type="button" id="date2resetBtn">reset</button>
				       					<input type="hidden" id="amount" name="amount">
				       				</td>
				       			</tr>
				       			<tr>
				       				<td>대관료</td>
				       				<td id="hallInfoTd">
				       				</td>
				       			</tr>
				  				<tr>
				    				<td colspan="2">
				       					<br><h3>공연 정보</h3>
				    				</td>
				    			</tr>
				  				<tr>
				  					<td>신청인</td>
				  					<td>
				  						<c:choose>
											<c:when test="${empty user}">
												비로그인
												<input type="hidden" id="userTbIdd" value="">
											</c:when>
											<c:otherwise>
												id : <c:out value="${user.id}"></c:out>
												<input type="hidden" name="userTbId" value="${user.id}">
												<input type="hidden" name="showTbId" value="1">
											</c:otherwise>
										</c:choose>
				  					</td>
				  				</tr>
				       			<tr>
				       				<td style="width: 40%; min-width: 150px;">공연/전시 유형</td>
				       				<td>
				       					<select name="showTypeId1">
				       						<option value="" selected disabled>- - - - - - -</option>
				       						<option value="1">1 : 공연</option>
				       						<option value="2">2 : 전시</option>
				       					</select>
				       					<input type="hidden" id="showImg" name="showImg">
				    					</td>
				       			</tr>
				       			<tr>
				       				<td>공연/전시 제목</td>
				       				<td><input type="text" name="title"></td>
				       			</tr>
				       			<tr>
				       				<td>공연/전시 내용</td>
				       				<td><textarea name="content"></textarea></td>
				       			</tr>
				       			<tr>
				       				<td>공연/전시 시간</td>
				       				<td>
				       					<div id="showtime_div">
					       					<input type="time" min="09:00" max="18:00" class="showTime" name="showStartTime" style="width:135px;">
					       					~
					       					<input type="time" min="09:00" max="18:00" class="showTime" name="showEndTime" style="width:135px;">
					       					<input type="hidden" class="showTime" name="startTime">
				       					</div>
				       				</td>
				       			</tr>
				       			<tr><td style="height:20px"></td>
				       				<td style="height:20px; padding-bottom: 5px;"><span style="color: #bbb">※ 본 관은 오전 9:00 부터 오후 6:00 까지 운영합니다</span></td>
				       			</tr>
				       			<tr>
				       				<td>입장 가격</td>
				       				<td><input type="text" name="price"></td>
				       			</tr>
				   			</table>
				   		</form>
				   		<form method="post" id="upload" action="upload" onsubmit="return false;" style="width:100%" enctype="multipart/form-data">
							<table class="insertShowTb" >
					   			<tr>
					   				<td style="width: 40%; min-width: 150px;">공연/전시 이미지</td>
					   				<td>
					   					<label for="uploadImg">
					   						<input type="file" id="uploadImg" name="uploadImg" accept="image/*" multiple="multiple" style="width: 250px">
					   						<button id="uploadImgBtn" style="width:50px;">저장</button>
						   				</label>
				   					</td>
					   			</tr>
					   			<tr id="thumbTr">
					   				<td>미리보기</td>
					   				<td id="thumbTd" style="height: 300px; padding: 10px; background-color: #eee">
					   				</td>
					   			</tr>
							</table>
						</form>
	    				<a id="booking" href="#">신청하기</a>
					</div>
                </div>
            </main>
<%@ include file="/WEB-INF/view/layout/admin_footer.jsp"%>
        </div>
	<script>
	    $(document).ready(function() {
	    	// datepicker 기본 설정
			$(".datepicker").datepicker({
		        dateFormat: 'yy-mm-dd',
		        prevText: '이전 달',
		        nextText: '다음 달',
		        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		        showMonthAfterYear: true,
		        yearSuffix: '년',
		        beforeShowDay: disableDates
		    });
			
			// datepicker 범위 제약 옵션
			$('#datepicker1').datepicker('option', 'onSelect', function(dateString){
		    	$("#datepicker2").datepicker('option', 'minDate', dateString);
		    	for (let li of ${rentalList}) {
					if(dateString<li){
				    	$("#datepicker2").datepicker('option', 'maxDate', li);
		    			break;
					}
				}
		    	if($("#datepicker2").val().length!=0){
		    		amount = ${hallInfo.basicPrice}+(new Date($("#datepicker2").val()) - new Date($("#datepicker1").val()) )/(1000*60*60*24)*${hallInfo.perTimePrice};
		    		$("#hallInfoTd").html(amount.toLocaleString('ko-KR') + " 원");
		    		$("#amount").val(amount);
		    	}
		    });
			$('#date1resetBtn').on('click', function(){
		    	$("#datepicker1").val('');
		    	$("#datepicker2").datepicker('option', 'minDate', '');
		    	$("#datepicker2").datepicker('option', 'maxDate', '');
			});
		    $('#datepicker2').datepicker('option', 'onSelect', function(dateString){
		    	$("#datepicker1").datepicker('option', 'maxDate', dateString);
		    	for (let li of ${rentalList}.reverse()) {
					if(dateString>li){
				    	$("#datepicker1").datepicker('option', 'minDate', li);
		    			break;
					}
				}
		    	if($("#datepicker1").val().length!=0){
		    		amount = ${hallInfo.basicPrice}+(new Date($("#datepicker2").val()) - new Date($("#datepicker1").val()) )/(1000*60*60*24)*${hallInfo.perTimePrice};
		    		$("#hallInfoTd").html(amount.toLocaleString('ko-KR') + " 원");
		    		$("#amount").val(amount);
		    	}
		    });
			$('#date2resetBtn').on('click', function(){
		    	$("#datepicker2").val('');
		    	$("#datepicker1").datepicker('option', 'maxDate', '');
		    	$("#datepicker1").datepicker('option', 'minDate', '');
			});
			
//	 		datepicker 특정 일 비활성화
		    function disableDates(date){
//	             console.log("rentalList fnc : "+${rentalList});
	    		var m = date.getMonth() + 1;
	            var d = date.getDate();
	            var y = date.getFullYear();
	            for (var i = 0; i < ${rentalList}.length; i++) {
	                var parts = ${rentalList}[i].split('-');
	                var rentalYear = parseInt(parts[0]);
	                var rentalMonth = parseInt(parts[1]);
	                var rentalDay = parseInt(parts[2]);
	                if (y === rentalYear && m === rentalMonth && d === rentalDay) {
	                    return [false];
	                }
	            }
	            return [true];
		    }
			
			// 게시하기 버튼 애니메이션
	    	$("#booking").hover(
	   			function(){
	   				$("#booking").stop().animate({
	   					backgroundColor: "#cef"
	   				}, 300 );
	   			},
	   			function(){
	   				$("#booking").stop().animate({
	   					backgroundColor: "#fff"
	   				}, 300 );			
	   			}
	    	);
			
//	      --------------------- 유효성 검사 ------------------------
			$("#booking").on("click", function(){
				let checkMsg = '';
				$("input").css("border", "1px solid #999");
				$("select").css("border", "1px solid #999");
				$("textarea").css("border", "1px solid #999");
				// ---------------- 유효성 : 이미지 파일
				if($("#uploadImg").val().length==0){
					$("#uploadImg").css("border", "2px solid red");
					checkMsg+="이미지를 업로드해주세요\n";
				}
				// ---------------- 유효성 : 유형
				if($("select[name=showTypeId1]").val()==null){
					$("select[name=showTypeId1").css("border", "2px solid red");
					checkMsg+="대관 유형을 입력해주세요 (공연 / 전시)\n";
				}
				// ---------------- 유효성 : 제목
				if($("input[name=title]").val().trim().length==0){
					$("input[name=title").css("border", "2px solid red");
					checkMsg+="제목을 입력해주세요\n";
				}
				// ---------------- 유효성 : 내용
				if($("textarea[name=content]").val().trim().length==0){
					$("textarea[name=content").css("border", "2px solid red");
					checkMsg+="내용을 입력해주세요\n";
				}
				// ---------------- 유효성 : 날짜
				let pattern = /^\d{4}-\d{2}-\d{2}$/;
				if($("input[name=startDate]").val().length==0){
					$("input[name=startDate]").css("border", "2px solid red");
					checkMsg+="시작 날짜를 입력해주세요\n";
				}else if(!pattern.test($("input[name=startDate]").val())){
					$("input[name=startDate]").css("border", "2px solid red");
					checkMsg+="시작 날짜의 형식이 맞지 않습니다 (yyyy-mm-dd)\n";
				}
				if($("input[name=endDate]").val().length==0){
					$("input[name=endDate]").css("border", "2px solid red");
					checkMsg+="종료 날짜를 입력해주세요\n";
				}else if(!pattern.test($("input[name=endDate]").val())){
					$("input[name=endDate]").css("border", "2px solid red");
					checkMsg+="종료 날짜의 형식이 맞지 않습니다 (yyyy-mm-dd)\n";
				}
				// ---------------- 유효성 : 시간
				if($("input[name=showStartTime]").val().length==0||$("input[name=showEndTime]").val().length==0){
					$("input[name=showStartTime]").css("border", "2px solid red");
					$("input[name=showEndTime]").css("border", "2px solid red");
					checkMsg+="시작 시간과 종료 시간을 입력해주세요\n";
				}else if($("input[name=showStartTime]").val()>$("input[name=showEndTime]").val()){
					$("input[name=showStartTime]").css("border", "2px solid red");
					$("input[name=showEndTime]").css("border", "2px solid red");
					checkMsg+="시작 시간과 종료 시간이 적합하지 않습니다\n";
				}
				if($("input[name=showStartTime]").val()<"09:00"){
					$("input[name=showStartTime]").css("border", "2px solid red");
					checkMsg+="본 관의 운영 시간은 오전 09:00 부터 오후 18:00 까지 입니다\n";
				}else if($("input[name=showEndTime]").val()>"18:00"){
					$("input[name=showEndTime]").css("border", "2px solid red");
					checkMsg+="본 관의 운영 시간은 오전 09:00 부터 오후 18:00 까지 입니다\n";
				}
				// ---------------- 유효성 : 가격
				if($("input[name=price]").val().length==0){
					$("input[name=price]").css("border", "2px solid red");
					checkMsg+="입장 가격을 입력해주세요\n";
				}
				// ---------------- 유효성 : 장소
				if($("input[name=hallTbId]").val()==null){
					checkMsg+="대관할 홀 번호를 입력해주세요\n";
				}
	
				// startTime 계산
				$("input[name=startTime]").val($("input[name=startDate]").val()+" "+$("input[name=showStartTime]").val());
				
				// ---------------- 유효성 최종 확인
				if(checkMsg.length!=0){
					alert(checkMsg);				
				}else{
					if(confirm("위 내용으로 대관을 신청하시겠습니까?")){
			 			$("#apply_frm").submit();
					}
				}
			});
			
	        $(".showTime").on("input", function() {
	            var inputValue = this.value;

	            var minTime = "09:00";
	            var maxTime = "18:00";

	            if (inputValue < minTime || inputValue > maxTime) {
	                this.style.border = "2px solid red";
	            } else {
	                this.style.border = "";
	            }
	        });
	        
//	      ---------------------이미지 업로드------------------------
			let uploadImg = null;
			$("#uploadImg").on("change", function(e){
				uploadImg = e.target.files[0];
				console.log(uploadImg);
			});
			$("#thumbTr").hide();
			$("#uploadImgBtn").on("click", function(){
				let formData = new FormData();
// 				alert($("#uploadImg").val());
				if($("#uploadImg").val().length!=0){
					formData.append('uploadImg', uploadImg);
					console.log("formData : "+formData);
					
					$.ajax({
						url: "/show/upload",
						type: "post",
						data: formData,
						processData: false,
						contentType: false,
						success: function(data){
							console.log("업로드 성공 : "+data);
							let thumb = document.createElement("img");
							thumb.src = "/imagePath/"+data;
							thumb.style.width = "100%";
							thumb.style.height = "100%";
							$("#thumbTd").empty();
							$("#thumbTd").append(thumb);
							$("#thumbTr").show();
							$("#showImg").val(data);
						},
						error: function(e){
							console.log("error : "+e);
						}
					});// end of ajax
				}else{
					alert("이미지가 선택되지 않았습니다");
				}
			})
		});
	</script>
</body>
</html>
