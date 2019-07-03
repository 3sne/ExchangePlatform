const helper_gvars = {
    toggleSpinner: function(elemId, spinner, classPlay) {
        if ($(spinner).hasClass(classPlay)) {
            $(elemId).addClass(classPlay);
            $(spinner).removeClass(classPlay);
        } else {
            $(elemId).removeClass(classPlay);
            $(spinner).addClass(classPlay);
        }
    }
}

$(document).on('change','#fad_state', function(){
    $("#temp-loader").removeClass("d-none");
    
    $("#fad_city").find("option:gt(0)").remove();
    $.ajax({
        url: "http://localhost:8084/ExchangePlatform/locfetch",
        type: 'GET',
        data: {
            "selectedState": $("#fad_state").val()
        },
        success: (data) => {
            console.log("let cityList;");
            let cityList = data.cityList;
            if (data.code === 100) {
                $("#city_group").removeClass("d-none");
                $("#temp-loader").addClass("d-none");

                $("#fad_city").find("option:first").text("");
                for (var i = 0; i < cityList.length; i++) {
                    $("<option/>").attr("value", cityList[i].cityId).text(cityList[i].cityName).appendTo($("#fad_city"));
                }
            }
        }
    }).done(() => {
        console.log("[PGH] DONE MORE AD FETCH");
        $("#city_group").removeClass("d-none");
        $("#temp-loader").addClass("d-none");
    });
});



$(document).on('click', '#fad_post_btn', () => {

    //dothis: input validation

    
    // val title
    let ad_title = $("#fad_title").val();
    if (ad_title.length > 80) {
        return;
    }

    // val phone
    let ad_phone = $("#fad_phone").val();
    var reg_phone = /^[0-9]{10}$/;
    if(!reg_phone.test(ad_phone)) {
        return;
    }

    let ad_desc = CKEDITOR.instances.fad_desc.getData();

    const ca_url = "http://localhost:8084/ExchangePlatform/createNewAd";
    let ca_data = {
        adcat: 2,
        adtitle: ad_title,
        addesc: ad_desc,
        adprice: $("#fad_price").val(),
        adlocid: $("#fad_city").val(),
        adphone: ad_phone
    }
    let ca_pl = {
        url: ca_url,
        data: ca_data,
        success: (data) => {
            console.log("[PGH] status");
            console.log(data);
            if (data.code === 100) {
                //done: show modal of success posting then redirect to homepage / myad
                $("#statusModal").modal("show");
                $("#statusModalBody").load("signup_success.html");
                setTimeout(()=> {
                    $("#statusModal").modal("hide");
                    location="/ExchangePlatform";
                }, 2500);
            } else if (data.code === 201) { // not logged in
                //dothis: redirect homepage
                $("#statusModal").modal("show");
                $("#statusModalBody").load("signup_failure.html");
                setTimeout(()=> {
                    $("#statusModal").modal("hide");
                    $("#statusModalBody").empty();
                    location="/ExchangePlatform";
                }, 2000);
            } else { //failure
                //done: show modal of failure, clear all field and ask the boi to try again later.
                $("#statusModal").modal("show");
                $("#statusModalBody").load("signup_failure.html");
                setTimeout(()=> {
                    $("#statusModal").modal("hide");
                    $("#statusModalBody").empty();
                    // location="/ExchangePlatform";
                }, 3000);
            }
        }
    }
    $.ajax(ca_url, ca_pl).done(() => {
        console.log("[PGH] Ajax attempt complete");
    });

});


$('#fad_phone').keyup(function() {
    let ad_phone = $("#fad_phone").val();
    var reg_phone = /^[0-9]{10}$/;
    reg_phone.test(ad_phone)
    if (reg_phone.test(ad_phone) && $("#fad_phone").val().length === 10) {
        $('#fad_phone').removeClass("is-invalid");
        $('#fad_phone').addClass("is-valid");
    } else {
        $('#fad_phone').removeClass("is-valid");
        $('#fad_phone').addClass("is-invalid");
    }
});

$("#fad_title").keyup(() => {
    if($("#fad_title").val().length > 80) {
        $("#fad_title").addClass('is-invalid');
    } else {
        $("#fad_title").removeClass('is-invalid');
    }
});

(function ($) {
    $.fn.inputFilter = function (inputFilter) {
        return this.on("input keydown keyup mousedown mouseup select contextmenu drop", function () {
            if (inputFilter(this.value)) {
                this.oldValue = this.value;
                this.oldSelectionStart = this.selectionStart;
                this.oldSelectionEnd = this.selectionEnd;
            } else if (this.hasOwnProperty("oldValue")) {
                this.value = this.oldValue;
                this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
            }
        });
    };
}(jQuery));

$("#fad_price").inputFilter((value) => {
    return /^\d*$/.test(value);
})


