<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.json.JSONObject"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<head>


    <title>SmartHome_Chart</title>
	<script type="text/javascript"
    src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>


    <meta http-equiv="refresh" content="300">
    <!-- jQuery -->
      <script src="https://code.jquery.com/jquery.min.js"></script>


    <!-- google charts -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="https://www.google.com/jsapi"></script>

  
<meta name = "viewport" content = "width=device-width", initial-scale ="1">
<link rel = "stylesheet" href = "css/bootstrap.css">
<link rel = "stylesheet" href = "css/custom.css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chart.jsp</title>


<body>
	<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}else if (userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다..')");
		script.println("location.href = 'member/login.jsp'");
		script.println("</script>");
	}
%>

	<nav class = "navbar navbar-defalut">
		<div class = "navbar-header">
			<button type ="button" class ="navbar-toggle collapsed"
				data-toggle = "collapse" data-target ="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class ="icon-bar"></span>
				<span class ="icon-bar"></span>
				<span class ="icon-bar"></span>
				</button>
				<a class ="navbar-brand" href ="main.jsp">Smart-Home 웹 사이트</a>
		</div>
		<div class = "collapse navbar-collapse" id="#bs-example-navbar-collapse-1">
			<ul class = "nav navbar-nav">
				<li><a href="main.jsp">Main</a></li>
				<li class="active"><a href="chart.jsp">Chart</a></li>
			</ul>
		
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class ="dropdown-toggle"
						data-toggle="dropdown" role ="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class = "caret"></span></a>
						<ul class ="dropdown-menu">
							<li class="active"><a  href ="chart.jsp">차트 보기</a></li>
							<li><a href ="member/logoutAction.jsp">로그아웃</a></li>
						</ul>
		</li>
		</ul>
		</div>
		
		</nav>
	
		<div style="text-align:right; width: 1100px; center;">
 		<h1><center>Smart Home 공기 데이터</center></h1><br>

 

  

    	<font size=2>

    	<font color=blue><center>집 안의 공기 데이터들의 한시간 주기의 평균값 입니다.</center></font>

    	</font>
		<br>
		<font size=2><
    	<font color=red><center>update : <span id="clock"></center></span></font><br>
	</font>
   	 </div>





    <div id="Line_Controls_Chart">

        <!-- 라인 차트 생성할 영역 -->

        <div id="lineChartArea" style="padding:0px 20px 0px 0px;"></div>

        <!-- 컨트롤바를 생성할 영역 -->

  	<div id="controlsArea" style="padding:0px 20px 0px 0px;"></div>

    </div>

</body>
<script>

  function printTime() {

    var clock = document.getElementById("clock"); // 출력할 장소 선택

    var now = new Date();                         // 현재시간

    var nowTime = now.getFullYear() + "." + (now.getMonth()+1) + "." + now.getDate() + " " + now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds();

    clock.innerHTML = nowTime;      // 현재시간을 출력

  }

  window.onload = function() {         // 페이지가 로딩되면 실행

    printTime();

  }

  </script>

</head>



  <script>

  

  var chartDrowFun = {



    chartDrow : function(){

    	var queryObject ="";
    	var queryObjectLen ="";
    	
    	$.ajax({
    	   type : "POST",
    	   url : "data.jsp",
    	   dataType : "json",
    	   success : function(data) {
    		   queryObject = eval('(' + JSON.stringify(data,null, 2) + ')');    
    		   queryObjectLen = queryObject.dustlist.length;
    	       
    	      
    	       //alert('Total lines : ' + queryObjectLen + 'EA');
    	   },
    	   error : function(xhr, type, textStatus) {
    	   //alert('server error occoured')
    	  alert('server msg : ' + xhr.status)
    	  alert(textStatus)
    	   }
    	});


        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.

        //var chartDateformat 	= 'yyyy년MM월dd일';

        var chartDateformat 	= 'M.dd. HH:MM';

        //라인차트의 라인 수

        var chartLineCount    = 10;

        //컨트롤러 바 차트의 라인 수

        var controlLineCount	= 10;
 
 
        function drawDashboard() {
       	 
            var data = new google.visualization.DataTable();
            //그래프에 표시할 컬럼 추가
         	  data.addColumn('datetime' , '날짜');
            data.addColumn('number'   , '미세먼지');
            data.addColumn('number'   , '초미세먼지');
            data.addColumn('number'   , '온도');
            data.addColumn('number'   , '습도');
            data.addColumn('number'   , '일산화탄소');

   
            //그래프에 표시할 데이터
     
   				  for (var i = 0; i < queryObjectLen; i++) {

                var date = queryObject.dustlist[i].date;

                var dust1 = queryObject.dustlist[i].dust1;

                var dust2 = queryObject.dustlist[i].dust2;

                var temp = queryObject.dustlist[i].temp;

                var hum = queryObject.dustlist[i].hum;
                
                var co = queryObject.dustlist[i].co;

  	      //alert(mdatecreated + ' ' + Drnpm10Value + ' ' + Drnpm25Value + ' ' + pm10Value + ' ' + pm25Value);
                data.addRows([[ new Date(date), dust1, dust2, temp, hum, co]]);

            }
 
 
   				 var chart = new google.visualization.ChartWrapper({

   	              chartType   : 'LineChart',

   	              containerId : 'lineChartArea', //라인 차트 생성할 영역

   	              options     : {

   	                  isStacked   : 'percent',

   	                  focusTarget : 'category',

   	                  height      : 500,

   	                  width	      : '100%',

   	                  legend      : { position: "top", textStyle: {fontSize: 13}},

   	                  pointSize   : 5,

   	                  tooltip     : {textStyle : {fontSize:12}, showColorCode : true,trigger: 'both'},

   	                  hAxis	: {format: chartDateformat, gridlines:{count:chartLineCount,units: {

   	                      years : {format: ['yyyy년']},

   	                      months: {format: ['MM월']},

   	                      days  : {format: ['dd일']},

   	                      hours : {format: ['HH시']}}

   	                      },textStyle: {fontSize:12}},

   	                 vAxis : {minValue: 120,viewWindow:{min:0},gridlines:{count:-1},textStyle:{fontSize:12}},

   	                 animation  : {startup: true,duration: 1000,easing: 'in' },

   	                 annotations: {pattern: chartDateformat,

   	                      textStyle: {

   	                      fontSize: 15,

   	                      bold: true,

   	                      italic: true,

   	                      color: '#871b47',

   	                      auraColor: '#d799ae',

   	                      opacity: 0.8,

   	                      pattern: chartDateformat

   	                      }

   	                  }

   	              }

   	          });

 
            var control = new google.visualization.ControlWrapper({
              controlType: 'ChartRangeFilter',
              containerId: 'controlsArea',  //control bar를 생성할 영역
              options: {
                  ui:{
                        chartType: 'LineChart',
                        chartOptions: {
                        chartArea: {'width': '60%','height' : 80},
                          hAxis: {'baselineColor': 'none', format: chartDateformat, textStyle: {fontSize:12},
                            gridlines:{count:controlLineCount,units: {
                                  years : {format: ['yyyy년']},
                                  months: {format: ['MM월']},
                                  days  : {format: ['dd일']},
                                  hours : {format: ['HH시']}}
                            }}
                        }
                  },
                    filterColumnIndex: 0
                }
            });
 
            var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat});
            date_formatter.format(data, 0);
 
            var dashboard = new google.visualization.Dashboard(document.getElementById('Line_Controls_Chart'));
            window.addEventListener('resize', function() { dashboard.draw(data); }, false); //화면 크기에 따라 그래프 크기 변경
            dashboard.bind([control], [chart]);
            dashboard.draw(data);
 
        }
          google.charts.setOnLoadCallback(drawDashboard);
 
      }
    }
 
 $(document).ready(function(){

	    google.charts.load('current', {

	       'packages':['line','controls']

	    });

	    chartDrowFun.chartDrow(); //chartDrow() 실행

	});
  </script>

<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</html>