/* 모든 회원 현재가 업데이트 진행  */
    /**
     * Init Alpha Vantage with your API key.
     *
     * @param {String} key
     *   Your Alpha Vantage API key.
     */
    const alpha = alphavantage({ key: 'EKPQ647LZ3NMCEIZ' });


/* chartjs tooltip 용 */
$(document).ready(function() {
	var ctx = document.getElementById("myChartTwo");
	Chart.plugins.register({
	  beforeRender: function (chart) {
	    if (chart.config.options.showAllTooltips) {
	        chart.pluginTooltips = [];
	        chart.config.data.datasets.forEach(function (dataset, i) {
	            chart.getDatasetMeta(i).data.forEach(function (sector, j) {
	                chart.pluginTooltips.push(new Chart.Tooltip({
	                    _chart: chart.chart,
	                    _chartInstance: chart,
	                    _data: chart.data,
	                    _options: chart.options.tooltips,
	                    _active: [sector]
	                }, chart));
	            });
	        });

	        chart.options.tooltips.enabled = false;
	    }
	},
	  afterDraw: function (chart, easing) {
	    if (chart.config.options.showAllTooltips) {
	        if (!chart.allTooltipsOnce) {
	            if (easing !== 1)
	                return;
	            chart.allTooltipsOnce = true;
	        }

	        chart.options.tooltips.enabled = true;
	        Chart.helpers.each(chart.pluginTooltips, function (tooltip) {
	            tooltip.initialize();
	            tooltip.update();
	            tooltip.pivot();
	            tooltip.transition(easing).draw();
	        });
	        chart.options.tooltips.enabled = false;
	    }
	  }
	});
});
