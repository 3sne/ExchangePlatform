$(document).ready(function () {
    console.log("From jQuery");

    $("#login-modal-btn").click(() => {
        let e = $("#login-modal-email").val();
        let p = $("#login-modal-pass").val();
        if (e !== '' && p !== '') {
            let reqUrl = '/login';
            let reqLoad = {
                data: {
                    'email': e,
                    'password': p
                },
                success: () => {
                    console.log("succes?");
                }
            };
            $.ajax(reqUrl, reqLoad).done(() => {
                console.log("AJAX CoMPLETE");
            });
        }
    });

});