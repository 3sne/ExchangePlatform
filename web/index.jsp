<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <title>Exchange Platform</title>
    <style>
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
            width: 110vw;
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

    <!-- BACKGROUND TILT -->
    <div id="fancylinething"></div>

    <!-- NAVBAR -->
    <nav class="navbar sticky-top navbar-light bg-light">
        <a class="navbar-brand ml-lg-5" href="#">
            <i class="fas fa-camera"></i>
            <span class="ml-lg-2 ml-1">ExchangePlatform</span>
        </a>
        <form class="form-inline">
            <input class="form-control mr-sm-2" type="search" placeholder="Search">
            <button class="btn btn-outline-primary" type="submit">Search</button>
        </form>

        <div class="form-inline">
            <button class="btn btn-outline-primary mr-2" type="button" data-toggle="modal"
                data-target="#logInModal">Login</button>
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
                                        <input class="form-control" placeholder="Email" type="email">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group input-group-alternative">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        </div>
                                        <input class="form-control" placeholder="Password" type="password">
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
                                    <button type="button" class="btn btn-primary mt-4">Log In</button>
                                </div>
                            </form>
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


    <!-- BUFFER BEFORE ADS -->
    <div class="container-fluid">
        <div class="row">
            <div id="first-img"></div>
        </div>
    </div>

    <!-- AD CONTAINER -->
    <div class="container">
        <div class="row justify-content-center mt-3">
            <div class="col-md-4">
                <div class="card mp-mat-sha-1">
                    <img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h4 class="card-title">Card title</h4>
                        <p class="card-text">
                            Some quick example text to build on the card title
                            and make up the bulk of the card's content.
                        </p>
                        <a href="#!" class="btn btn-primary">Go somewhere</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mp-mat-sha-1">
                    <img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h4 class="card-title">Card title</h4>
                        <p class="card-text">
                            Some quick example text to build on the card title
                            and make up the bulk of the card's content.
                        </p>
                        <a href="#!" class="btn btn-primary">Go somewhere</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mp-mat-sha-1">
                    <img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h4 class="card-title">Card title</h4>
                        <p class="card-text">
                            Some quick example text to build on the card title
                            and make up the bulk of the card's content.
                        </p>
                        <a href="#!" class="btn btn-primary">Go somewhere</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row justify-content-center mt-3">
            <div class="col-md-4">
                <div class="card mp-mat-sha-1">
                    <img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h4 class="card-title">Card title</h4>
                        <p class="card-text">
                            Some quick example text to build on the card title
                            and make up the bulk of the card's content.
                        </p>
                        <a href="#!" class="btn btn-primary">Go somewhere</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mp-mat-sha-1">
                    <img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h4 class="card-title">Card title</h4>
                        <p class="card-text">
                            Some quick example text to build on the card title
                            and make up the bulk of the card's content.
                        </p>
                        <a href="#!" class="btn btn-primary">Go somewhere</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mp-mat-sha-1">
                    <img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h4 class="card-title">Card title</h4>
                        <p class="card-text">
                            Some quick example text to build on the card title
                            and make up the bulk of the card's content.
                        </p>
                        <a href="#!" class="btn btn-primary">Go somewhere</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row justify-content-center mt-3">
            <div class="col-md-4">
                <div class="card mp-mat-sha-1">
                    <img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h4 class="card-title">Card title</h4>
                        <p class="card-text">
                            Some quick example text to build on the card title
                            and make up the bulk of the card's content.
                        </p>
                        <a href="#!" class="btn btn-primary">Go somewhere</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mp-mat-sha-1">
                    <img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h4 class="card-title">Card title</h4>
                        <p class="card-text">
                            Some quick example text to build on the card title
                            and make up the bulk of the card's content.
                        </p>
                        <a href="#!" class="btn btn-primary">Go somewhere</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mp-mat-sha-1">
                    <img class="card-img-top" src="assets/images/dark-card-bg-test.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h4 class="card-title">Card title</h4>
                        <p class="card-text">
                            Some quick example text to build on the card title
                            and make up the bulk of the card's content.
                        </p>
                        <a href="#!" class="btn btn-primary">Go somewhere</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row justify-content-center mt-3">
            <button class="btn btn-outline-primary my-2" type="button">Show More</button>
        </div>
    </div>

    <!-- FOOTER -->

    <!-- <div class="container-fluid">
        <div class="row justify-content-center mt-2 mb-2 bg-light">
            <div class="col-12 text-center">
                <span>THIS IS THA FOOTAR</span>
            </div>
        </div>
    </div> -->

    <!-- Footer -->
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
                                <i class="fas fa-home mr-3"></i> New York, NY 10012, US</p>
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
                <div class="footer-copyright text-center py-3"> © 2019 Copyright: ExchangePlatform Inc
                </div>
                <!-- Copyright -->
            </div>
            <!-- Footer -->
        </div>
    </div>


    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>

    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/9c19a5120e.js"></script>

</body>

</html>