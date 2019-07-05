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
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
    <title>Home - Exchange Platform</title>
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
            width: 140vw;
            height: 800px;
            background: linear-gradient(to right,#ff8a00,#da1b60);
            /* background: #c31432;
            background: -webkit-linear-gradient(to right, #240b36, #c31432);
            background: linear-gradient(to right, #240b36, #c31432); */
            top: -20%;
            left: -20%;
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

        .my-loader {
            
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

        @-webkit-keyframes spin {
            0% { -webkit-transform: rotate(0deg); }
            100% { -webkit-transform: rotate(360deg); }
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>

<body>
    <script type="text/html" id="template">
        <button id="dd-toggle" type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
            aria-expanded="false" data-content="username">
        </button>
        <div class="dropdown-menu dropdown-menu-right">
            <button class="dropdown-item" type="button" id="dd-user-ads">My Ads</button>
            <button class="dropdown-item" type="button">Settings</button>
            <button class="dropdown-item" type="button" id="dd-user-logout">Logout</button>
        </div>
    </script>

    <input type="hidden" id="session_uname_capture" name="session_uname_capture" value="<%=currentUserName%>" />
    <!-- BACKGROUND TILT -->
    <div id="fancylinething"></div>

    <!-- NAVBAR -->
    <div id="navbar-container"></div>

    <!-- BUFFER BEFORE ADS -->
    <div class="container-fluid">
        <div class="row justify-content-center">
            <div id="first-img" class="d-flex text-center justify-content-center align-items-center">
                <p class="display-3" style="color: white">Say goodbye to your Notes.</p>
            </div>
        </div>
    </div>

    <!-- AD CONTAINER -->
    <div id="ad_container_custom" class="container"></div>

    <div class="container-fluid my-4">
        <div class="row justify-content-center">
            <div id="loader" class="my-loader d-none m-4 "></div>
        </div>
    </div>

    <div class="container my-4">
        <div class="row justify-content-center">
            <button id="more_ad_loader" class="btn btn-outline-primary my-2" type="button">Show More</button>
        </div>
    </div>

    <!-- FOOTER -->
    <div id="site_footer" role="footer" class="container-fluid"></div>


    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <!-- UNCOMMENT BEFORE LAUNCH <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script> -->
    <script src="assets/external-scripts/jquery-3.4.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
    <script src="assets/external-scripts/jquery.loadTemplate.js"></script>
    <script>$("#navbar-container").load("navbar.html");</script>
    <script src="scripts/posting_loader.js"></script>
    <script src="scripts/ajax_helper_main.js"></script>

    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/9c19a5120e.js"></script>

</body>

</html>