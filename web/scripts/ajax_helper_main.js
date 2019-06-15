let USERNAME;

$(document).ready(function () {
    console.log("From jQuery");

    //Ad Loader
    for (let i = 1; i < 4; i++) {
        $("#ad_row_" + i).html('');
        $("#ad_container_custom").append('<div id="ad_row_' + i + '" class="row justify-content-center mt-3">');
        for (let j = 1; j <= 3; j++) {
            let appendAdHtmlCode = '';
            let ad_title = 'Car for Sale';
            let ad_desc = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam libero lorem, ultricies lacinia nibh ac, sagittis porta ante. Donec maximus malesuada aliquet. Nulla sit amet ligula in tellus imperdiet pulvinar. Phasellus efficitur magna non mi interdum, id commodo nisi consequat. Aenean pretium a quam in scelerisque. Aliquam egestas vitae erat eget tristique.';
            let ad_price = 'Rs. 200000';
            let ad_location = 'Manipal, KA';
            $("#ad_row_" + i).append('<div class="col-md-4"><div class="card mp-mat-sha-1"><img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap"><div class="card-body"><h4 class="card-title" data-content="ad_title">'+ ad_title + '</h4><p class="card-text" data-content="ad_desc">' + ad_desc + '</p><p class="card-text h3" data-content="ad_price">' + ad_price + '</p><small class="card-text text-muted" data-content="ad_location">' + ad_location + '</small></div></div></div>');
        }
    }



    //Login Handler
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

    $('#session_uname_capture').bind('input', function () {
        console.log($("#session_uname_capture").val() + " << TRIGGER");
    });

    if ($("#session_uname_capture").val() != "") {
        USERNAME = $("#session_uname_capture").val();
        loginSuccessUiChange(USERNAME);
    }

});

function loginSuccessUiChange(data) {
    USERNAME = $("#session_uname_capture").val();
    $("#navbar-login-btn").remove();
    $("#loadUserButton").loadTemplate($("#template"), {
        username: data
    }).css("visibility", "visible");

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