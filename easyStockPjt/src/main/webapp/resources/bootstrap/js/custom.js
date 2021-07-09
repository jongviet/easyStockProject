/* Detail page 차트 시작 */

/* 최초 로딩  */
$(document).ready(function() {
	let symbol = $("#symbol").text();
	let input = symbol.toLowerCase();

	alpha_input_init(input);
});



$("#daily").on("click", function() {

	let symbol = $("#symbol").text();
	let input = symbol.toLowerCase();

	alpha_input_daily(input);

});


$("#monthly").on("click", function() {

	let symbol = $("#symbol").text();
	let input = symbol.toLowerCase();

	alpha_input_monthly(input);

});


function alpha_input_init(input) { 
	
	alpha.data.monthly_adjusted(input, 'full').then((data) => {
		
		/* default : monthly */
 		var bigObj = data["Monthly Adjusted Time Series"];
		
		var jsonArray = Object.entries(bigObj);
		var dateArray = [];
		var valArray = [];
		
		for(let i = 0; i < Object.keys(jsonArray).length; i++) {
			for(let j = 0; j < 1; j++) {
				
				let year_month = jsonArray[i][j].substr(0,7);
				dateArray.unshift(year_month);
				valArray.unshift(jsonArray[i][j+1]["5. adjusted close"]);
			}
		};
		show_graph_monthly(dateArray, valArray, input);
  });
};


function alpha_input_daily(input) { 
	
	alpha.data.daily_adjusted(input, 'full').then((data) => {
		
		/* daily */
 		var bigObj = data["Time Series (Daily)"];
		
		var jsonArray = Object.entries(bigObj);
		var dateArray = [];
		var valArray = [];
		
		for(let i = 0; i < 150; i++) {
			for(let j = 0; j < 1; j++) {
				
				dateArray.unshift(jsonArray[i][j]);
				valArray.unshift(jsonArray[i][j+1]["5. adjusted close"]);
			}
		};
		
		$("#myChartOne").remove();
		$("#canvasDiv").append("<canvas id='myChartOne' style='background-color: white;'></canvas>");
		show_graph_daily(dateArray, valArray, input);
  });
};

function alpha_input_monthly(input) { 
	
	alpha.data.monthly_adjusted(input, 'full').then((data) => {
		
		/* default : monthly */
 		var bigObj = data["Monthly Adjusted Time Series"];
		
		var jsonArray = Object.entries(bigObj);
		var dateArray = [];
		var valArray = [];
		
		for(let i = 0; i < Object.keys(jsonArray).length; i++) {
			for(let j = 0; j < 1; j++) {
				
				let year_month = jsonArray[i][j].substr(0,7);
				dateArray.unshift(year_month);
				valArray.unshift(jsonArray[i][j+1]["5. adjusted close"]);
			}
		};
		$("#myChartOne").remove();
		$("#canvasDiv").append("<canvas id='myChartOne' style='background-color: white;'></canvas>");
		show_graph_monthly(dateArray, valArray, input);
  });
};


	function show_graph_monthly(dateArray, valArray, input) {
		
		const myChartOne = document.getElementById("myChartOne").getContext("2d");

		const barChar = new Chart(myChartOne, {
			  type: "line",
			  data: {
			    labels: dateArray,
			    datasets: [
			      {
			        label: input.toUpperCase(),
			        data: valArray,
			        backgroundColor: "lightblue",
			        borderColor: 'rgb(75, 192, 192)',
			        tension: 0.1
			      },
			    ],
			  },
			});
		
	};
	
	function show_graph_daily(dateArray, valArray, input) {
		
		const myChartOne = document.getElementById("myChartOne").getContext("2d");

		const barChar = new Chart(myChartOne, {
			  type: "line",
			  data: {
			    labels: dateArray,
			    datasets: [
			      {
			        label: input.toUpperCase(),
			        data: valArray,
			        backgroundColor: "lightblue",
			        borderColor: 'rgb(75, 192, 192)',
			        tension: 0.1
			      },
			    ],
			  },
			});
		
	};
	
/* Detail page 차트 끝 */


/* Detail page 댓글 시작  */




/* Detail page 댓글 끝 */

