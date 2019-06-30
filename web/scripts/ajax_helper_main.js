let USERNAME;

$(document).ready(function () {
    console.log("From ajax_helper_main");

    // ** Login Handler
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
                        location = location;
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

    // ** Try Sell Handler
    $("#navbar-sell-button").click(() => {
        if ($("#session_uname_capture").val() != '') {
            console.log('NB-SELL-BTN: Already logged in');
            //dothis: go to sell page (create ad)
        } else {
            console.log('NB-SELL-BTN: Not Logged in');
            //dothis: if valid user: ask for password then send to sell page (create ad)
            //                  not: sign up content in html!!
        }
    });

    $('#session_uname_capture').bind('input', function () {
        console.log($("#session_uname_capture").val() + " << TRIGGER");
    });

    if ($("#session_uname_capture").val() != "") {
        USERNAME = $("#session_uname_capture").val();
        console.log("username (hidden input) = ", USERNAME);
        loginSuccessUiChange(USERNAME);
    }

});

// ** Change navbar to reflect logged in state
function loginSuccessUiChange(data) {
    USERNAME = $("#session_uname_capture").val();
    $("#navbar-login-btn").remove();
    $("#loadUserButton").loadTemplate($("#template"), {
        username: data
    }).css("visibility", "visible");

    //logout handler
    $("#dd-user-logout").click(event, () => {
        console.log(event);
        console.log("here");
        let reqUrl = 'http://localhost:8084/ExchangePlatform/logout';
        let reqLoad = {
            data: {},
            success: (data) => {
                let sResp = $.parseJSON(data);
                console.log(sResp);
                if (sResp.code === 100) {
                    USERNAME = '';
                    $("#session_uname_capture").val('');
                    console.log("[AJAX] Logout Successful");
                    location = location;
                } else {
                    console.log("[AJAX] Logout Unsuccessful");
                }
            },
            failure: (data) => {
                console.log("[ERROR] Path: /logout | ajax failure", data);
            }
        };
        $.ajax(reqUrl, reqLoad).done(() => {
            console.log("Ajax attempt complete");
        });
    });

};