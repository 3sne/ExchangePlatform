let epglobals = {
    // vars
    _USERNAME: '',
    s_login_e: '',
    s_login_p: '',
    s_signup_e: '',
    s_singup_p: '',
    l_signup_e: '',
    l_signup_p: '',
    //methods
    toggleSpinner: function(elemId, spinner, classPlay) {
        if ($(spinner).hasClass(classPlay)) {
            $(elemId).addClass(classPlay);
            $(spinner).removeClass(classPlay);
        } else {
            $(elemId).removeClass(classPlay);
            $(spinner).addClass(classPlay);
        }
    }
};

$(document).ready(function () {
    console.log("From ajax_helper_main");

    // ** Login Handler

    

    // ** Try Sell Handler
    

});

// ** Change navbar to reflect logged in state
