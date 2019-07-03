$(document).ready(() => {
    const myadsep = 'myAds';
    const myadpl = {
        data: {},
        url: myadsep,
        type: 'POST',
        success: (data) => {
            console.log(data);
            data.code = 101;
            if (data.code === 100) {
                console.log("YAY");
            } else if (data.code === 101) { // no ads posted by user yet
                console.log("NO ADS POSTED BY USER");
            } else if (data.code === 201) { //boyo not logged in get him out of here!!
                
            }
        }
    }
    $.ajax(myadpl).done(() => {
        console.log("[MYADS] AJAX COMPLETE");
    });
});