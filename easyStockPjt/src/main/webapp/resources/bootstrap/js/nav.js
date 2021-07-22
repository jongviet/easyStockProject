


$(document).on("click", "#admin",  function(e) {
  	 e.preventDefault();
  	 let email_val = ses;
  	 
  	 if(email_val != 'jongki6161@naver.com') {
  	 	alert('관리자만 접근 가능합니다.');
  	 	return false;
  	 } else {
  	 	$("#admin").unbind();
  	 	let adminPage = document.getElementById("admin");
  	 	adminPage.click();
  	 }
});
