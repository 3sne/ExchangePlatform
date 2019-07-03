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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" type="text/css"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
    <style>
        .mp-mat-sha-1 {
            transition: all 0.3s cubic-bezier(.25, .8, .25, 1);
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
        }

        .mp-mat-sha-1:hover {
            box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px rgba(0, 0, 0, 0.22);
        }

        .c-row {
            min-height: 10rem;
            /* max-height: 16rem; */
            /* height: 16rem; */
            overflow: hidden;
        }

        .image_wrapper img {
            display: inline-block;
            vertical-align: middle;
            max-width: none;
        }

        .cont_desc {
            max-height: 8rem;
            overflow: hidden;
        }

        .my-loader {
            position: absolute;
            left: 50%;
            top: 50%;
            z-index: 1;
            width: 150px;
            height: 150px;
            margin: -75px 0 0 -75px;
            border: 16px solid #f3f3f3;
            border-radius: 50%;
            border-top: 16px solid #3498db;
            width: 120px;
            height: 120px;
            -webkit-animation: spin 2s linear infinite;
            animation: spin 2s linear infinite;
        }

    </style>
</head>

<body>
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

    <input type="hidden" id="session_uname_capture" name="session_uname_capture" value="<%=currentUserName%>" />

    <!-- NAVBAR -->
    <div id="navbar-container"></div>

    <div id="loader" class="my-loader d-none"></div>

    <div class="container mt-5">
        <div class="card mp-mat-sha-1">
            <div class="row flex-wrap c-row">
                <div class="col-md-3 col-lg-4">
                    <div class="img_wrapper h-100">
                        <img class="card-img-top" src="assets/images/404-bg-1.jpg" height="100%" alt="Card image cap">
                    </div>
                </div>
                <div class="col-md-9 col-lg-8 mt-3 mb-3">
                    <div>
                        <div class="row mr-2">
                            <div class="col-6">
                                <h4 class="card-title">Chemistry Notes</h4>
                                <h4 class="card-subtitle text-muted">Rs 10000</h4>
                            </div>
                            <div class="col-6 text-right">
                                <div class="btn-group" role="group" aria-label="Basic example">
                                    <button type="button" class="btn btn-outline-success" data-toggle="tooltip"
                                        data-placement="top" title="Mark as Sold"><i
                                            class="fas fa-dollar-sign"></i></span></button>
                                    <button type="button" class="btn btn-outline-danger" data-toggle="tooltip"
                                        data-placement="top" title="Delete"><i class="fas fa-trash-alt"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p class="cont_desc card-text mt-2 mr-2">This card has a regular title and short paragraphy of text
                        below
                        it.
                        Description of 3-4 lines should suffice in this placeholder text bs thingy.
                        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                    </p>
                    <p class="card-text"><small class="text-muted">Date</small></p>
                </div>
            </div>
        </div>
    </div>


    <div id="site_footer" role="footer" class="container-fluid"></div>

    <script src="assets/external-scripts/jquery-3.4.1.js"></script>
    <script>
        $("#navbar-container").load("navbar.html");
        $("#site_footer").load("site_footer.html");
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
    <script src="assets/external-scripts/jquery.loadTemplate.js"></script>
    <script src="scripts/ajax_helper_main.js"></script>
    <script src="scripts/myads_helper.js"></script>

    <script src="https://kit.fontawesome.com/9c19a5120e.js"></script>
    <script>
        $(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
</body>

</html>