let epglobals = {
    // vars
    _USERNAME: '',
    s_login_e: '',
    s_login_p: '',
    s_signup_e: '',
    s_singup_p: '',

    //methods
    toggleSpinner: function(elemId, spinner, classPlay) {
        if ($(spinner).hasClass(classPlay)) {
            $(elemId).addClass(classPlay);
            $(spinner).removeClass(classPlay);
        } else {
            $(elemId).removeClass(classPlay);
            $(spinner).addClass(classPlay);
        }
    }
};

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
                        epglobals._USERNAME = sResp.username;
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

    $("#trySellNext1").click(() => {
        if ($("#tryEmail").val() == '') {
            return;
        }
        const providedEmail = $("#tryEmail").val();
        epglobals.toggleSpinner("#trySellContentHolder", "#tsch-spinner", "d-none");
        let reqUrl = 'http://localhost:8084/ExchangePlatform/TrySell';
        let reqLoad = {
            data: {
                'tryEmail': providedEmail
            },
            success: (data) => {
                // console.log(data);
                let sResp = data;
                if (sResp.code === 100) {
                    console.log("[TRYSELL] USER EXIST");
                    //dothis: load enter password html
                    $("#tempholder_pass_login").val(providedEmail);
                    epglobals.s_login_e = providedEmail;
                    $("#trySellContentHolder").load("trysell-login.html");
                } else if (sResp.code === 101) {
                    console.log("[TRYSELL] USER DON'T EXIST");
                    //dothis: load set password and username html
                    $("#tempholder_pass_signup").val(providedEmail);
                    epglobals.s_signup_e = providedEmail;
                    $("#trySellContentHolder").load("trysell-signup.html");
                } else {
                    console.log("[TRYSELL] CHECK ERROR FOR CODE ", sResp.code, " in TrySell Servlet");
                }
                epglobals.toggleSpinner("#trySellContentHolder", "#tsch-spinner", "d-none");
            },
            failure: (data) => {
                console.log("[ERROR] Path: /TrySell | ajax failure", data);
            }
        };
        $.ajax(reqUrl, reqLoad).done(() => {
            console.log("[TRYSELL] Ajax attempt complete");
        });
    }); // Next on click end

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
        epglobals._USERNAME = $("#session_uname_capture").val();
        console.log("username (hidden input) = ", epglobals._USERNAME);
        loginSuccessUiChange(epglobals._USERNAME);
    }

});

// ** Change navbar to reflect logged in state
function loginSuccessUiChange(data) {
    epglobals._USERNAME = $("#session_uname_capture").val();
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
                    epglobals._USERNAME = '';
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