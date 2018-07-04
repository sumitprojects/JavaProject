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
                <h1>Books Management</h1>
                <h2>
                    <a href="new">Add New Book</a>
                    &nbsp;&nbsp;&nbsp;
                    <a href="list">List All Books</a>

                </h2>
            </center>

            <div align="center">
                <div class="col-lg-12">
                    <div class="bs-component">
                        Search Book:
                        <input type="search" name="booksearch" onchange="showHint(this.value)" onkeyup="this.onchange();" onpaste="this.onchange();" oncut="this.onchange();" oninput="this.onchange();">
                        <table class="table table-striped table-hover ">
                            <thead>
                            <caption><h2>List of Books</h2></caption>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Author</th>
                                <th>Price</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody id="searchTable">
                                <c:forEach var="book" items="${listBook}">
                                    <tr>
                                        <td><c:out value="${book.id}" /></td>
                                        <td><c:out value="${book.title}" /></td>
                                        <td><c:out value="${book.author}" /></td>
                                        <td><c:out value="${book.price}" /></td>
                                        <td>
                                            <a href="edit?id=<c:out value='${book.id}' />">Edit</a>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <a href="delete?id=<c:out value='${book.id}' />">Delete</a>                    	
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table> 
                    </div>
                </div><!-- /example -->
            </div>
        </div>
        <script type="text/javascript">
            function showHint(str) {
                var xmlhttp = new XMLHttpRequest();
                if (str.length === 0) {
                    xmlhttp.onreadystatechange = function () {
                        if (this.readyState === 4 && this.status === 200) {

                            document.getElementById("searchTable").innerHTML = this.responseText;
                            console.log(this.responseText);
                        }
                    };
                    //get method code
                    xmlhttp.open("GET", "getbook?booksearch=" + str, true);
                    xmlhttp.send();
                } else {
                    xmlhttp.onreadystatechange = function () {
                        if (this.readyState === 4 && this.status === 200) {

                            document.getElementById("searchTable").innerHTML = this.responseText;
                            console.log(this.responseText);
                        }
                    };
                    /*Post method code*/
                    xmlhttp.open("POST", "getbook", true);
                    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    xmlhttp.send("booksearch=" + str);
                }
            }
        </script>
        <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
        <script src="https://bootswatch.com/3/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    </body>
</html>