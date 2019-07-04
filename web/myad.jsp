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
    String redirectURL = "/ExchangePlatform/";
    response.sendRedirect(redirectURL);
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
            max-height: 16rem;
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

    <!-- NAVBAR -->
    <div id="navbar-container"></div>

    <div id="loader" class="my-loader d-none"></div>

    <div id="myAdsListCont" class="container mt-5"></div>

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
</body>

</html>