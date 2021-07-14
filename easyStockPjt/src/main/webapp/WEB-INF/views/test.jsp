<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script src="/resources/bootstrap/js/Chart.min.js"></script>

	<canvas id="myChart" width="300" height="300"></canvas>

	<script>
		var ctx = document.getElementById("myChart");
		Chart.plugins
				.register({
					beforeRender : function(chart) {
						if (chart.config.options.showAllTooltips) {
							// create an array of tooltips
							// we can't use the chart tooltip because there is only one tooltip per chart
							chart.pluginTooltips = [];
							chart.config.data.datasets
									.forEach(function(dataset, i) {
										chart.getDatasetMeta(i).data
												.forEach(function(sector, j) {
													chart.pluginTooltips
															.push(new Chart.Tooltip(
																	{
																		_chart : chart.chart,
																		_chartInstance : chart,
																		_data : chart.data,
																		_options : chart.options.tooltips,
																		_active : [ sector ]
																	}, chart));
												});
									});

							// turn off normal tooltips
							chart.options.tooltips.enabled = false;
						}
					},
					afterDraw : function(chart, easing) {
						if (chart.config.options.showAllTooltips) {
							// we don't want the permanent tooltips to animate, so don't do anything till the animation runs atleast once
							if (!chart.allTooltipsOnce) {
								if (easing !== 1)
									return;
								chart.allTooltipsOnce = true;
							}

							// turn on tooltips
							chart.options.tooltips.enabled = true;
							Chart.helpers.each(chart.pluginTooltips, function(
									tooltip) {
								tooltip.initialize();
								tooltip.update();
								// we don't actually need this since we are not animating tooltips
								tooltip.pivot();
								tooltip.transition(easing).draw();
							});
							chart.options.tooltips.enabled = false;
						}
					}
				});

		var myChart = new Chart(ctx, {
			type : 'doughnut',
			data : {
				labels : [ "블로그", "체험단", "SNS", "검색광고" ],
				datasets : [ {
					label : '# of Votes',
					data : [ 40, 30, 20, 10 ],
					backgroundColor : [ 'rgba(255, 99, 132, 0.8)',
							'rgba(54, 162, 235, 0.8)',
							'rgba(75, 192, 192, 0.8)',
							'rgba(153, 102, 255, 0.8)' ],

					borderColor : [ 'rgba(255,99,132,1)',
							'rgba(54, 162, 235, 1)', 'rgba(75, 192, 192, 1)',
							'rgba(153, 102, 255, 1)' ],
					borderWidth : 1
				} ]
			},
			animation : {
				animateScale : true,
				animateRotate : true
			},

			options : {
				scaleShowLabelBackdrop : true,
				showAllTooltips : true,

				legend : {
					display : true,

					labels : {
						fontColor : 'rgb(255, 255, 255)',
						fontSize : 16
					}
				}
			}

		});
	</script>
</body>
</html>
