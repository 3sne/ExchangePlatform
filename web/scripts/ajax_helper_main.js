let USERNAME;

$(document).ready(function () {
    console.log("From jQuery");

    //Ad Loader
    let row_id_indexer = 0;
    let ad_fetched_already = [];
    const ad_fetch_url = 'http://localhost:8084/ExchangePlatform/adfetch';
    let ad_fetch_data = {
        'max_ad_count' : '12',
        'ad_except': ad_fetched_already
    };

    console.log("JSON ", JSON.stringify(ad_fetch_data));

    let ad_fetch_payload = {
        url: ad_fetch_url,
        type: 'POST',
        contentType:'application/json; charset=utf-8',
        data: JSON.stringify(ad_fetch_data),
        success: (data) => {
            recvAdData = data;
            console.log(recvAdData);

            for (let i = row_id_indexer; i < row_id_indexer + 4; i++) {
                $("#ad_row_" + i).html('');
                $("#ad_container_custom").append('<div id="ad_row_' + i + '" class="row justify-content-center mt-3">');
                for (let j = 0; j < 3; j++) {
                    let conc_obj = recvAdData.ad_list[i * 3 + j];
                    ad_fetched_already.push(conc_obj.ad_id);
                    let ad_title = conc_obj.ad_title;
                    let ad_desc = conc_obj.ad_desc;
                    let ad_price = conc_obj.ad_price;
                    let ad_location = conc_obj.ad_location;
                    let appendAdHtmlCode = '<div class="col-md-4"><div class="card mp-mat-sha-1"><img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap"><div class="card-body"><h4 class="card-title" data-content="ad_title">'+ ad_title + '</h4><p class="card-text" style="max-height: 150px" data-content="ad_desc">' + ad_desc + '</p><p class="card-text h3" data-content="ad_price">' + ad_price + '</p><small class="card-text text-muted" data-content="ad_location">' + ad_location + '</small></div></div></div>';
                    $("#ad_row_" + i).append(appendAdHtmlCode);
                }
            }
            row_id_indexer += 4;

        }
    }
    $.ajax(ad_fetch_url, ad_fetch_payload).done(()=>{
        console.log("[AJAX] DONE AD FETCH");
    });

    $("#more_ad_loader").click(() => {
        $.ajax({
            url: ad_fetch_url,
        type: 'POST',
        contentType:'application/json; charset=utf-8',
        data: JSON.stringify(ad_fetch_data),
        success: (data) => {
            recvAdData = data;
            console.log(recvAdData);
            for (let i = row_id_indexer; i < row_id_indexer + 4; i++) {
                $("#ad_row_" + i).html('');
                $("#ad_container_custom").append('<div id="ad_row_' + i + '" class="row justify-content-center mt-3">');
                for (let j = 0; j < 3; j++) {
                    let index = (i - row_id_indexer) * 3 + j;
                    console.log(index);
                    let conc_obj = recvAdData.ad_list[index];
                    ad_fetched_already.push(conc_obj.ad_id);
                    let ad_title = conc_obj.ad_title;
                    let ad_desc = conc_obj.ad_desc;
                    let ad_price = conc_obj.ad_price;
                    let ad_location = conc_obj.ad_location;
                    let appendAdHtmlCode = '<div class="col-md-4"><div class="card mp-mat-sha-1"><img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap"><div class="card-body"><h4 class="card-title" data-content="ad_title">'+ ad_title + '</h4><p class="card-text" style="max-height: 150px" data-content="ad_desc">' + ad_desc + '</p><p class="card-text h3" data-content="ad_price">' + ad_price + '</p><small class="card-text text-muted" data-content="ad_location">' + ad_location + '</small></div></div></div>';
                    $("#ad_row_" + i).append(appendAdHtmlCode);
                }
            }
            row_id_indexer += 4;
        }
        }).done(()=>{
            console.log("[AJAX] DONE MORE AD FETCH");
        });
    });


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