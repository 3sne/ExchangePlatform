let getUrlVars = () =>  {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}

$(document).ready(() => {
    let hrefparams = getUrlVars();
    const posting_zoom_url = 'http://localhost:8084/ExchangePlatform/ad';
    console.log(posting_zoom_url);
    let posting_zoom_data = {
        'adid': hrefparams.id,
    };
    let posting_fetch_payload = {
        url: posting_zoom_url,
        type: 'POST',
        data: posting_zoom_data,
        success: (data) => {
            console.log(data);
        }
    }
    $.ajax(posting_zoom_url, posting_fetch_payload).done(()=>{
        console.log("[AJAX] DONE POSTING ZOOM FETCH");
    });
});