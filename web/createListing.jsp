<!doctype html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>

<%
String currentUserName = (String) session.getAttribute("currentUserName");

if (currentUserName != null) {
    System.out.println("AD JSP >> " + currentUserName);
} else {
    currentUserName = "";
    System.out.println("AD JSP >> No user identified, session invalid");
}

%>

<html lang="en">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">

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

        #zoom-container {
            transition: visibility 0.5s;
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
            0% {
                -webkit-transform: rotate(0deg);
            }

            100% {
                -webkit-transform: rotate(360deg);
            }
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }

        .capzies {
            text-transform: capitalize;
        }
    </style>
</head>

<body>
    <input type="hidden" id="session_uname_capture" name="session_uname_capture" value="<%=currentUserName%>" />

    <div class="container-fluid" style="background: linear-gradient(to right,#ff8a00,#da1b60);">
        <div class="row">
            <div class="col-4">
                <p class="display-4 ml-2 pl-4 mt-2 pt-4">Create an Ad.</p>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-8 col-sm-10">
                <form>
                    <div class="form-group mt-5">
                        <p class="h3 capzies">Details</p>
                        <div class="form-group">
                            <label for="fad_title">Ad Title</label>
                            <input type="text" class="form-control" id="fad_title"
                                placeholder="A compelling, but accurate ad title">
                        </div>
                        <div class="form-group">
                            <label for="fad_desc">Description</label>
                            <textarea class="form-control" id="fad_desc" rows="4"
                                placeholder="Give a detailed description of the item. It is best to include things like condition, contents and damages"></textarea>
                        </div>
                    </div>
                    <div class="form-group mt-5 w-50">
                        <p class="h3 capzies">Set a Price</p>
                        <div class="form-group">
                            <label for="fad_price">Price</label>
                            <div class="input-group input-group-alternative">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">&#8377;</span>
                                </div>
                                <input type="text" class="form-control" id="fad_price" min="0"
                                    pattern="(\d+[., \s]?\d?)*" placeholder="">
                            </div>
                        </div>
                    </div>
                    <div class="form-group mt-5">
                        <p class="h3 capzies">Post Some Images</p>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="fad_imageph">
                            <label class="custom-file-label" for="fad_imageph">Choose Photo</label>
                        </div>
                    </div>
                    <div class="form-group mt-5">
                        <p class="h3 capzies">Ad Location</p>
                        <div class="form-group">
                            <label class="mr-sm-2" for="fad_state">State</label>
                            <select id="fad_state" class="custom-select w-50">
                                <option selected>State</option>
                                <option value="Andaman and Nicobar Islands">Andaman and Nicobar Islands</option>
                                <option value="Andhra Pradesh">Andhra Pradesh</option>
                                <option value="Arunachal Pradesh">Arunachal Pradesh</option>
                                <option value="Assam">Assam</option>
                                <option value="Bihar">Bihar</option>
                                <option value="Chhattisgarh">Chhattisgarh</option>
                                <option value="Daman & Diu">Daman & Diu</option>
                                <option value="Delhi">Delhi</option>
                                <option value="Goa">Goa</option>
                                <option value="Gujarat">Gujarat</option>
                                <option value="Haryana">Haryana</option>
                                <option value="Himachal Pradesh">Himachal Pradesh</option>
                                <option value="Jammu and Kashmir">Jammu and Kashmir</option>
                                <option value="Jharkhand">Jharkhand</option>
                                <option value="Karnataka">Karnataka</option>
                                <option value="Kerala">Kerala</option>
                                <option value="Lakshadweep">Lakshadweep</option>
                                <option value="Madhya Pradesh">Madhya Pradesh</option>
                                <option value="Maharashtra">Maharashtra</option>
                                <option value="Manipur">Manipur</option>
                                <option value="Meghalaya">Meghalaya</option>
                                <option value="Mizoram">Mizoram</option>
                                <option value="Nagaland">Nagaland</option>
                                <option value="Orissa">Orissa</option>
                                <option value="Pondicherry">Pondicherry</option>
                                <option value="Punjab">Punjab</option>
                                <option value="Rajasthan">Rajasthan</option>
                                <option value="Sikkim">Sikkim</option>
                                <option value="Tamil Nadu">Tamil Nadu</option>
                                <option value="Tripura">Tripura</option>
                                <option value="Uttar Pradesh">Uttar Pradesh</option>
                                <option value="Uttarakhand">Uttarakhand</option>
                                <option value="West Bengal">West Bengal</option>
                            </select>
                        </div>
                        <div id="temp-loader" class="spinner-border d-none"></div>
                        <div id="city_group" class="form-group d-none">
                            <label class="mr-sm-3" for="fad_city">City</label>
                            <select id="fad_city" class="custom-select w-50">
                                <option selected>City</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group mt-5 w-50">
                        <p class="h3 capzies">Contact Number</p>
                        <div class="custom-file">
                            <div class="input-group input-group-alternative">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                </div>
                                <input type="text" class="form-control" id="fad_phone" placeholder="">
                            </div>
                        </div>
                    </div>
                    <div class="form-group mt-5 mb-5 w-50">
                        <button class="btn btn-primary" id="fad_post_btn" name="fad_post_btn" type="button">Post Ad</button>
                    </div>
                </form>
            </div>
        </div>
    </div>




    <script src="assets/external-scripts/jquery-3.4.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
    <script src="scripts/posting_gen_helper.js"></script>
    <script src="https://kit.fontawesome.com/9c19a5120e.js"></script>

</body>

</html>