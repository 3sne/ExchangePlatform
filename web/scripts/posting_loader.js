$(document).ready(() => {

    //Ad Loader
    let row_id_indexer = 0;
    let ad_fetched_already = [];
    const ad_fetch_url = 'http://localhost:8084/ExchangePlatform/adfetch';
    let ad_fetch_data = {
        'max_ad_count': '12',
        'ad_except': ad_fetched_already
    };

    let ad_fetch_payload = {
        url: ad_fetch_url,
        type: 'POST',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(ad_fetch_data),
        success: (data) => {
            recvAdData = data;
            console.log(recvAdData);
            if (recvAdData.code == 100) {
                for (let i = row_id_indexer; i < row_id_indexer + 4; i++) {
                    $("#ad_row_" + i).html('');
                    $("#ad_container_custom").append('<div id="ad_row_' + i + '" class="row justify-content-center mt-3">');
                    for (let j = 0; j < 3; j++) {
                        let conc_obj = recvAdData.ad_list[i * 3 + j];
                        ad_fetched_already.push(conc_obj.ad_id);
                        let ad_id = conc_obj.ad_id;
                        let ad_poster_id = conc_obj.ad_poster_id;
                        let ad_category_id = conc_obj.ad_category_id;
                        let ad_title = conc_obj.ad_title;
                        let ad_price = conc_obj.ad_price;
                        let ad_date = new Date(conc_obj.ad_date).toDateString();
                        let ad_location_id = conc_obj.ad_location_id;
                        let ad_location_city = conc_obj.ad_location_city;
                        let ad_location_state = conc_obj.ad_location_state;
                        let appendAdHtmlCode = `
                        <div class="col-md-4">
                            <a style="text-decoration: none; color: inherit;" href="ad.jsp?id=${ad_id}">
                                <div class="card mp-mat-sha-1">
                                    <img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap">
                                    <div class="card-body">
                                        <h4 class="card-title" data-content="ad_price">&#8377; ${ad_price}</h4>
                                        <p class="card-subtitle" data-content="ad_title">${ad_title}</p>
                                    </div>
                                    <div class="card-footer text-muted">
                                        <div class="row">
                                            <p class="col-6 my-auto">${ad_date}</p>
                                            <p class="col-6 my-auto text-right">${ad_location_city}, ${ad_location_state}</p>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        `;
                        $("#ad_row_" + i).append(appendAdHtmlCode);
                    }
                }
                row_id_indexer += 4;
            } else {
                console.log("No more ads to display :)");
            }
        }
    }
    $.ajax(ad_fetch_url, ad_fetch_payload).done(() => {
        console.log("[AJAX] DONE AD FETCH");
        $("#site_footer").load("site_footer.html");
    });

    $("#more_ad_loader").click(() => {
        $.ajax({
            url: ad_fetch_url,
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(ad_fetch_data),
            success: (data) => {
                recvAdData = data;
                console.log(recvAdData);
                if (recvAdData.code == 100) {
                    for (let i = row_id_indexer; i < row_id_indexer + 4; i++) {
                        $("#ad_row_" + i).html('');
                        $("#ad_container_custom").append('<div id="ad_row_' + i + '" class="row justify-content-center mt-3">');
                        for (let j = 0; j < 3; j++) {
                            let index = (i - row_id_indexer) * 3 + j;
                            console.log(index);
                            let conc_obj = recvAdData.ad_list[index];
                            ad_fetched_already.push(conc_obj.ad_id);

                            let ad_id = conc_obj.ad_id;
                            let ad_poster_id = conc_obj.ad_poster_id;
                            let ad_category_id = conc_obj.ad_category_id;
                            let ad_title = conc_obj.ad_title;
                            let ad_price = conc_obj.ad_price;
                            let ad_date = new Date(conc_obj.ad_date).toDateString();
                            let ad_location_id = conc_obj.ad_location_id;
                            let ad_location_city = conc_obj.ad_location_city;
                            let ad_location_state = conc_obj.ad_location_state;
                            let appendAdHtmlCode = `
                                <div class="col-md-4">
                                    <a style="text-decoration: none; color: inherit;" href="ad.jsp?id=${ad_id}">
                                        <div class="card mp-mat-sha-1">
                                            <img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap">
                                            <div class="card-body">
                                                <h4 class="card-title" data-content="ad_price">&#8377; ${ad_price}</h4>
                                                <p class="card-subtitle" data-content="ad_title">${ad_title}</p>
                                            </div>
                                            <div class="card-footer text-muted">
                                                <div class="row">
                                                    <p class="col-6 my-auto">${ad_date}</p>
                                                    <p class="col-6 my-auto text-right">${ad_location_city}, ${ad_location_state}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            `;
                            $("#ad_row_" + i).append(appendAdHtmlCode);
                        }
                    }
                } else {
                    console.log("No more ads to display :)");
                }
                row_id_indexer += 4;
            }
        }).done(() => {
            console.log("[AJAX] DONE MORE AD FETCH");
        });
    });


});