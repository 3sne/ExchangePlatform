<!doctype html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>

<%
String currentUserName = (String) session.getAttribute("currentUserName");

if (currentUserName != null) {
    System.out.println("JSP ++ " + currentUserName);
} else {
    currentUserName = "";
    System.out.println("No user identified, session invalid");
}

%>

<html lang="en">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <title>Exchange Platform</title>
    <style>
        body {
            overflow-x: hidden;
        }

        #first-img {
            height: 250px;
            width: 100%;
            overflow: hidden;
            /* background-image: url("assets/images/color-bg-1.jpg");
            background-attachment: fixed; */
        }

        #fancylinething {
            z-index: -20;
            display: block;
            position: absolute;
            overflow: hidden;
            width: 120vw;
            height: 600px;
            background: #c31432;
            background: -webkit-linear-gradient(to right, #240b36, #c31432);
            background: linear-gradient(to right, #240b36, #c31432);
            top: 0;
            left: -10%;
            -webkit-transform: rotate(-4deg);
            -moz-transform: rotate(-4deg);
            transform: rotate(-4deg);
        }

        #logo_placeholder {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
        }

        .mp-mat-sha-1 {
            transition: all 0.3s cubic-bezier(.25, .8, .25, 1);
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
        }

        .mp-mat-sha-1:hover {
            box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
        }
    </style>
</head>

<body>
    <input type="hidden" id="session_uname_capture" name="session_uname_capture" value="<%=currentUserName%>" />
    <!-- BACKGROUND TILT -->
    <%-- <div id="fancylinething"></div> --%>

    <!-- NAVBAR -->
    <nav class="navbar sticky-top navbar-dark bg-dark">
        <a class="navbar-brand ml-lg-5" href="#">
            <i class="fas fa-camera"></i>
            <span class="ml-lg-2 ml-1">ExchangePlatform</span>
        </a>
        <form class="form-inline" action="test.jsp">
            <input class="form-control mr-sm-2" type="search" placeholder="Search">
            <button class="btn btn-outline-primary" type="submit">Search</button>
        </form>

        <div class="form-inline">
            <button id="navbar-login-btn" class="btn btn-outline-primary mr-2" type="button" data-toggle="modal"
                data-target="#logInModal">Login</button>
            <div id="loadUserButton" class="btn-group mr-2" style="visibility: hidden;">
            </div>
            <button class="btn btn-primary mr-lg-5" type="button" data-toggle="modal" data-target="#trySellingModal">
                <i class="fas fa-dollar-sign"></i>
                <span class="ml-1 pr-1">Sell</span>
            </button>
        </div>

    </nav>

    <!-- LOGIN MODAL -->
    <div class="modal fade" id="logInModal" tabindex="-1" role="dialog" aria-labelledby="logInModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content shadow">
                <!-- <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">Sign In to post Ad</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div> -->
                <div class="modal-body">
                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <div class="text-center">
                                <p id="logo_placeholder" class="h1 ml-lg-2 ml-1">ExchangePlatform</p>
                            </div>
                            <div class="text-center text-muted mb-4">
                                <small>Sign In with e-mail</small>
                            </div>
                            <form role="form">
                                <!-- <div class="form-group">
                                    <div class="input-group input-group-alternative mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="far fa-user"></i></span>
                                        </div>
                                        <input class="form-control shadow" placeholder="Name" type="text">
                                    </div>
                                </div> -->
                                <div class="form-group">
                                    <div class="input-group input-group-alternative mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="far fa-paper-plane"></i></span>
                                        </div>
                                        <input id= "login-modal-email" class="form-control" placeholder="Email" type="email">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group input-group-alternative">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        </div>
                                        <input id="login-modal-pass" class="form-control" placeholder="Password" type="password">
                                    </div>
                                </div>
                                <!-- <div class="text-muted font-italic"><small>password strength: <span
                                            class="text-success font-weight-700">strong</span></small></div> -->
                                <!-- <div class="row my-4">
                                    <div class="col-12">
                                        <div class="custom-control custom-control-alternative custom-checkbox">
                                            <input class="custom-control-input" id="customCheckRegister"
                                                type="checkbox">
                                            <label class="custom-control-label" for="customCheckRegister">
                                                <span class="text-muted">I agree with the <a href="#!">Privacy
                                                        Policy</a></span>
                                            </label>
                                        </div>
                                    </div>
                                </div> -->
                                <div class="text-center">
                                    <button id="login-modal-btn" type="button" class="btn btn-primary mt-4">Log In</button>
                                </div>
                            </form>
                            <div class="text-center text-muted mt-2">
                                <p id="login-modal-err-zone" style="color: red"></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- TRYSELLING MODAL -->

    <div class="modal fade" id="trySellingModal" tabindex="-1" role="dialog" aria-labelledby="trySellingModal"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content shadow">
                <div class="modal-body">
                    <div class="row justify-content-center">
                        <div class="col-lg-10">
                            <div class="text-center">
                                <h2 id="logo_placeholder" class="ml-lg-2 ml-1">ExchangePlatform</h2>
                            </div>
                            <div class="text-center text-muted mb-4">
                                <small>Continue with e-mail</small>
                            </div>
                            <form role="form">
                                <div class="form-group">
                                    <div class="input-group input-group-alternative mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="far fa-paper-plane"></i></span>
                                        </div>
                                        <input class="form-control" placeholder="Email" type="email">
                                    </div>
                                </div>
                                <div class="text-center">
                                    <button type="button" class="btn btn-primary mt-4">Next</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- AD ZOOMED IN --%>
    <div id="zoom-container" class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-7">
                <div id="listing-image-carousel" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#listing-image-carousel" data-slide-to="0" class="active"></li>
                        <li data-target="#listing-image-carousel" data-slide-to="1"></li>
                        <li data-target="#listing-image-carousel" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                        <img src="assets/images/dark-card-bg-test.jpg" class="d-block w-100" >
                        </div>
                        <div class="carousel-item">
                        <img src="assets/images/dark-card-bg-test.jpg" class="d-block w-100" >
                        </div>
                        <div class="carousel-item">
                        <img src="assets/images/dark-card-bg-test.jpg" class="d-block w-100" >
                        </div>
                    </div>
                    <a class="carousel-control-prev" href="#listing-image-carousel" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#listing-image-carousel" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
                <div class="card mp-mat-sha-1 mt-4">
                    <div class="card-body">
                        <h1 class="h2">Description</h1>
                        <p class="text-left">
                            Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-lg-5">
                <div class="card mp-mat-sha-1">
                    <div class="card-body">
                        <h1 class="display-4">&#8377; 1000000</h1>
                        <p class="text-left h5 text-muted">
                            Chemistry Notes VI sem
                        </p>
                        <div class="row">
                            <p class="col-6 my-auto">15 June</p>
                            <p class="col-6 my-auto text-right">Manipal, KA</p>
                        </div>
                    </div>
                </div>
                <div class="card mp-mat-sha-1 mt-4">
                    <div class="card-body">
                        <h2 class="">Seller Description</h1>
                        <p class="text-left h5 text-muted" >
                            <a href="">username</a>
                        </p>
                        <button class="btn btn-outline-success btn-block mt-3">Chat with Seller</button>
                    </div>
                </div>
                <div class="card mp-mat-sha-1 mt-4">
                    <div class="card-body">
                        <h2 class="">Placeholder Card</h1>
                        <p class="text-left h5 text-muted" >
                            This card is here because I may incorporate new features and stuff/
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <div class="container-fluid">
        <div class="row">
            <div class="page-footer font-small unique-color-dark col mt-4" style="padding: 0px;">
                <div style="background: #c31432;
                        background: -webkit-linear-gradient(to right, #240b36, #c31432);
                        background: linear-gradient(to right, #240b36, #c31432); width: 100%;">
                    <div class="container">
                        <!-- Grid row-->
                        <div class="row py-4 d-flex align-items-center">
                            <!-- Grid column -->
                            <div class="col-md-6 col-lg-5 text-center text-md-left mb-4 mb-md-0">
                                <h6 class="mb-0" style="color: rgb(255,255,255);">Get connected with us on social
                                    networks!</h6>
                            </div>
                            <!-- Grid column -->
                            <!-- Grid column -->
                            <div class="col-md-6 col-lg-7 text-center text-md-right">
                                <!-- Facebook -->
                                <a class="fb-ic">
                                    <i class="fab fa-facebook-f white-text mr-4" style="color: rgb(255,255,255);"> </i>
                                </a>
                                <!-- Twitter -->
                                <a class="tw-ic">
                                    <i class="fab fa-twitter white-text mr-4" style="color: rgb(255,255,255);"> </i>
                                </a>
                                <!--Linkedin -->
                                <a class="li-ic">
                                    <i class="fab fa-linkedin-in white-text mr-4 " style="color: rgb(255,255,255);">
                                    </i>
                                </a>
                                <!--Instagram-->
                                <a class="ins-ic">
                                    <i class="fab fa-instagram white-text" style="color: rgb(255,255,255);"> </i>
                                </a>
                            </div>
                            <!-- Grid column -->
                        </div>
                        <!-- Grid row-->
                    </div>
                </div>
                <!-- Footer Links -->
                <div class="container text-center text-md-left mt-5">
                    <!-- Grid row -->
                    <div class="row mt-3">
                        <!-- Grid column -->
                        <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
                            <!-- Content -->
                            <h6 class="text-uppercase font-weight-bold">EXCHANGE PLATFORM</h6>
                            <hr class="deep-purple accent-2 mb-4 mt-0 d-inline-block mx-auto" style="width: 60px;">
                            <p>A place where student can exchange notes and materials etc. This is bogus text so its
                                just random stuff to fill the column. Lorem Ipsum?</p>
                        </div>
                        <!-- Grid column -->
                        <!-- Grid column -->
                        <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
                            <!-- Links -->
                            <h6 class="text-uppercase font-weight-bold">Platforms</h6>
                            <hr class="deep-purple accent-2 mb-4 mt-0 d-inline-block mx-auto" style="width: 60px;">
                            <p>
                                <a href="#!">Web</a>
                            </p>
                            <p>
                                <a href="#!">Android</a>
                            </p>
                            <p>
                                <a href="#!">iOS</a>
                            </p>
                            <p>
                                <a href="#!">Bootstrap Angular</a>
                            </p>

                        </div>
                        <!-- Grid column -->
                        <!-- Grid column -->
                        <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
                            <!-- Links -->
                            <h6 class="text-uppercase font-weight-bold">About Us</h6>
                            <hr class="deep-purple accent-2 mb-4 mt-0 d-inline-block mx-auto" style="width: 60px;">
                            <p>
                                <a href="#!">About Developers</a>
                            </p>
                            <p>
                                <a href="#!">Our Story</a>
                            </p>
                            <p>
                                <a href="#!">Donate!</a>
                            </p>
                            <p>
                                <a href="#!">Help</a>
                            </p>

                        </div>
                        <!-- Grid column -->
                        <!-- Grid column -->
                        <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
                            <!-- Links -->
                            <h6 class="text-uppercase font-weight-bold">Contact</h6>
                            <hr class="deep-purple accent-2 mb-4 mt-0 d-inline-block mx-auto" style="width: 60px;">
                            <p>
                                <i class="fas fa-home mr-3"></i> Manipal, KA, India</p>
                            <p>
                                <i class="fas fa-envelope mr-3"></i> info@explat.com</p>
                            <p>
                                <i class="fas fa-phone mr-3"></i> + 01 234 567 88</p>
                            <p>
                                <i class="fas fa-print mr-3"></i> + 01 234 567 89</p>
                        </div>
                        <!-- Grid column -->
                    </div>
                    <!-- Grid row -->
                </div>
                <div class="footer-copyright text-center text-muted py-3">
                    All icons provided by <a href="https://fontawesome.com/license" target="_blank">fontawesome.com</a>, under Creative
                    Commons Attribution
                    4.0
                </div>
                <!-- Copyright -->
            </div>
            <!-- Footer -->
        </div>
    </div>


    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <!-- UNCOMMENT BEFORE LAUNCH <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script> -->
    <script src="assets/external-scripts/jquery-3.4.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
    <script src="assets/external-scripts/jquery.loadTemplate.js"></script>
    <script src="scripts/ajax_helper_main.js"></script>
    <script src="scripts/posting_zoom_helper.js"></script>

    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/9c19a5120e.js"></script>

    <script type="text/html" id="template">
        <button id="dd-toggle" type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
            aria-expanded="false" data-content="username">
        </button>
        <div class="dropdown-menu dropdown-menu-right">
            <button class="dropdown-item" type="button">My Ads</button>
            <button class="dropdown-item" type="button">Settings</button>
            <button class="dropdown-item" type="button" id="dd-user-logout">Logout</button>
        </div>
    </script>

    <%-- <script type="text/html" id="generic_ad_template">
        <div class="col-md-4">
                <div class="card mp-mat-sha-1">
                    <img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h4 class="card-title" data-content="ad_title">Card title</h4>
                        <p class="card-text" data-content="ad_desc">
                            Some quick example text to build on the card title
                            and make up the bulk of the card's content.
                        </p>
                        <p class="card-text h3" data-content="ad_price">
                        <small class="card-text text-muted" data-content="ad_location"></small>
                    </div>
                </div>
            </div>
    </script> --%>


</body>

</html>