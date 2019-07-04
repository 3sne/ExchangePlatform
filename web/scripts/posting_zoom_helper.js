let getUrlVars = () => {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (m, key, value) {
        vars[key] = value;
    });
    return vars;
}

$(document).ready(() => {
    epglobals.toggleSpinner("#zoom-container", "#loader", "d-none");
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
            if (data.code === 100) { //success
                let conc_obj = data.mPze;
                epglobals.zoomedAdData = conc_obj;
                let ad_id = conc_obj.ad_id;
                let ad_poster_id = conc_obj.ad_poster_id;
                let ad_poster_uname = conc_obj.ad_poster_uname;
                let ad_poster_email = conc_obj.ad_poster_email;
                let ad_category_id = conc_obj.ad_category_id;
                let ad_title = conc_obj.ad_title;
                let ad_desc = conc_obj.ad_desc;
                let ad_price = conc_obj.ad_price;
                let ad_date = new Date(conc_obj.ad_date).toDateString();
                let ad_location_id = conc_obj.ad_location_id;
                let ad_location_city = conc_obj.ad_location_city;
                let ad_location_state = conc_obj.ad_location_state;

                $("#ad_desc_holder").html(ad_desc);
                $("#ad_title_holder").html(ad_title);
                $("#ad_price_holder").html("&#8377; " + ad_price);
                $("#ad_uname_holder").html(ad_poster_uname);
                $("#ad_date_holder").html(ad_date);
                $("#ad_location_blob").html(ad_location_city + ", " + ad_location_state);

                epglobals.toggleSpinner("#zoom-container", "#loader", "d-none");
                $("#site_footer").load("site_footer.html");
            } else { //failure
                $("#zoom-container").load('AdNotFound.html');
            }
        }
    }
    
    $.ajax(posting_zoom_url, posting_fetch_payload).done(() => {
        console.log("[AJAX] DONE POSTING ZOOM FETCH");
    });

    // if ($("#session_uname_capture").val() != '') {
    //     $("#ContactThemBtn").attr('data-toggle', 'modal')
    // }

    $("#ContactThemBtn").click(() => {
        epglobals.zoomedAdData;
        epglobals.toggleSpinner("#ContactThemBtn", "#contactLoadStatus", "d-none");
        let conForPTarget = 'http://localhost:8084/ExchangePlatform/contactHelper';
        let conForP = {
            forAdId: epglobals.zoomedAdData.ad_id,
            forUserBrowsing: $("#session_uname_capture").val().trim()
        }

        let conForPPayload = {
            url: conForPTarget,
            type: 'POST',
            data: conForP,
            success: (data) => {
                epglobals.toggleSpinner("#ContactThemBtn", "#contactLoadStatus", "d-none");
                $("#ContactThemBtn").addClass("d-none");
                 console.log("[CONT_BTN] recv: ", data);
                 if (data.code === 100) {
                     //done: display phno no problem
                     let interData = data.contactNumber
                     $("#crh_msg").load("signup_success.html");
                     setTimeout(() => {
                        $("#crh_msg").empty();
                        $("#crh_msg").append(`
                            <small class="text-muted">${epglobals.zoomedAdData.ad_poster_uname}'s phone number</small>
                            <p class="h2">+91 ${interData}</p>
                        `);
                        $("#crh_extra").empty();
                     }, 1500);
                 } else if (data.code === 201) {
                     //done: Ask our boyo to login (modal?)
                     $("#crh_msg").append(`
                        <p class="h5">Please login to reveal details.</p>
                    `);
                     $("#crh_extra").load("signup_failure.html");
                     setTimeout(() => {
                         $("#crh_extra").empty();
                         $("#crh_msg").empty();
                         $("#ContactThemBtn").removeClass("d-none");
                     }, 1500);
                 } else {
                     //dothis: Show error modal?
                     $("#done").append(`
                        <p class="h6">Something went wrong.</p>
                    `);
                     $("#crh_extra").load("signup_failure.html");
                     setTimeout(() => {
                         $("#crh_extra").empty();
                         $("#crh_msg").empty();
                         $("#ContactThemBtn").removeClass("d-none");
                     }, 1500);
                 }
            }
        }
        $.ajax(conForPTarget, conForPPayload).done(() => {
            console.log("[CONT_BTN] Contact Detail Fetch Attempted");
        });
    });
});


// DOWN BELOW IS ANOTHER APPROACH (USING ES6 TEMPLATE), BUT IT HAS LIMITATION OF DRAW AFTER DATA FETCH
// let getUrlVars = () =>  {
//     var vars = {};
//     var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
//         vars[key] = value;
//     });
//     return vars;
// }

// $(document).ready(() => {
//     let hrefparams = getUrlVars();
//     const posting_zoom_url = 'http://localhost:8084/ExchangePlatform/ad';
//     console.log(posting_zoom_url);
//     let posting_zoom_data = {
//         'adid': hrefparams.id,
//     };
//     let posting_fetch_payload = {
//         url: posting_zoom_url,
//         type: 'POST',
//         data: posting_zoom_data,
//         success: (data) => {
//             if (data.code === 100) { //success
//                 let conc_obj = data.mPze;
//                 let ad_id = conc_obj.ad_id;
//                 let ad_title = conc_obj.ad_title;
//                 let ad_desc = conc_obj.ad_desc;
//                 let ad_price = conc_obj.ad_price;
//                 let ad_location = conc_obj.ad_location;

//                 let ad_html_embed = `
//                     <div class="row justify-content-center">
//                     <div class="col-md-8 col-lg-7">
//                         <div id="listing-image-carousel" class="carousel slide" data-ride="carousel">
//                             <ol class="carousel-indicators">
//                                 <li data-target="#listing-image-carousel" data-slide-to="0" class="active"></li>
//                                 <li data-target="#listing-image-carousel" data-slide-to="1"></li>
//                                 <li data-target="#listing-image-carousel" data-slide-to="2"></li>
//                             </ol>
//                             <div class="carousel-inner">
//                                 <div class="carousel-item active">
//                                 <img src="assets/images/dark-card-bg-test.jpg" class="d-block w-100" >
//                                 </div>
//                                 <div class="carousel-item">
//                                 <img src="assets/images/dark-card-bg-test.jpg" class="d-block w-100" >
//                                 </div>
//                                 <div class="carousel-item">
//                                 <img src="assets/images/dark-card-bg-test.jpg" class="d-block w-100" >
//                                 </div>
//                             </div>
//                             <a class="carousel-control-prev" href="#listing-image-carousel" role="button" data-slide="prev">
//                                 <span class="carousel-control-prev-icon" aria-hidden="true"></span>
//                                 <span class="sr-only">Previous</span>
//                             </a>
//                             <a class="carousel-control-next" href="#listing-image-carousel" role="button" data-slide="next">
//                                 <span class="carousel-control-next-icon" aria-hidden="true"></span>
//                                 <span class="sr-only">Next</span>
//                             </a>
//                         </div>
//                         <div class="card mp-mat-sha-1 mt-4">
//                             <div class="card-body">
//                                 <h1 class="h2">Description</h1>
//                                 <p class="text-left">
//                                     Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.
//                                 </p>
//                             </div>
//                         </div>
//                     </div>
//                     <div class="col-md-4 col-lg-5">
//                         <div class="card mp-mat-sha-1">
//                             <div class="card-body">
//                                 <h1 class="display-4">&#8377; 1000000</h1>
//                                 <p class="text-left h5 text-muted">
//                                     ${ad_title}
//                                 </p>
//                                 <div class="row">
//                                     <p class="col-6 my-auto">15 June</p>
//                                     <p class="col-6 my-auto text-right">Manipal, KA</p>
//                                 </div>
//                             </div>
//                         </div>
//                         <div class="card mp-mat-sha-1 mt-4">
//                             <div class="card-body">
//                                 <h2 class="">Seller Description</h1>
//                                 <p class="text-left h5 text-muted" >
//                                     <a href="">username</a>
//                                 </p>
//                                 <button class="btn btn-outline-success btn-block mt-3">Chat with Seller</button>
//                             </div>
//                         </div>
//                         <div class="card mp-mat-sha-1 mt-4">
//                             <div class="card-body">
//                                 <h2 class="">Placeholder Card</h1>
//                                 <p class="text-left h5 text-muted" >
//                                     This card is here because I may incorporate new features and stuff/
//                                 </p>
//                             </div>
//                         </div>
//                     </div>
//                 </div>
//                 `
//                 $("#zoom-container").html(ad_html_embed);

//             } else { //failure

//             }
//         }
//     }
//     $.ajax(posting_zoom_url, posting_fetch_payload).done(()=>{
//         console.log("[AJAX] DONE POSTING ZOOM FETCH");
//     });
// });