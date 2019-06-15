let USERNAME;

$(document).ready(function () {
    console.log("From jQuery");    
    $("#login-modal-btn").click(() => {
        let e = $("#login-modal-email").val();
        let p = $("#login-modal-pass").val();
        if (e !== '' && p !== '') {
            let reqUrl = 'http://localhost:8084/ExchangePlatform/login';
            let reqLoad = {
                data: {
                    'email': e,
                    'password': p
                },
                success: (data) => {
                    let sResp = $.parseJSON(data);
                    if (sResp.code === 100) {
                        console.log("[AJAX] Login Successful");
                        console.log("OUR USER IS: ", sResp.username);
                        $('#logInModal').modal('hide');
                        USERNAME = sResp.username;
                        loginSuccessUiChange();
                    } else if (sResp.code === 101) {
                        console.log("[AJAX] Login Unsuccessful");
                        $("#login-modal-pass").val("");
                        $("#login-modal-err-zone").text("Incorrect Credentials");
                    }
                },
                failure: (data) => {
                    console.log("[ERROR] Path: /login | ajax failure", data);
                }
            };
            $.ajax(reqUrl, reqLoad).done(() => {
                console.log("Ajax attempt complete");
            });

        }
    });
});

function loginSuccessUiChange() {
    $("#navbar-login-btn").remove();
    $("#loadUserButton").loadTemplate($("#template"), {
        username: USERNAME
    }).css("visibility", "visible");
};