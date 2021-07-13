var ajaxOn = false;
$("#join").on("click", function() {
    $("input[name=nextSt]").val("join");
    $("#loginBtn").text("Join");
    $("#join").hide();
    $("input[name=pwdCfm]").prop("type", "password");
    $("#loginBtn").attr("id", "joinBtn");
    $("#joinBtn").attr("disabled", true);
    $("#joinBtn").attr("class", "btn btn-md btn-dark");
    $("input[name=email]").val("");
    $("input[name=pwd]").val("");
    ajaxOn = true;
    make_input();

});

function make_input() {
    let last_li = document.getElementById("form").lastElementChild;
    last_li.innerHTML = "<a href='/' style='color: #fff;'>Back to Login</a>";
  }


$(".chk").on("input", function() {
    let pwd = $("input[name=pwd]").val();
    let pwdCfm = $("input[name=pwdCfm]").val();
    let email = $("input[name=email]").val();

    if (pwd == pwdCfm && email != null && email != "" && pwd != null && pwd != ""
        && pwdCfm != null && pwdCfm != "") {
        $("#joinBtn").attr("disabled", false);
        $("#joinBtn").attr("class", "btn btn-md btn btn-dark");
    }
    if (pwd != pwdCfm || email == null || email == "") {
        $("#joinBtn").attr("disabled", true);
        $("#joinBtn").attr("class", "btn btn-md btn btn-dark");
    }
});

$(function() {
    $("#email").on("focusout", function() {
        var email = $("#email").val();
        $("#joinBtn").attr("disabled", true);
        $("#joinBtn").attr("class", "btn btn-md btn-dark");

        if (ajaxOn) {
            $.ajax({
                url : './mc',
                type : 'post',
                data : {
                    email : email,
                    nextSt : "dupChk"
                },
                success : function(result) {
                    if (result > 0) {
                        alert('중복 이메일입니다.');
                        $("#email").val("");
                        $("#email").focus();
                    }
                }
            })
        }
    });
});