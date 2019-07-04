$(document).ready(() => {
    epglobals.toggleSpinner("#ad_container_custom", "#loader", "d-none");
    let row_id_indexer = 0;
    $.ajax({
        url: 'search',
        method: 'POST',
        data: {
            q: $("#search_query").val().trim()
        },
        success: (data) => {
            console.log("[SH] Success ", data);
            epglobals.toggleSpinner("#ad_container_custom", "#loader", "d-none");
            if (data.code === 100) {
                recvAdData = data.ad_list;
                for (let i = row_id_indexer; i < row_id_indexer + 4; i++) {
                    $("#ad_row_" + i).html('');
                    $("#ad_container_custom").append('<div id="ad_row_' + i + '" class="row justify-content-center mt-3">');
                    for (let j = 0; j < 3; j++) {
                        if (recvAdData[i * 3 + j]) {
                            conc_obj = recvAdData[i * 3 + j];
                        } else {
                            break;
                        }
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

            } else if (data.code === 101) {
                $("#ad_container_custom").append(`
                <div class="jumbotron text-white bg-dark text-center">
                    <h1 class="display-4">No results were found!</h1>
                    <p class="lead">The search functionality is very limited, so it will produce narrow results.</p>
                    <hr class="my-4" style="background-color: white;">
                    <p>It uses utility classes for typography and spacing to space content out within the larger container.</p>
                    <p class="lead">
                        <a class="btn btn-outline-success btn-lg" href="/ExchangePlatform" role="button">Home</a>
                    </p>
                </div>
                `);
            }
        },
        error: (data) => {
            console.log("[SH] Error ", data);
        }
    }).done(() => {
        console.log("[SH] Ajax complete");
        $("#site_footer").load("site_footer.html");
    });
});