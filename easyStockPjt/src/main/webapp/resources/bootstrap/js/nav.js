function post_move(){
    var f = document.getElementById("toAdmin");
    f.action = "/member/admin";
    f.method = "post";
    f.submit();
};








