<%-- 
    Document   : getxmldata
    Created on : Jul 4, 2018, 3:51:23 PM
    Author     : Viki
https://maps.googleapis.com/maps/api/geocode/xml?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyB4JizYu52_4feQZfvuBvZGGqQC8hqf_oA

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
    <head>
        <title>Books Management</title>
        <link rel="stylesheet" type="text/css" href="https://bootswatch.com/3/paper/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://bootswatch.com/3/assets/css/custom.min.css">
    </head>
    <body>
        <div class="container">
            <center>
                <h1>Google Map Data</h1>
            </center>

            <div align="center">
                <div class="col-lg-12">
                    <div class="bs-component">
                        <input type="search" name="datatable" onchange="showData(this.value)" onkeyup="this.onchange();" onpaste="this.onchange();" oncut="this.onchange();" oninput="this.onchange();">
                        <table class="table table-striped table-hover ">
                            <thead>
                                <tr>
                                    <th>Formatted Address</th>
                                    <th>Latitude</th>
                                    <th>Logitude</th>
                                </tr>
                            </thead>
                            <tbody id="datatable">
                                <tr>
                                    <td>Address</td>
                                    <td>latitude</td>
                                    <td>longitude</td>
                                </tr>
                            </tbody>
                        </table> 
                    </div><!-- /example -->
                </div>
            </div>
            <script type="text/javascript">
                function showData(str) {
                    var xmlhttp = new XMLHttpRequest();
                    if (str.length === 0) {
                        document.getElementById("datatable").innerHTML = "";
                        console.log(this.responseText);
                    } else {
                        xmlhttp.onreadystatechange = function () {
                            if (this.readyState === 4 && this.status === 200) {
                                xmlDoc = xmlhttp.responseXML;
                                txt = "<tr>";
                                x = xmlDoc.getElementsByTagName("formatted_address");
                                txt += "<td>" + x[0].childNodes[0].nodeValue + "</td>";
                                x = xmlDoc.getElementsByTagName("lat");
                                txt += "<td>" + x[0].childNodes[0].nodeValue + "</td>";
                                x = xmlDoc.getElementsByTagName("lng");
                                txt += "<td>" + x[0].childNodes[0].nodeValue + "</td>";
                                document.getElementById("datatable").innerHTML = txt;
                                console.log(txt);
                            }
                        };
                        /*Post method code*/
                        xmlhttp.open("GET", "https://maps.googleapis.com/maps/api/geocode/xml?address=" + str + "&key=AIzaSyB4JizYu52_4feQZfvuBvZGGqQC8hqf_oA", true);
                        xmlhttp.send();
                    }
                }
            </script>
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <script src="https://bootswatch.com/3/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    </body>
</html>