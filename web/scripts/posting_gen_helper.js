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

    const ca_url = "http://localhost:8084/ExchangePlatform/createNewAd";
    let ca_data = {
        adcat: 69,
        adtitle: $("#fad_title").val(),
        addesc: $("#fad_desc").val(),
        adpric: $("#fad_price").val(),
        adlocid: $("#fad_city").val(),
    }
    let ca_pl = {
        url: ca_url,
        data: ca_data,
        success: (data) => {
            console.log("[PGH] status");
        }
    }
    $.ajax(ca_url, ca_pl).done(() => {
        console.log("[PGH] Ajax attempt complete");
    });

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
    return /^\d*$/.test(value)
})


