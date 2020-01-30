<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
 #adminMember {
 	/* border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 
 #adminMemberChartBTN{   
 	color: #F7323F;
 }
 
.memberchart_table > table {   
	border-collapse: collapse;
	border: solid 1px black;
	margin: 0 auto;
	width: 80%;
}
     
.memberchart_table td {   
	border: solid 1px black;
}
	
</style>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<script>
	$(document).ready(function(){
	
		$("#adminMemberListBTN").bind("mouseover", function(){	
			$("#adminMemberListBTN").css({"color":"white","background-color":"#F7323F"});
		})
		$("#adminMemberListBTN").bind("mouseout", function(){
			$("#adminMemberListBTN").css({"color":"rgba(0,0,0,0.56)","background-color":"white"});
		}) 
		
		$("#adminMemberChartBTN").bind("mouseover", function(){	
			$("#adminMemberChartBTN").css({"color":"white","background-color":"#F7323F"});
		})
		$("#adminMemberChartBTN").bind("mouseout", function(){	
			$("#adminMemberChartBTN").css({"color":"#F7323F","background-color":"white"});
		})

	    // 차트 생성
	    chart_Member();
		chart_Age();
		chart_Gender();
		
		chart_MonthlyTrend('age'); 
		$("#searchType").bind("change",function(){
			chart_MonthlyTrend($(this).val()); 
		})
		
	})
	
	function chart_Member(){
	
		  $.ajax({
			   url: "/bestchoice/chartMemberCount.bc",
			   dataType: "JSON",
			   success:function(json){
				   
				     var resultMArr = [] ; // 자바스크립트에서의 배열 선언 
				     var resultFArr = [] ; // 자바스크립트에서의 배열 선언 
					 
				     var html = "<table><tr style='border: solid 1px black;text-align: center; font-weight: bold; background-color: #eee;' > "
					     html += "<td>AGE</td><td>GENDER</td><td>인원수</td><td>PERCENT</td></tr>"			
					   
					       
					 var ageMM = "";
					 var ageFF = "";
					
					for (var i = 0; i < json.length; i++) {
						 if ( json[i].age != null && json[i].gender!= null ){ 	
							 
							 var gender = "";
							 if(json[i].gender == 1){
								 gender = "남자"
							 }else {
								 gender = "여자"
							 }  
							 
							 html += "<tr style='border: solid 1px black; text-align: center;'><td style='font-weight: bold;background-color: #eee;'>" + json[i].age + "</td>"
							 html += "<td style='font-weight: bold;background-color: #eee;'>" + gender + "</td>"
							 html += "<td>" + json[i].count + "&nbsp;명</td><td>" + Number(json[i].PERCENTAGE) + "&nbsp;%</td></tr>"	 
						 }
					  }
						
					 html += "</table>";	
					 $("#memberTable").html(html);
					 
					 for (var i = 0; i < json.length; i++) {
						 if ( json[i].age != null && json[i].gender == 1 ){ 	
							 ageMM += json[i].age; 
						 }
						 if (json[i].age!= null && json[i].gender == 2){
							 ageFF += json[i].age;
						 }
					  }	 
					  
					 var bool10 = ageMM.includes('10');
			         if (bool10){
			        	 for (var i = 0; i < json.length; i++) {
			        	 	if(json[i].age == 10 && json[i].gender==1){
			        	 		var obj = { name : 10, 
			   			    	             y: Number(-json[i].PERCENTAGE) }; 
			        	 	}
			        	 }	
			        	 resultMArr.push(obj); 
			         }else {
			        	 var obj = { name : 10, 
					    	             y: 0.0 }; 
			        	 resultMArr.push(obj);
			         }
					
				     var bool20 = ageMM.includes('20')
				     if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender==1){
				        	 		var obj =  { name : 20, 
				   			    	             y: Number(-json[i].PERCENTAGE) }; 
				        	 	}
				        	 }
				    	 resultMArr.push(obj);
			         }else {
			        	 var obj =  { name : 20, 
					    	            y: 0.0 };
			        	 resultMArr.push(obj);
			         }
				     
				     var bool30 = ageMM.includes('30')
				     if (bool30){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender==1){
				        	 		var obj =  { name : 30, 
				   			    	             y: Number(-json[i].PERCENTAGE) }; 
				        	 	}
				        	 }	
				    	 resultMArr.push(obj);
			         }else {
			        	 var obj = { name : 30, 
					    	      y: 0.0 }; 
			        	 resultMArr.push(obj);
			         }
				     
			         var bool40 = ageMM.includes('40');
			         if (bool40){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender==1){
				        	 		var obj =  { name : 40, 
				   			    	             y: Number(-json[i].PERCENTAGE) }; 
				        	 	}
				        	 }	
				    	 resultMArr.push(obj);
			         }else {
			        	 var obj = { name : 40, 
					    	      y: 0.0 }; 
			        	 resultMArr.push(obj);
			         }
			         
			         var bool50 = ageMM.includes('50');
			         if (bool50){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender==1){
				        	 		var obj =  { name : 50, 
				   			    	             y: Number(-json[i].PERCENTAGE) }; 
				        	 	}
				        	 }	
				    	 resultMArr.push(obj);
			         }else {
			        	 var obj = { name : 50, 
					    	      y: 0.0 }; 
			        	 resultMArr.push(obj);
			         }
			         
			         var bool60 = ageMM.includes('60');
			         if (bool60){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender==1){
				        	 		var obj =  { name : 60, 
				   			    	             y: Number(-json[i].PERCENTAGE) }; 
				        	 	}
				        	 }	
				    	 resultMArr.push(obj);
			         }else {
			        	 var obj =  { name : 60, 
					    	      y: 0.0 }; 
			        	 resultMArr.push(obj);
			         }
			         
			         var bool70 = ageMM.includes('70');
			         var bool80 = ageMM.includes('80');
			         if (bool70 || bool80){
			        	 var agepnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender==1){
				        	 		agepnt +=  Number(json[i].PERCENTAGE);
				        	 	}
				        	 }	
				    	 var obj =  { name : 70 , 
   			    	                     y: -agepnt }; 
				    	 resultMArr.push(obj);
			         }else {
			        	 var obj =  { name : 70, 
					    	      y: 0.0 }; 
			        	 resultMArr.push(obj); 
			         }
			           
			         /////////////////////////////
			         var boolF10 = ageFF.includes('10')
			         if (boolF10){
			        	 for (var i = 0; i < json.length; i++) {
			        	 	if(json[i].age == 10 && json[i].gender==2){
			        	 		var obj =  { name : 10, 
			   			    	             y: Number(json[i].PERCENTAGE) }; 
			        	 	}
			        	 }	
			        	 resultFArr.push(obj); 
			         }else {
			        	 var obj =  { name : 10, 
					    	      y: 0.0 }; 
			        	 resultFArr.push(obj);
			         }
					       
				     var boolF20 = ageFF.includes('20')
				     if (boolF20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender==2){
				        	 		var obj =  { name : 20, 
				   			    	             y: Number(json[i].PERCENTAGE) }; 
				        	 	}
				        	 }
				    	 resultFArr.push(obj);
			         }else {
			        	 var obj =   { name : 20, 
					    	      y: 0.0 };
			        	 resultFArr.push(obj);
			         }
				     
				     var boolF30 = ageFF.includes('30')
				     if (boolF30){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender==2){
				        	 		var obj = { name : 30, 
				   			    	             y: Number(json[i].PERCENTAGE) }; 
				        	 	}
				        	 }	
				    	 resultFArr.push(obj);
			         }else {
			        	 var obj =  { name : 30, 
					    	      y: 0.0 }; 
			        	 resultFArr.push(obj);
			         }
				     
			         var boolF40 = ageFF.includes('40');
			         if (boolF40){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender==2){
				        	 		var obj =  { name : 40, 
				   			    	             y: Number(json[i].PERCENTAGE) }; 
				        	 	}
				        	 }	
				    	 resultFArr.push(obj);
			         }else {
			        	 var obj =  { name : 40, 
					    	      y: 0.0 }; 
			        	 resultFArr.push(obj);
			         }
			         
			         var boolF50 = ageFF.includes('50');
			         if (boolF50){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender==2){
				        	 		var obj =  { name : 50, 
				   			    	             y: Number(json[i].PERCENTAGE) }; 
				        	 	}
				        	 }	
				    	 resultFArr.push(obj);
			         }else {
			        	 var obj =  { name : 50, 
					    	      y: 0.0 }; 
			        	 resultFArr.push(obj);
			         }
			         
			         var boolF60 = ageFF.includes('60');
			         if (boolF60){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender==2){
				        	 		var obj =  { name : 60, 
				   			    	             y: Number(json[i].PERCENTAGE) }; 
				        	 	}
				        	 }	
				    	 resultFArr.push(obj);
			         }else {
			        	 var obj =  { name : 60, 
					    	      y: 0.0 }; 
			        	 resultFArr.push(obj);
			        	 
			         }
			         
			         var boolF70 = ageFF.includes('70');
			         var boolF80 = ageFF.includes('80');
			         if (boolF70 || boolF80 ){
			        	 var agepnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender==2){
				        	 		agepnt +=  Number(json[i].PERCENTAGE);
				        	 	}
				        	 }	
				    	 var obj =  { name : 70 , 
   			    	                     y: agepnt }; 
				    	 resultFArr.push(obj);
			         }else {
			        	 var obj =  { name : 70, 
					    	      y: 0.0 }; 
			        	 resultFArr.push(obj);
			         }
				    
		         
				   var categories = [ '0-19','20-29', '30-39', '40-49', '50-59', '60-69', '70 +'];   
	
				   Highcharts.chart('memberChart', {
					    chart: {
					        type: 'bar'
					    },
					    title: { 
					        text: ''
					    },
					    subtitle: {
					        text: ''
					    },
					    accessibility: {
					        point: {
					            descriptionFormatter: function (point) {
					                var index = point.index + 1,
					                    category = point.category,
					                    val = Math.abs(point.y),
					                    series = point.series.name;

					                return index + ', Age ' + category + ', ' + val + '%. ' + series + '.';
					            }
					        }
					    },
					    xAxis: [{
					        categories: categories,
					        reversed: false,
					        labels: {
					            step: 1
					        },
					        accessibility: {
					            description: 'Age (male)'
					        }
					    }, { // mirror axis on right side
					        opposite: true,
					        reversed: false,
					        categories: categories,
					        linkedTo: 0,
					        labels: {
					            step: 1
					        },
					        accessibility: {
					            description: 'Age (female)'
					        }
					    }],
					    yAxis: {
					    	tickPositions: [-50,-40,-30,-20,-10,0, 10, 20, 30, 40,50],
					        title: {
					            text: null
					        },
					        labels: {
					            formatter: function () {
					                return Math.abs(this.value) + '%';
					            }
					        },
					        accessibility: {
					            /* description: 'Percentage population',
					            rangeDescription: 'Range: 0 to 5%' */
					        }
					    },

					    plotOptions: {
					        series: {
					            stacking: 'normal'
					        }
					    },
					    tooltip: {
					        formatter: function () {
					            return '<b>' + this.series.name + ', age ' + this.point.category + '</b><br/>' +
					                'Population: ' + Highcharts.numberFormat(Math.abs(this.point.y), 1) + '%';
					        }
					    },
					    series: [{
					        name: '남자',
					        data: resultMArr
					    }, {
					        name: '여자',
					        data: resultFArr
					    }]
					});
	
			   },
			   error: function(request, status, error){
			   	 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			   } 
		  })	
	}
	
	function chart_Age(){
	   $.ajax({
		   url: "/bestchoice/chartMemberCount.bc",
		   dataType: "JSON",
		   success:function(json){
			   
			   var resultArr = [] ; // 자바스크립트에서의 배열 선언 
				
			   var html = "<table><tr style='border: solid 1px black;text-align: center; font-weight: bold; background-color: #eee;' > "
			       html += "<td>AGE</td><td>인원수</td><td>PERCENT</td></tr>"			
			   
	    	   var age70 = "70대이상";
			   var agepnt = 0;
			   var count = 0;
			   for (var i = 0; i < json.length; i++) {
				   
			   		if ( json[i].age!= null && json[i].age < 70 && json[i].gender == null) {
						// 자바스크립트에서의 객체 선언 
						
						var age = "";
						age = json[i].age + "대";
						
						var obj = { name : age, 
								    y: Number(json[i].PERCENTAGE) };  // ★ DB에서 받을 때 문자열로 가져왔기 때문에, 다시 숫자로 바꿔야 한다!!!
						
								    
						// 배열 속에 객체 넣기   [{},{},{},...]
						resultArr.push(obj); 
								    	 
						html += "<tr style='border: solid 1px black; text-align: center;'><td style='font-weight: bold;background-color: #eee;'>" + age + "</td>"
						html += "<td>" + json[i].count + "&nbsp;명</td><td>" + Number(json[i].PERCENTAGE) + "&nbsp;%</td></tr>"	
					}else if( json[i].age>=70 && json[i].gender == null) {
		        	 	agepnt +=  Number(json[i].PERCENTAGE);
		        	 	count += Number(json[i].count);
					}    
			   }
			   var obj = { name : age70, 
					    y : agepnt };  // ★ DB에서 받을 때 문자열로 가져왔기 때문에, 다시 숫자로 바꿔야 한다!!!
			
		       resultArr.push(obj);
			
				html += "<tr style='border: solid 1px black; text-align: center;'><td style='font-weight: bold;background-color: #eee;'>" + age70 + "</td>"
				html += "<td>" + count + "&nbsp;명</td><td>" + agepnt + "&nbsp;%</td></tr>"	
			       
			   html += "</table>"
			   $("#ageTable").html(html);
			   
			   var pieColors = (function () {
				   var colors = [];
				   //colors.push("#e580ff","orange","#8cd98c","#8585e0","#ff6666","#a3a3c2","#66ccff");
				   colors.push("red","orange","yellow","green","blue","navy","purple");
				    return colors;
				}());
				
			   // Build the chart
			   Highcharts.chart('ageChart', {
			       chart: {
			           plotBackgroundColor: null,
			           plotBorderWidth: null,
			           plotShadow: false,
			           type: 'pie'
			       },
			       title: {
			           text: ''
			       },
			       tooltip: {
			           pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			       },
			       accessibility: {
			           point: {
			               valueSuffix: '%'
			           }
			       },
			       plotOptions: {
			           pie: {
			               allowPointSelect: true,
			               cursor: 'pointer',
			               colors: pieColors,
			               dataLabels: {
			                   enabled: true,
			                   format: '<span>{point.name}</span><br>{point.percentage:.1f} %',
			                   distance: -50,
			                   filter: {
			                       property: 'percentage',
			                       operator: '>',
			                       value: 4
			                   }
			               }
			           }
			       },
			       series: [{
			           name: '비율',
			           data: resultArr
			       }]
			   });
			
			   
		   },
		   error: function(request, status, error){
		   	 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   } 
	   })   
   }

   function chart_Gender(){
	   
	   $.ajax({
		   url: "/bestchoice/chartMemberCount.bc",
		   dataType: "JSON",
		   success:function(json){
			   
			   var resultArr = [] ; // 자바스크립트에서의 배열 선언 
				
			   var html = "<table><tr style='border: solid 1px black;text-align: center; font-weight: bold; background-color: #eee;' > "
			       html += "<td>AGE</td><td>인원수</td><td>PERCENT</td></tr>"			
			   
			   for (var i = 0; i < json.length; i++) {
				   
			   		if ( json[i].age== null && json[i].gender != null) {
						// 자바스크립트에서의 객체 선언 
						
						var gender = "";
						if(json[i].gender == 1){ 
							gender = "남자";
						}
						else {
							gender = "여자";
						}
							var obj = { name : gender, 
								    	 y: Number(json[i].PERCENTAGE) };  // ★ DB에서 받을 때 문자열로 가져왔기 때문에, 다시 숫자로 바꿔야 한다!!!
			   			
						// 배열 속에 객체 넣기   [{},{},{},...]
						resultArr.push(obj); 
								    	 
						html += "<tr style='border: solid 1px black; text-align: center;'><td style='font-weight: bold;background-color: #eee;'>" + gender + "</td>"
						html += "<td>" + json[i].count + "&nbsp;명</td><td>" + Number(json[i].PERCENTAGE) + "&nbsp;%</td></tr>"	
					}  
			   }
			  
			   html += "</table>"
			   $("#genderTable").html(html);
			   
			   var pieColors = (function () {
				   var colors = [];
				   colors.push("#85e085","#b3ccff");
				    return colors;
				}());
				
			   // Build the chart
			   Highcharts.chart('genderChart', {
			       chart: {
			           plotBackgroundColor: null,
			           plotBorderWidth: null,
			           plotShadow: false,
			           type: 'pie'
			       },
			       title: {
			           text: ''
			       },
			       tooltip: {
			           pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			       },
			       accessibility: {
			           point: {
			               valueSuffix: '%'
			           }
			       },
			       plotOptions: {
			           pie: {
			               allowPointSelect: true,
			               cursor: 'pointer',
			               colors: pieColors,
			               dataLabels: {
			                   enabled: true,
			                   format: '<span>{point.name}</span><br>{point.percentage:.1f} %',
			                   distance: -50,
			                   filter: {
			                       property: 'percentage',
			                       operator: '>',
			                       value: 4
			                   }
			               }
			           }
			       },
			       series: [{
			           name: '비율',
			           data: resultArr
			       }]
			   });
			
			   
		   },
		   error: function(request, status, error){
		   	 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   } 
	   })   
   }	

   function chart_MonthlyTrend(searchTypeVal){
	   switch(searchTypeVal) {
		/* 
		case "": 
			$("#chart_monthlyTrend").empty();
			break;
		 */	
		case "age" :
			$.ajax({
				url: "/bestchoice/chartMemberTrend.bc",
				dataType: "JSON",
				success:function(json){
					
					$("#chart_monthlyTrend").empty();  // 차트 자리 비우기 (이전 차트 삭제)
					
					var resultArr10 = [] ; 
					var resultArr20 = [] ;
					var resultArr30 = [] ;
					var resultArr40 = [] ;
					var resultArr50 = [] ;
					var resultArr60 = [] ;
					var resultArr70 = [] ;
				
					var age10Day = "";
					for (var i = 0; i < json.length; i++) {						
						 if ( json[i].age == 10 && json[i].gender == null && json[i].registerday != null ){ 	
							 age10Day += json[i].registerday; 
						 }
					}	
					
					var bool10 = age10Day.includes('2019-03');
				    if (bool10){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 10 && json[i].gender == null && json[i].registerday == '2019-03'){
				        	 		var obj =  { name : 10, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr10.push(obj);
			        }else {
			        	 var obj =  { name :10, 
					    	      y: 0.0 }; 
			        	 resultArr10.push(obj);
			        } 
				    
				    var bool10 = age10Day.includes('2019-04');
				    if (bool10){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 10 && json[i].gender == null && json[i].registerday == '2019-04'){
				        	 		var obj =  { name : 10, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr10.push(obj);
			        }else {
			        	 var obj =  { name : 10, 
					    	      y: 0.0 }; 
			        	 resultArr10.push(obj);
			        } 
				    
				    var bool10 = age10Day.includes('2019-05');
				    if (bool10){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 10 && json[i].gender == null && json[i].registerday == '2019-05'){
				        	 		var obj =  { name : 10, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr10.push(obj);
			        }else {
			        	 var obj =  { name : 10, 
					    	      y: 0.0 }; 
			        	 resultArr10.push(obj);
			        } 
				    
				    var bool10 = age10Day.includes('2019-06');
				    if (bool10){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 10 && json[i].gender == null && json[i].registerday == '2019-06'){
				        	 		var obj =  { name : 10, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr10.push(obj);
			        }else {
			        	 var obj =  { name : 10, 
					    	      y: 0.0 }; 
			        	 resultArr10.push(obj);
			        } 
				    
				    var bool10 = age10Day.includes('2019-07');
				    if (bool10){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 10 && json[i].gender == null && json[i].registerday == '2019-07'){
				        	 		var obj =  { name : 10, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr10.push(obj);
			        }else {
			        	 var obj =  { name :10, 
					    	      y: 0.0 }; 
			        	 resultArr10.push(obj);
			        } 
				    
				    var bool20 = age10Day.includes('2019-08');
				    if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 10 && json[i].gender == null && json[i].registerday == '2019-08'){
				        	 		var obj =  { name : 10, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr10.push(obj);
			        }else {
			        	 var obj =  { name : 10, 
					    	      y: 0.0 }; 
			        	 resultArr10.push(obj);
			        } 
				    
				    var bool10 = age10Day.includes('2019-09');
				    if (bool10){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 10 && json[i].gender == null && json[i].registerday == '2019-09'){
				        	 		var obj =  { name : 10, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr10.push(obj);
			        }else {
			        	 var obj =  { name : 10, 
					    	      y: 0.0 }; 
			        	 resultArr10.push(obj);
			        }
				    
				    var bool10 = age10Day.includes('2019-10');
				    if (bool10){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 10 && json[i].gender == null && json[i].registerday == '2019-10'){
				        	 		var obj =  { name : 10, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr10.push(obj);
			        }else {
			        	 var obj =  { name : 10, 
					    	      y: 0.0 }; 
			        	 resultArr10.push(obj);
			        }	 
			        
				    var bool10 = age10Day.includes('2019-11');
				    if (bool10){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 10 && json[i].gender == null && json[i].registerday == '2019-11'){
				        	 		var obj =  { name : 10, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr10.push(obj);
			        }else {
			        	 var obj =  { name :10, 
					    	      y: 0.0 }; 
			        	 resultArr10.push(obj);
			        }	 
				    
				
				    var bool10 = age10Day.includes('2019-12');
				    if (bool10){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 10 && json[i].gender == null && json[i].registerday == '2019-12'){
				        	 		var obj =  { name : 10, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr10.push(obj);
			        }else {
			        	 var obj =  { name : 10, 
					    	      y: 0.0 }; 
			        	 resultArr10.push(obj);
			        }	 
				    
				    var bool10 = age10Day.includes('2020-01');
				    if (bool10){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 10 && json[i].gender == null && json[i].registerday == '2020-01'){
				        	 		var obj =  { name : 10, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr10.push(obj);
			        }else {
			        	 var obj =  { name : 10, 
					    	      y: 0.0 }; 
			        	 resultArr10.push(obj);
			        }	 
				    
				    var bool10 = age10Day.includes('2020-02');
				    if (bool10){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 10 && json[i].gender == null && json[i].registerday == '2020-02'){
				        	 		var obj =  { name : 10, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr10.push(obj);
			        }else {
			        	 var obj =  { name : 10, 
					    	      y: 0.0 }; 
			        	 resultArr10.push(obj);
			        }	 
				    ///// end 10 
				    
					var age20Day = "";
					for (var i = 0; i < json.length; i++) {						
						 if ( json[i].age == 20 && json[i].gender == null && json[i].registerday != null ){ 	
							 age20Day += json[i].registerday; 
						 }
					}	
					
					var bool20 = age20Day.includes('2019-03');
				    if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender == null && json[i].registerday == '2019-03'){
				        	 		var obj =  { name : 20, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr20.push(obj);
			        }else {
			        	 var obj =  { name : 20, 
					    	      y: 0.0 }; 
			        	 resultArr20.push(obj);
			        } 
				    
				    var bool20 = age20Day.includes('2019-04');
				    if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender == null && json[i].registerday == '2019-04'){
				        	 		var obj =  { name : 20, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr20.push(obj);
			        }else {
			        	 var obj =  { name : 20, 
					    	      y: 0.0 }; 
			        	 resultArr20.push(obj);
			        } 
				    
				    var bool20 = age20Day.includes('2019-05');
				    if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender == null && json[i].registerday == '2019-05'){
				        	 		var obj =  { name : 20, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr20.push(obj);
			        }else {
			        	 var obj =  { name : 20, 
					    	      y: 0.0 }; 
			        	 resultArr20.push(obj);
			        } 
				    
				    var bool20 = age20Day.includes('2019-06');
				    if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender == null && json[i].registerday == '2019-06'){
				        	 		var obj =  { name : 20, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr20.push(obj);
			        }else {
			        	 var obj =  { name : 20, 
					    	      y: 0.0 }; 
			        	 resultArr20.push(obj);
			        } 
				    
				    var bool20 = age20Day.includes('2019-07');
				    if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender == null && json[i].registerday == '2019-07'){
				        	 		var obj =  { name : 20, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr20.push(obj);
			        }else {
			        	 var obj =  { name : 20, 
					    	      y: 0.0 }; 
			        	 resultArr20.push(obj);
			        } 
				    
				    var bool20 = age20Day.includes('2019-08');
				    if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender == null && json[i].registerday == '2019-08'){
				        	 		var obj =  { name : 20, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr20.push(obj);
			        }else {
			        	 var obj =  { name : 20, 
					    	      y: 0.0 }; 
			        	 resultArr20.push(obj);
			        } 
				    
				    var bool20 = age20Day.includes('2019-09');
				    if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender == null && json[i].registerday == '2019-09'){
				        	 		var obj =  { name : 20, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr20.push(obj);
			        }else {
			        	 var obj =  { name : 20, 
					    	      y: 0.0 }; 
			        	 resultArr20.push(obj);
			        }
				    
				    var bool20 = age20Day.includes('2019-10');
				    if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender == null && json[i].registerday == '2019-10'){
				        	 		var obj =  { name : 20, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr20.push(obj);
			        }else {
			        	 var obj =  { name : 20, 
					    	      y: 0.0 }; 
			        	 resultArr20.push(obj);
			        }	 
			        
				    var bool20 = age20Day.includes('2019-11');
				    if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender == null && json[i].registerday == '2019-11'){
				        	 		var obj =  { name : 20, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr20.push(obj);
			        }else {
			        	 var obj =  { name : 20, 
					    	      y: 0.0 }; 
			        	 resultArr20.push(obj);
			        }	 
				    
				    var bool20 = age20Day.includes('2019-12');
				    if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender == null && json[i].registerday == '2019-12'){
				        	 		var obj =  { name : 20, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr20.push(obj);
			        }else {
			        	 var obj =  { name : 20, 
					    	      y: 0.0 }; 
			        	 resultArr20.push(obj);
			        }	 
				    
				    var bool20 = age20Day.includes('2020-01');
				    if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender == null && json[i].registerday == '2020-01'){
				        	 		var obj =  { name : 20, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr20.push(obj);
			        }else {
			        	 var obj =  { name : 20, 
					    	      y: 0.0 }; 
			        	 resultArr20.push(obj);
			        }	 
				    
				    var bool20 = age20Day.includes('2020-02');
				    if (bool20){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 20 && json[i].gender == null && json[i].registerday == '2020-02'){
				        	 		var obj =  { name : 20, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr20.push(obj);
			        }else {
			        	 var obj =  { name : 20, 
					    	      y: 0.0 }; 
			        	 resultArr20.push(obj);
			        }	 
					// end 20
						
					var ageDay = "";
					for (var i = 0; i < json.length; i++) {						
						 if ( json[i].age == 30 && json[i].gender == null && json[i].registerday != null ){ 	
							 ageDay += json[i].registerday; 
						 }
					}	
				    var bool = ageDay.includes('2019-03');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender == null && json[i].registerday == '2019-03'){
				        	 		var obj =  { name : 30, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr30.push(obj);
			        }else {
			        	 var obj =  { name :30, 
					    	      y: 0.0 }; 
			        	 resultArr30.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-04');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender == null && json[i].registerday == '2019-04'){
				        	 		var obj =  { name : 30, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr30.push(obj);
			        }else {
			        	 var obj =  { name : 30, 
					    	      y: 0.0 }; 
			        	 resultArr30.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-05');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender == null && json[i].registerday == '2019-05'){
				        	 		var obj =  { name : 30, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr30.push(obj);
			        }else {
			        	 var obj =  { name : 30, 
					    	      y: 0.0 }; 
			        	 resultArr30.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-06');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender == null && json[i].registerday == '2019-06'){
				        	 		var obj =  { name : 30, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr30.push(obj);
			        }else {
			        	 var obj =  { name : 30, 
					    	      y: 0.0 }; 
			        	 resultArr30.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-07');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender == null && json[i].registerday == '2019-07'){
				        	 		var obj =  { name : 30, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr30.push(obj);
			        }else {
			        	 var obj =  { name :30, 
					    	      y: 0.0 }; 
			        	 resultArr30.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-08');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender == null && json[i].registerday == '2019-08'){
				        	 		var obj =  { name : 30, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr30.push(obj);
			        }else {
			        	 var obj =  { name : 30, 
					    	      y: 0.0 }; 
			        	 resultArr30.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-09');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender == null && json[i].registerday == '2019-09'){
				        	 		var obj =  { name : 30, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr30.push(obj);
			        }else {
			        	 var obj =  { name : 30, 
					    	      y: 0.0 }; 
			        	 resultArr30.push(obj);
			        }
				    
				    var bool = ageDay.includes('2019-10');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender == null && json[i].registerday == '2019-10'){
				        	 		var obj =  { name : 30, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr30.push(obj);
			        }else {
			        	 var obj =  { name : 30, 
					    	      y: 0.0 }; 
			        	 resultArr30.push(obj);
			        }	 
			        
				    var bool = ageDay.includes('2019-11');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender == null && json[i].registerday == '2019-11'){
				        	 		var obj =  { name : 30, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr30.push(obj);
			        }else {
			        	 var obj =  { name :30, 
					    	      y: 0.0 }; 
			        	 resultArr30.push(obj);
			        }	 
				    
				    
				    var bool = ageDay.includes('2019-12');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender == null && json[i].registerday == '2019-12'){
				        	 		var obj =  { name : 30, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr30.push(obj);
			        }else {
			        	 var obj =  { name : 30, 
					    	      y: 0.0 }; 
			        	 resultArr30.push(obj);
			        }	 
				    
				    var bool = ageDay.includes('2020-01');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender == null && json[i].registerday == '2020-01'){
				        	 		var obj =  { name : 30, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr30.push(obj);
			        }else {
			        	 var obj =  { name : 30, 
					    	      y: 0.0 }; 
			        	 resultArr30.push(obj);
			        }	 
				    
				    var bool = ageDay.includes('2020-02');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 30 && json[i].gender == null && json[i].registerday == '2020-02'){
				        	 		var obj =  { name : 30, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr30.push(obj);
			        }else {
			        	 var obj =  { name : 30, 
					    	      y: 0.0 }; 
			        	 resultArr30.push(obj);
			        }	 
				    /// end 30
					
					var ageDay = "";
					for (var i = 0; i < json.length; i++) {						
						 if ( json[i].age == 40 && json[i].gender == null && json[i].registerday != null ){ 	
							 ageDay += json[i].registerday; 
						 }
					}	
				    var bool = ageDay.includes('2019-03');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender == null && json[i].registerday == '2019-03'){
				        	 		var obj =  { name : 40, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr40.push(obj);
			        }else {
			        	 var obj =  { name :40, 
					    	      y: 0.0 }; 
			        	 resultArr40.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-04');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender == null && json[i].registerday == '2019-04'){
				        	 		var obj =  { name : 40, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr40.push(obj);
			        }else {
			        	 var obj =  { name : 40, 
					    	      y: 0.0 }; 
			        	 resultArr40.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-05');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender == null && json[i].registerday == '2019-05'){
				        	 		var obj =  { name : 40, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr40.push(obj);
			        }else {
			        	 var obj =  { name : 40, 
					    	      y: 0.0 }; 
			        	 resultArr40.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-06');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender == null && json[i].registerday == '2019-06'){
				        	 		var obj =  { name : 40, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr40.push(obj);
			        }else {
			        	 var obj =  { name : 40, 
					    	      y: 0.0 }; 
			        	 resultArr40.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-07');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender == null && json[i].registerday == '2019-07'){
				        	 		var obj =  { name : 40, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr40.push(obj);
			        }else {
			        	 var obj =  { name :40, 
					    	      y: 0.0 }; 
			        	 resultArr40.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-08');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender == null && json[i].registerday == '2019-08'){
				        	 		var obj =  { name : 40, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr40.push(obj);
			        }else {
			        	 var obj =  { name : 40, 
					    	      y: 0.0 }; 
			        	 resultArr40.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-09');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender == null && json[i].registerday == '2019-09'){
				        	 		var obj =  { name : 40, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr40.push(obj);
			        }else {
			        	 var obj =  { name : 40, 
					    	      y: 0.0 }; 
			        	 resultArr40.push(obj);
			        }
				    
				    var bool = ageDay.includes('2019-10');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender == null && json[i].registerday == '2019-10'){
				        	 		var obj =  { name : 40, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr40.push(obj);
			        }else {
			        	 var obj =  { name : 40, 
					    	      y: 0.0 }; 
			        	 resultArr40.push(obj);
			        }	 
			        
				    var bool = ageDay.includes('2019-11');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender == null && json[i].registerday == '2019-11'){
				        	 		var obj =  { name : 40, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr40.push(obj);
			        }else {
			        	 var obj =  { name :40, 
					    	      y: 0.0 }; 
			        	 resultArr40.push(obj);
			        }	 
				    
				   
				    var bool = ageDay.includes('2019-12');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender == null && json[i].registerday == '2019-12'){
				        	 		var obj =  { name : 40, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr40.push(obj);
			        }else {
			        	 var obj =  { name : 40, 
					    	      y: 0.0 }; 
			        	 resultArr40.push(obj);
			        }	 
				    
				    var bool = ageDay.includes('2020-01');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender == null && json[i].registerday == '2020-01'){
				        	 		var obj =  { name : 40, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr40.push(obj);
			        }else {
			        	 var obj =  { name : 40, 
					    	      y: 0.0 }; 
			        	 resultArr40.push(obj);
			        }	 
				    
				    var bool = ageDay.includes('2020-02');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 40 && json[i].gender == null && json[i].registerday == '2020-02'){
				        	 		var obj =  { name : 40, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr40.push(obj);
			        }else {
			        	 var obj =  { name : 40, 
					    	      y: 0.0 }; 
			        	 resultArr40.push(obj);
			        }	 
				    
				    /// 40
				    
					var ageDay = "";
					for (var i = 0; i < json.length; i++) {						
						 if ( json[i].age == 50 && json[i].gender == null && json[i].registerday != null ){ 	
							 ageDay += json[i].registerday; 
						 }
					}	
				    var bool = ageDay.includes('2019-03');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender == null && json[i].registerday == '2019-03'){
				        	 		var obj =  { name : 50, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr50.push(obj);
			        }else {
			        	 var obj =  { name :50, 
					    	      y: 0.0 }; 
			        	 resultArr50.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-04');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender == null && json[i].registerday == '2019-04'){
				        	 		var obj =  { name : 50, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr50.push(obj);
			        }else {
			        	 var obj =  { name : 50, 
					    	      y: 0.0 }; 
			        	 resultArr50.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-05');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender == null && json[i].registerday == '2019-05'){
				        	 		var obj =  { name : 50, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr50.push(obj);
			        }else {
			        	 var obj =  { name : 50, 
					    	      y: 0.0 }; 
			        	 resultArr50.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-06');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender == null && json[i].registerday == '2019-06'){
				        	 		var obj =  { name : 50, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr50.push(obj);
			        }else {
			        	 var obj =  { name : 50, 
					    	      y: 0.0 }; 
			        	 resultArr50.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-07');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender == null && json[i].registerday == '2019-07'){
				        	 		var obj =  { name : 50, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr50.push(obj);
			        }else {
			        	 var obj =  { name :50, 
					    	      y: 0.0 }; 
			        	 resultArr50.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-08');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender == null && json[i].registerday == '2019-08'){
				        	 		var obj =  { name : 50, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr50.push(obj);
			        }else {
			        	 var obj =  { name : 50, 
					    	      y: 0.0 }; 
			        	 resultArr50.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-09');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender == null && json[i].registerday == '2019-09'){
				        	 		var obj =  { name : 50, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr50.push(obj);
			        }else {
			        	 var obj =  { name : 50, 
					    	      y: 0.0 }; 
			        	 resultArr50.push(obj);
			        }
				    
				    var bool = ageDay.includes('2019-10');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender == null && json[i].registerday == '2019-10'){
				        	 		var obj =  { name : 50, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr50.push(obj);
			        }else {
			        	 var obj =  { name : 50, 
					    	      y: 0.0 }; 
			        	 resultArr50.push(obj);
			        }	 
			        
				    var bool = ageDay.includes('2019-11');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender == null && json[i].registerday == '2019-11'){
				        	 		var obj =  { name : 50, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr50.push(obj);
			        }else {
			        	 var obj =  { name :50, 
					    	      y: 0.0 }; 
			        	 resultArr50.push(obj);
			        }	 
				  
				    var bool = ageDay.includes('2019-12');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender == null && json[i].registerday == '2019-12'){
				        	 		var obj =  { name : 50, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr50.push(obj);
			        }else {
			        	 var obj =  { name : 50, 
					    	      y: 0.0 }; 
			        	 resultArr50.push(obj);
			        }	 
				    
				    var bool = ageDay.includes('2020-01');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender == null && json[i].registerday == '2020-01'){
				        	 		var obj =  { name : 50, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr50.push(obj);
			        }else {
			        	 var obj =  { name : 50, 
					    	      y: 0.0 }; 
			        	 resultArr50.push(obj);
			        }	 
				    
				    var bool = ageDay.includes('2020-02');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 50 && json[i].gender == null && json[i].registerday == '2020-02'){
				        	 		var obj =  { name : 50, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr50.push(obj);
			        }else {
			        	 var obj =  { name : 50, 
					    	      y: 0.0 }; 
			        	 resultArr50.push(obj);
			        }	 
				    // 50 
					
					var ageDay = "";
					for (var i = 0; i < json.length; i++) {						
						 if ( json[i].age == 60 && json[i].gender == null && json[i].registerday != null ){ 	
							 ageDay += json[i].registerday; 
						 }
					}	
				    var bool = ageDay.includes('2019-03');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender == null && json[i].registerday == '2019-03'){
				        	 		var obj =  { name : 60, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr60.push(obj);
			        }else {
			        	 var obj =  { name :60, 
					    	      y: 0.0 }; 
			        	 resultArr60.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-04');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender == null && json[i].registerday == '2019-04'){
				        	 		var obj =  { name : 60, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr60.push(obj);
			        }else {
			        	 var obj =  { name : 60, 
					    	      y: 0.0 }; 
			        	 resultArr60.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-05');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender == null && json[i].registerday == '2019-05'){
				        	 		var obj =  { name : 60, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr60.push(obj);
			        }else {
			        	 var obj =  { name : 60, 
					    	      y: 0.0 }; 
			        	 resultArr60.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-06');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender == null && json[i].registerday == '2019-06'){
				        	 		var obj =  { name : 60, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr60.push(obj);
			        }else {
			        	 var obj =  { name : 60, 
					    	      y: 0.0 }; 
			        	 resultArr60.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-07');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender == null && json[i].registerday == '2019-07'){
				        	 		var obj =  { name : 60, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr60.push(obj);
			        }else {
			        	 var obj =  { name :60, 
					    	      y: 0.0 }; 
			        	 resultArr60.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-08');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender == null && json[i].registerday == '2019-08'){
				        	 		var obj =  { name : 60, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr60.push(obj);
			        }else {
			        	 var obj =  { name : 60, 
					    	      y: 0.0 }; 
			        	 resultArr60.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-09');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender == null && json[i].registerday == '2019-09'){
				        	 		var obj =  { name : 60, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr60.push(obj);
			        }else {
			        	 var obj =  { name : 60, 
					    	      y: 0.0 }; 
			        	 resultArr60.push(obj);
			        }
				    
				    var bool = ageDay.includes('2019-10');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender == null && json[i].registerday == '2019-10'){
				        	 		var obj =  { name : 60, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr60.push(obj);
			        }else {
			        	 var obj =  { name : 60, 
					    	      y: 0.0 }; 
			        	 resultArr60.push(obj);
			        }	 
			        
				    var bool = ageDay.includes('2019-11');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender == null && json[i].registerday == '2019-11'){
				        	 		var obj =  { name : 60, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr60.push(obj);
			        }else {
			        	 var obj =  { name :60, 
					    	      y: 0.0 }; 
			        	 resultArr60.push(obj);
			        }	 
				    
				   
				    var bool = ageDay.includes('2019-12');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender == null && json[i].registerday == '2019-12'){
				        	 		var obj =  { name : 60, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr60.push(obj);
			        }else {
			        	 var obj =  { name : 60, 
					    	      y: 0.0 }; 
			        	 resultArr60.push(obj);
			        }	 
				    
				    var bool = ageDay.includes('2020-01');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender == null && json[i].registerday == '2020-01'){
				        	 		var obj =  { name : 60, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr60.push(obj);
			        }else {
			        	 var obj =  { name : 60, 
					    	      y: 0.0 }; 
			        	 resultArr60.push(obj);
			        }	 
				    
				    var bool = ageDay.includes('2020-02');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == 60 && json[i].gender == null && json[i].registerday == '2020-02'){
				        	 		var obj =  { name : 60, 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArr60.push(obj);
			        }else {
			        	 var obj =  { name : 60, 
					    	      y: 0.0 }; 
			        	 resultArr60.push(obj);
			        }	 
				    // 60 
				    
					var ageDay = "";
					for (var i = 0; i < json.length; i++) {						
						 if ( json[i].age >= 70 && json[i].gender == null && json[i].registerday != null ){ 	
							 ageDay += json[i].registerday; 
						 }
					}	
				    var bool = ageDay.includes('2019-03');
				    if (bool){
				    	 var agecnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender == null && json[i].registerday == '2019-03'){
				    		 		agecnt +=  Number(json[i].count);
				        	 	}
				          }	
				    	 var obj =  { name : "70대이상" , 
		    	                     y: agecnt };
				    	 resultArr70.push(obj);
			        }else {
			        	 var obj =  { name :"70대이상", 
					    	      y: 0.0 }; 
			        	 resultArr70.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-04');
				    if (bool){
				    	 var agecnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender == null && json[i].registerday == '2019-04'){
				    		 		agecnt +=  Number(json[i].count);
				        	 	}
				          }	
				    	 var obj =  { name : "70대이상", 
		    	                     y: agecnt }
				    	 resultArr70.push(obj);
			        }else {
			        	 var obj =  { name : "70대이상", 
					    	      y: 0.0 }; 
			        	 resultArr70.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-05');
				    if (bool){
				    	 var agecnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender == null && json[i].registerday == '2019-05'){
				    		 		agecnt +=  Number(json[i].count);
				        	 	}
				          }	
				    	 var obj =  { name : "70대이상", 
		    	                     y: agecnt };
				    	 resultArr70.push(obj);
			        }else {
			        	 var obj =  { name : "70대이상", 
					    	      y: 0.0 }; 
			        	 resultArr70.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-06');
				    if (bool){
				    	 var agecnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender == null && json[i].registerday == '2019-06'){
				    		 		agecnt +=  Number(json[i].count);
				        	 	}
				          }	
				    	 var obj =  { name :"70대이상" , 
		    	                     y: agecnt };
				    	 resultArr70.push(obj);
			        }else {
			        	 var obj =  { name : "70대이상", 
					    	      y: 0.0 }; 
			        	 resultArr70.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-07');
				    if (bool){
				    	 var agecnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender == null && json[i].registerday == '2019-07'){
				    		 		agecnt +=  Number(json[i].count);
				        	 	}
				          }	
				    	 var obj =  { name : "70대이상", 
		    	                     y: agecnt };
				    	 resultArr70.push(obj);
			        }else {
			        	 var obj =  { name :"70대이상", 
					    	      y: 0.0 }; 
			        	 resultArr70.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-08');
				    if (bool){
				    	 var agecnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender == null && json[i].registerday == '2019-08'){
				    		 		agecnt +=  Number(json[i].count);
				        	 	}
				          }	
				    	 var obj =  { name : "70대이상", 
		    	                     y: agecnt };
				    	 resultArr70.push(obj);
			        }else {
			        	 var obj =  { name : "70대이상", 
					    	      y: 0.0 }; 
			        	 resultArr70.push(obj);
			        } 
				    
				    var bool = ageDay.includes('2019-09');
				    if (bool){
				    	 var agecnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender == null && json[i].registerday == '2019-09'){
				    		 		agecnt +=  Number(json[i].count);
				        	 	}
				          }	
				    	 var obj =  { name :"70대이상" , 
		    	                     y: agecnt };
				    	 resultArr70.push(obj);
			        }else {
			        	 var obj =  { name : "70대이상", 
					    	      y: 0.0 }; 
			        	 resultArr70.push(obj);
			        }
				    
				    var bool = ageDay.includes('2019-10');
				    if (bool){
				    	var agecnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender == null && json[i].registerday == '2019-10'){
				    		 		agecnt +=  Number(json[i].count);
				        	 	}
				          }	
				    	 var obj =  { name : "70대이상", 
		    	                     y: agecnt };
				    	 resultArr70.push(obj);
			        }else {
			        	 var obj =  { name : "70대이상", 
					    	      y: 0.0 }; 
			        	 resultArr70.push(obj);
			        }	 
			        
				    var bool = ageDay.includes('2019-11');
				    if (bool){
				    	var agecnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender == null && json[i].registerday == '2019-11'){
				    		 		agecnt +=  Number(json[i].count);
				        	 	}
				          }	
				    	 var obj =  { name : "70대이상", 
		    	                     y: agecnt };
				    	 resultArr70.push(obj);
			        }else {
			        	 var obj =  { name :"70대이상", 
					    	      y: 0.0 }; 
			        	 resultArr70.push(obj);
			        }	 
				    
				    var bool = ageDay.includes('2019-12');
				    if (bool){
				    	var agecnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender == null && json[i].registerday == '2019-12'){
				    		 		agecnt +=  Number(json[i].count);
				        	 	}
				          }	
				    	 var obj =  { name : "70대이상", 
		    	                     y: agecnt };
				    	 resultArr70.push(obj);
			        }else {
			        	 var obj =  { name : "70대이상", 
					    	      y: 0.0 }; 
			        	 resultArr70.push(obj);
			        }	 
				    
				    var bool = ageDay.includes('2020-01');
				    if (bool){
				    	var agecnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender == null && json[i].registerday == '2020-01'){
				    		 		agecnt +=  Number(json[i].count);
				        	 	}
				          }	
				    	 var obj =  { name : "70대이상", 
		    	                     y: agecnt };
				    	 resultArr70.push(obj);
			        }else {
			        	 var obj =  { name : "70대이상", 
					    	      y: 0.0 }; 
			        	 resultArr70.push(obj);
			        }	 
				    
				    var bool = ageDay.includes('2020-02');
				    if (bool){
				    	 var agecnt = 0;
				    	 for (var i = 0; i < json.length; i++) {
				    		 	if(json[i].age >= 70 && json[i].gender == null && json[i].registerday == '2020-02'){
				    		 		agecnt +=  Number(json[i].count);
				        	 	}
				          }	
				    	 var obj =  { name : "70대이상", 
		    	                     y: agecnt };
				    	 resultArr70.push(obj);
			        }else {
			        	 var obj =  { name : "70대이상", 
					    	      y: 0.0 }; 
			        	 resultArr70.push(obj);
			        }	 
				    // 70 
				    
					Highcharts.chart('chart_monthlyTrend', {
					    chart: {
					        type: 'column'
					    },
					    title: {
					        text: ''
					    },
					    xAxis: {
					        categories: ['2019-03','2019-04','2019-05','2019-06','2019-07',
					        	          '2019-08','2019-09','2019-10','2019-11','2019-12','2020-01','2020-02']
					    },
					    yAxis: {
					        min: 0,
					        title: {
					            text: ''
					        },
					        stackLabels: {
					            enabled: true,
					            style: {
					                fontWeight: 'bold',
					                color: ( // theme
					                    Highcharts.defaultOptions.title.style &&
					                    Highcharts.defaultOptions.title.style.color
					                ) || 'red'
					            }
					        }
					    },
					    colors: ['red','orange','yellow','green','blue','navy','purple'],
					    legend: {
					        align: 'right',
					        x: -30,
					        verticalAlign: 'top',
					        y: -10,  
					        floating: true,
					        backgroundColor:
					            Highcharts.defaultOptions.legend.backgroundColor || 'white',
					        borderColor: '#CCC',
					        borderWidth: 1,
					        shadow: false
					    },
					    tooltip: {
					        headerFormat: '<b>{point.x}</b><br/>',
					        pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
					    },
					    plotOptions: {
					        column: {
					            stacking: 'normal',
					            dataLabels: {
					                enabled: true
					            }
					        }
					    },
					    series: [{
					        name: '10',
					        data: resultArr10
					    }, {
					    	name: '20',
					        data: resultArr20
					    }, {
					    	name: '30',
					        data: resultArr30
					    }, {
					    	name: '40',
					        data: resultArr40
					    }, {
					    	name: '50',
					        data: resultArr50
					    }, {
					    	name: '60',
					        data: resultArr60
					    }, {
					    	name: '70대 이상',
					        data: resultArr70
					    }]
					});	  
					
					//////////////////////////////////////////////
					
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			})
			
			break;
			
		case "gender" :
			$.ajax({
				url: "/bestchoice/chartMemberTrend.bc",
				dataType: "JSON",
				success:function(json){
					
					$("#chart_monthlyTrend").empty();  // 차트 자리 비우기 (이전 차트 삭제)
					
					var resultArrF = [] ; 
					var resultArrM = [] ;
				
					var genderDay = "";
					for (var i = 0; i < json.length; i++) {						
						 if ( json[i].age == null && json[i].gender == 2 && json[i].registerday != null ){ 	
							 genderDay += json[i].registerday; 
						 }
					}	
					
				    var bool = genderDay.includes('2019-03');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 2 && json[i].registerday == '2019-03'){
				        	 		var obj =  { name : '여자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrF.push(obj);
			        }else {
			        	 var obj =  { name :'여자', 
					    	      y: 0.0 }; 
			        	 resultArrF.push(obj);
			        } 
				    
				    var bool = genderDay.includes('2019-04');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 2 && json[i].registerday == '2019-04'){
				        	 		var obj =  { name : '여자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrF.push(obj);
			        }else {
			        	 var obj =  { name : '여자', 
					    	      y: 0.0 }; 
			        	 resultArrF.push(obj);
			        } 
				    
				    var bool = genderDay.includes('2019-05');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 2 && json[i].registerday == '2019-05'){
				        	 		var obj =  { name : '여자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrF.push(obj);
			        }else {
			        	 var obj =  { name : '여자', 
					    	      y: 0.0 }; 
			        	 resultArrF.push(obj);
			        } 
				    
				    var bool = genderDay.includes('2019-06');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 2 && json[i].registerday == '2019-06'){
				        	 		var obj =  { name : '여자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrF.push(obj);
			        }else {
			        	 var obj =  { name : '여자', 
					    	      y: 0.0 }; 
			        	 resultArrF.push(obj);
			        } 
				    
				    var bool = genderDay.includes('2019-07');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 2 && json[i].registerday == '2019-07'){
				        	 		var obj =  { name : '여자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrF.push(obj);
			        }else {
			        	 var obj =  { name :'여자', 
					    	      y: 0.0 }; 
			        	 resultArrF.push(obj);
			        } 
				    
				    var bool = genderDay.includes('2019-08');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 2 && json[i].registerday == '2019-08'){
				        	 		var obj =  { name : '여자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrF.push(obj);
			        }else {
			        	 var obj =  { name :'여자', 
					    	      y: 0.0 }; 
			        	 resultArrF.push(obj);
			        } 
				    
				    var bool = genderDay.includes('2019-09');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 2 && json[i].registerday == '2019-09'){
				        	 		var obj =  { name :'여자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrF.push(obj);
			        }else {
			        	 var obj =  { name : '여자', 
					    	      y: 0.0 }; 
			        	 resultArrF.push(obj);
			        }
				    
				    var bool = genderDay.includes('2019-10');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 2 && json[i].registerday == '2019-10'){
				        	 		var obj =  { name : '여자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrF.push(obj);
			        }else {
			        	 var obj =  { name :'여자', 
					    	      y: 0.0 }; 
			        	 resultArrF.push(obj);
			        }	 
			        
				    var bool = genderDay.includes('2019-11');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 2 && json[i].registerday == '2019-11'){
				        	 		var obj =  { name : '여자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrF.push(obj);
			        }else {
			        	 var obj =  { name :'여자', 
					    	      y: 0.0 }; 
			        	 resultArrF.push(obj);
			        }	 
				    
				    var bool = genderDay.includes('2019-12');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 2 && json[i].registerday == '2019-12'){
				        	 		var obj =  { name :'여자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrF.push(obj);
			        }else {
			        	 var obj =  { name :'여자', 
					    	      y: 0.0 }; 
			        	 resultArrF.push(obj);
			        }	 
				    
				    var bool = genderDay.includes('2020-01');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 2 && json[i].registerday == '2020-01'){
				        	 		var obj =  { name : '여자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrF.push(obj);
			        }else {
			        	 var obj =  { name : '여자', 
					    	      y: 0.0 }; 
			        	 resultArrF.push(obj);
			        }	 
				    
				    var bool = genderDay.includes('2020-02');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 2 && json[i].registerday == '2020-02'){
				        	 		var obj =  { name : '여자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrF.push(obj);
			        }else {
			        	 var obj =  { name :'여자', 
					    	      y: 0.0 }; 
			        	 resultArrF.push(obj);
			        }	
				     /// 
				     
				     
				    var genderDay = "";
					for (var i = 0; i < json.length; i++) {						
						 if ( json[i].age == null && json[i].gender == 1 && json[i].registerday != null ){ 	
							 genderDay += json[i].registerday; 
						 }
					}	
				    var bool = genderDay.includes('2019-03');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 1 && json[i].registerday == '2019-03'){
				        	 		var obj =  { name : '남자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrM.push(obj);
			        }else {
			        	 var obj =  { name :'남자', 
					    	      y: 0.0 }; 
			        	 resultArrM.push(obj);
			        } 
				    
				    var bool = genderDay.includes('2019-04');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 1 && json[i].registerday == '2019-04'){
				        	 		var obj =  { name : '남자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrM.push(obj);
			        }else {
			        	 var obj =  { name : '남자', 
					    	      y: 0.0 }; 
			        	 resultArrM.push(obj);
			        } 
				    
				    var bool = genderDay.includes('2019-05');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 1 && json[i].registerday == '2019-05'){
				        	 		var obj =  { name : '남자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrM.push(obj);
			        }else {
			        	 var obj =  { name : '남자', 
					    	      y: 0.0 }; 
			        	 resultArrM.push(obj);
			        } 
				    
				    var bool = genderDay.includes('2019-06');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 1 && json[i].registerday == '2019-06'){
				        	 		var obj =  { name : '남자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrM.push(obj);
			        }else {
			        	 var obj =  { name : '남자', 
					    	      y: 0.0 }; 
			        	 resultArrM.push(obj);
			        } 
				    
				    var bool = genderDay.includes('2019-07');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 1 && json[i].registerday == '2019-07'){
				        	 		var obj =  { name : '남자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrM.push(obj);
			        }else {
			        	 var obj =  { name :'남자', 
					    	      y: 0.0 }; 
			        	 resultArrM.push(obj);
			        } 
				    
				    var bool = genderDay.includes('2019-08');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 1 && json[i].registerday == '2019-08'){
				        	 		var obj =  { name : '남자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrM.push(obj);
			        }else {
			        	 var obj =  { name :'남자', 
					    	      y: 0.0 }; 
			        	 resultArrM.push(obj);
			        } 
				    
				    var bool = genderDay.includes('2019-09');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 1 && json[i].registerday == '2019-09'){
				        	 		var obj =  { name :'남자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrM.push(obj);
			        }else {
			        	 var obj =  { name : '남자', 
					    	      y: 0.0 }; 
			        	 resultArrM.push(obj);
			        }
				    
				    var bool = genderDay.includes('2019-10');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 1 && json[i].registerday == '2019-10'){
				        	 		var obj =  { name : '남자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrM.push(obj);
			        }else {
			        	 var obj =  { name :'남자', 
					    	      y: 0.0 }; 
			        	 resultArrM.push(obj);
			        }	 
			        
				    var bool = genderDay.includes('2019-11');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 1 && json[i].registerday == '2019-11'){
				        	 		var obj =  { name : '남자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrM.push(obj);
			        }else {
			        	 var obj =  { name :'남자', 
					    	      y: 0.0 }; 
			        	 resultArrM.push(obj);
			        }	 
				    
				    var bool = genderDay.includes('2019-12');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 1 && json[i].registerday == '2019-12'){
				        	 		var obj =  { name :'남자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrM.push(obj);
			        }else {
			        	 var obj =  { name :'남자', 
					    	      y: 0.0 }; 
			        	 resultArrM.push(obj);
			        }	 
				    
				    var bool = genderDay.includes('2020-01');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 1 && json[i].registerday == '2020-01'){
				        	 		var obj =  { name : '남자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrM.push(obj);
			        }else {
			        	 var obj =  { name : '남자', 
					    	      y: 0.0 }; 
			        	 resultArrM.push(obj);
			        }	 
				    
				    var bool = genderDay.includes('2020-02');
				    if (bool){
				    	 for (var i = 0; i < json.length; i++) {
				        	 	if(json[i].age == null && json[i].gender == 1 && json[i].registerday == '2020-02'){
				        	 		var obj =  { name : '남자', 
				        	 				         y: Number( json[i].count ) }; 
				        	 	}
				        	 }	
				    	 resultArrM.push(obj);
			        }else {
			        	 var obj =  { name :'남자', 
					    	      y: 0.0 }; 
			        	 resultArrM.push(obj);
			        }	
					
						
				
					Highcharts.chart('chart_monthlyTrend', {
					    chart: {
					        type: 'column'
					    },
					    title: {
					        text: ''
					    },
					    xAxis: {
					        categories: ['2019-03','2019-04','2019-05','2019-06','2019-07',
					        	          '2019-08','2019-09','2019-10','2019-11','2019-12','2020-01','2020-02']
					    },
					    yAxis: {
					        min: 0,
					        title: {
					            text: ''
					        },
					        stackLabels: {
					            enabled: true,
					            style: {
					                fontWeight: 'bold',
					                color: ( // theme
					                    Highcharts.defaultOptions.title.style &&
					                    Highcharts.defaultOptions.title.style.color
					                ) || 'red'
					            }
					        }
					    },
					    colors: ['#b3ccff','#85e085'],
					    legend: {
					        align: 'right',
					        x: -30,
					        verticalAlign: 'top',
					        y: -10,  
					        floating: true,
					        backgroundColor:
					            Highcharts.defaultOptions.legend.backgroundColor || 'white',
					        borderColor: '#CCC',
					        borderWidth: 1,
					        shadow: false
					    },
					    tooltip: {
					        headerFormat: '<b>{point.x}</b><br/>',
					        pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
					    },
					    plotOptions: {
					        column: {
					            stacking: 'normal',
					            dataLabels: {
					                enabled: true
					            }
					        }
					    },
					    series: [{
					        name: '여자',
					        data: resultArrF
					    }, {
					    	name: '남자',
					        data: resultArrM
					    }]
					});	  
					
					//////////////////////////////////////////////
					
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			})
			
			break;
	   }
   }
	  
</script>
  
<div id="adminMember">
	<div style="border: solid 1px gray;  margin-bottom: 30px; padding: 10px;">
	  <label style="font-size: 16px;">◎ 여기는어때 회원 통계(연령대 및 성별)</label> : 총 ${totalMember}명
	  <div id="memberChart"></div>
	  <div id="memberTable" class="memberchart_table" style="margin: 0 auto;"></div>
	</div>

	<div style="float: left; min-height: 608px; margin-left: 35px; width: 45%; border: solid 1px gray; margin-bottom: 30px; padding: 10px;" > 
		<label style="font-size: 16px;">◎ 연령대 점유율 </label>
		<div id="ageChart">	</div>
		<div id="ageTable" class="memberchart_table" style="margin: 0 auto;"></div>
	</div>
	
	<div style="float: right; min-height: 608px; width: 45%; border: solid 1px gray; margin-right: 35px; margin-bottom: 30px; padding: 10px;" > 
		<label style="font-size: 16px;">◎ 성별 점유율  </label>  
		<div id="genderChart"></div>
		<div id="genderTable" class="memberchart_table" style="margin: 0 auto; padding-top: 50px; margin-bottom: 50px;"></div>
	</div>  
	
	<div style="clear: both; border: solid 1px gray; padding: 10px;  margin-bottom: 30px;"> 
		<label style="font-size: 16px;">◎ 월별 회원가입수 추이</label>&nbsp;&nbsp;>> 옵션 선택 : 
		<select name="searchType" id="searchType" style="height: 20px;">  
			<option value="age" selected="selected">나이</option>
			<option value="gender">성별</option>    
		</select>  
		<div id="chart_monthlyTrend">
		
		</div>
	</div>
	
	
</div>   