$(document).ready(() => {
    $("#myad_page_title").html(`
        ${$("#session_uname_capture").val()}'s Ad Manager - ExchangePlatform
    `);
    epglobals.toggleSpinner("#myAdsListCont", "#loader", "d-none");
    
    const myadsep = 'myAds';
    const myadpl = {
        data: {},
        url: myadsep,
        type: 'POST',
        success: (data) => {
            console.log(data);
            epglobals.toggleSpinner("#myAdsListCont", "#loader", "d-none");
            if (data.code === 100) {
                console.log("[MYADS] YAY");
                const realdata = data.ad_list;
                let _counter = {
                    activeAds: 0,
                    inactiveAds: 0,
                    totalAds: () => activeAds + inactiveAds
                }

                $("#myAdsListCont").append(`
                    <h1 class="display-4 mb-5 mt-3 text-right">${$("#session_uname_capture").val()}'s Active Listings.</h1>
                `);

                $("#myInactiveAdsListCont").append(`
                    <h1 class="display-4 mb-5 mt-3 text-right">${$("#session_uname_capture").val()}'s Archived Listings.</h1>
                `);

                for (const posting of realdata) {
                    let ad_id = posting.ad_id;
                    let ad_poster_id = posting.ad_poster_id;
                    let ad_category_id = posting.ad_category_id;
                    let ad_title = posting.ad_title;
                    let ad_price = posting.ad_price;
                    let ad_desc = posting.ad_desc;
                    let ad_date = new Date(posting.ad_date).toDateString();
                    let ad_location_id = posting.ad_location_id;
                    let ad_location_city = posting.ad_location_city;
                    let ad_location_state = posting.ad_location_state;
                    let ad_status = posting.ad_status;

                    let ahtmlsnip = `
                    <div id="posting_card_${ad_id}" class="card mt-4 mp-mat-sha-1">
                        <div class="row flex-wrap c-row">
                            <div class="col-md-3 col-lg-4">
                                <div class="img_wrapper h-100">
                                    <img class="card-img-top" src="assets/images/404-bg-1.jpg" height="100%" alt="Card image cap">
                                </div>
                            </div>
                            <div class="col-md-9 col-lg-8 mt-3 mb-3">
                                <div>
                                    <div class="row mr-2">
                                        <div class="col-10">
                                            <a style="text-decoration: none; color: inherit;" href="ad.jsp?id=${ad_id}">    
                                                <h4 class="card-title">${ad_title}</h4>
                                            </a>
                                            <h4 class="card-subtitle text-muted">&#8377; ${ad_price}</h4>
                                        </div>
                                        <div class="col-2 text-right">
                                            <div class="btn-group" role="group" aria-label="Basic example">
                                                <button type="button" class="btn btn-outline-success mas-button" data-toggle="tooltip" data-placement="top" data-postingid="${ad_id}" data-postingcat="${ad_category_id}" data-posterid="${ad_poster_id}" title="Mark as Sold"><i class="fas fa-dollar-sign"></i></span></button>
                                                <button type="button" class="btn btn-outline-danger trash-button" data-toggle="tooltip" data-placement="top" data-postingid="${ad_id}" data-postingcat="${ad_category_id}" data-posterid="${ad_poster_id}" title="Delete"><i class="fas fa-trash-alt"></i></button>
                                            </div>
                                            <div id="err_badge_${ad_id}">
                                                <span id="ad_status_badge_${ad_id}" class="badge badge-dark">${(ad_status == 1) ? "ACTIVE" : "SOLD"}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="cont_desc card-text mt-2 mr-2">${ad_desc}</div>
                                <div class="cont_footer row mr-2">
                                    <p class="col-4 card-text my-auto"><small class="text-muted">${ad_date}</small></p>
                                    <p class="col-8 card-text my-auto text-right"><small class="text-muted">${ad_location_city}, ${ad_location_state}</small></p>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    `;
                    if (ad_status == 0) { // Inactive
                        _counter.inactiveAds += 1;
                        $("#myInactiveAdsListCont").append(ahtmlsnip);
                        $("#posting_card_" + ad_id).addClass("bg-success").addClass("text-white").find(".mas-button").remove();
                        $("#posting_card_" + ad_id).find(".text-muted").removeClass("text-muted");

                    } else if (ad_status == 1) { //Active
                        _counter.activeAds += 1;
                        $("#myAdsListCont").append(ahtmlsnip);
                    }
                }

                if (_counter.inactiveAds === 0) {
                    $("#myInactiveAdsListCont").empty();
                }

                if (_counter.activeAds === 0) {
                    $("#myAdsListCont").empty();
                }


                // activate tooltips
                $(function () {
                    $('[data-toggle="tooltip"]').tooltip();
                    $('.mas-button').click(function (e) { // Mark as Sold
                        const posting_id = $(this).attr('data-postingid');
                        const posting_cat = $(this).attr('data-postingcat');
                        const poster_id = $(this).attr('data-posterid');
                        console.log('[MAS] ', posting_id, posting_cat, poster_id);
                        $.ajax({
                            url: 'adEdit',
                            data: {
                                sig: 'MAS',
                                postingId: posting_id,
                                postingCat: posting_cat,
                                posterId: poster_id
                            },
                            method: 'POST',
                            success: (data) => {
                                console.log(data);
                                switch (data.code) {
                                    case 100: // success
                                        // 1.disable tooltip
                                        $("#posting_card_" + posting_id).find('.mas-button').tooltip('hide');

                                        // 2.Change Card UI
                                        $("#posting_card_" + posting_id)
                                            .addClass("bg-success")
                                            .addClass("text-white")
                                            .find(".mas-button")
                                            .remove();
                                        $("#posting_card_" + posting_id).find(".text-muted").removeClass("text-muted");

                                        // 3. Change Badge
                                        $("#ad_status_badge_" + posting_id).val('SOLD');

                                        // 4. Pop & Push to #myInactiveAdsListCont
                                        setTimeout(() => {
                                            $("#posting_card_" + posting_id).appendTo("#myInactiveAdsListCont");
                                        }, 500);

                                        break;

                                    default:
                                        $("#err_badge_" + posting_id).append(`
                                            <span id="temp_info_${posting_id}" class="badge badge-danger">ERROR</span>
                                        `);
                                        setTimeout(() => {
                                            $("#temp_info_" + posting_id).remove();
                                        }, 1000);
                                        break;
                                }
                            },
                            error: (data) => {
                                console.log('[MAS] ERROR! ', data);
                            }
                        });
                    });
                    $(".trash-button").click(function () { // Delete Posting
                        const posting_id = $(this).attr('data-postingid');
                        const posting_cat = $(this).attr('data-postingcat');
                        const poster_id = $(this).attr('data-posterid');
                        console.log('[TRASH] ', posting_id, posting_cat, poster_id);
                        $.ajax({
                            url: 'adEdit',
                            data: {
                                sig: 'DEL',
                                postingId: posting_id,
                                postingCat: posting_cat,
                                posterId: poster_id
                            },
                            method: 'POST',
                            success: (data) => {
                                switch (data.code) {
                                    case 100: // success
                                        // 1.disable tooltip
                                        $("#posting_card_" + posting_id).find('.trash-button').tooltip('hide');
                                        $("#posting_card_" + posting_id).remove();
                                        break;

                                    default:
                                        $("#err_badge_" + posting_id).append(`
                                            <span id="temp_info_${posting_id}" class="badge badge-danger">ERROR</span>
                                        `);
                                        setTimeout(() => {
                                            $("#temp_info_" + posting_id).remove();
                                        }, 1000);
                                        break;
                                }
                            },
                            error: (data) => {
                                console.log('[DEL] ERROR! ', data);
                            }
                        });
                    });
                });

            } else if (data.code === 101) { // no ads posted by user yet
                console.log("[MYADS] NO ADS POSTED BY USER");
                const noadsmsg = `
                    <div class="jumbotron m-4">
                        <h1 class="display-4">Hello, ${$("#session_uname_capture").val()} !</h1>
                        <p class="lead">You haven't posted any ads on ExchangePlatform yet. Click on the sell button above to get started!</p>
                        <hr class="my-4">
                        <p>You will be able to see the ads created by you on this page. Hope we see you soon!.</p>
                    </div>
                `;
                $("#myAdsListCont").html(noadsmsg);


            } else if (data.code === 201) { //boyo not logged in get him out of here!!
                $("#myAdsListCont").load("signup_failure.html");
                setTimeout(() => {
                    location = '/ExchangePlatform';
                }, 2000);


            } else { //misc errors
                const stwbad = `
                    <div class="jumbotron m-4">
                        <h1 class="display-4">Hello, ${$("#session_uname_capture").val()} !</h1>
                        <p class="lead">It seems like some bugs need to be squashed! Please visit again after sometime to see if things are working.</p>
                        <hr class="my-4">
                        <p>Meanwhile, you can hangout and check what others are posting.</p>
                        <a class="btn btn-outline-success btn-lg" href="/ExchangePlatform" role="button">Home</a>
                    </div>
                `;
                $("#myAdsListCont").html(stwbad);
            };
        },
        error: (data) => {
            epglobals.toggleSpinner("#myAdsListCont", "#loader", "d-none");
        }
    }
    $.ajax(myadpl).done(() => {
        console.log("[MYADS] AJAX COMPLETE");
    });
});