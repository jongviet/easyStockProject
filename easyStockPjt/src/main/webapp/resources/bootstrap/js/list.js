const alpha = alphavantage({ key: '72FY7BZXTG91TJBV' });

$(document).ready(function() {

		alpha.performance.sector().then((data) => {
			  var daily = data["Rank B: 1 Day Performance"];
			  var monthly = data["Rank D: 1 Month Performance"];
			  var YTD = data["Rank F: Year-to-Date (YTD) Performance"];
			  
			  $("#cs_d").text(daily["Communication Services"]);
			  $("#cs_m").text(monthly["Communication Services"]);
			  $("#cs_y").text(YTD["Communication Services"]);
			  
			  $("#cd_d").text(daily["Consumer Discretionary"]);
			  $("#cd_m").text(monthly["Consumer Discretionary"]);
			  $("#cd_y").text(YTD["Consumer Discretionary"]);
			  
			  $("#cst_d").text(daily["Consumer Staples"]);
			  $("#cst_m").text(monthly["Consumer Staples"]);
			  $("#cst_y").text(YTD["Consumer Staples"]);
			  
			  $("#e_d").text(daily["Energy"]);
			  $("#e_m").text(monthly["Energy"]);
			  $("#e_y").text(YTD["Energy"]);
			  
			  $("#f_d").text(daily["Financials"]);
			  $("#f_m").text(monthly["Financials"]);
			  $("#f_y").text(YTD["Financials"]);
			  
			  $("#h_d").text(daily["Health Care"]);
			  $("#h_m").text(monthly["Health Care"]);
			  $("#h_y").text(YTD["Health Care"]);

			  $("#i_d").text(daily["Industrials"]);
			  $("#i_m").text(monthly["Industrials"]);
			  $("#i_y").text(YTD["Industrials"]);
			  
			  $("#it_d").text(daily["Information Technology"]);
			  $("#it_m").text(monthly["Information Technology"]);
			  $("#it_y").text(YTD["Information Technology"]);
			  
			  $("#m_d").text(daily["Materials"]);
			  $("#m_m").text(monthly["Materials"]);
			  $("#m_y").text(YTD["Materials"]);
			  
			  $("#re_d").text(daily["Real Estate"]);
			  $("#re_m").text(monthly["Real Estate"]);
			  $("#re_y").text(YTD["Real Estate"]);
			  
			  $("#u_d").text(daily["Utilities"]);
			  $("#u_m").text(monthly["Utilities"]);
			  $("#u_y").text(YTD["Utilities"]);
		});
});
	


