<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title></title>
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
            <div class="row">
                <div class="col-lg-12">
                    <div class="well bs-component">
                        <div align="center">
                            <c:if test="${book != null}">
                                <form action="update" method="post" class="form-horizontal">
                                </c:if>
                                <c:if test="${book == null}" >
                                    <form action="insert" method="post" class="form-horizontal">
                                    </c:if>
                                    <caption>
                                        <h2>
                                            <c:if test="${book != null}">
                                                Edit Book
                                            </c:if>
                                            <c:if test="${book == null}">
                                                Add New Book
                                            </c:if>
                                        </h2>
                                    </caption>
                                    <c:if test="${book != null}">
                                        <input type="hidden" name="id" value="<c:out value='${book.id}' />" />
                                    </c:if>            
                                    <fieldset>
                                        <legend>Add book</legend>
                                        <div class="form-group">
                                            <label for="inputTile" class="col-lg-2 control-label">Book Title</label>
                                            <div class="col-lg-10">
                                                <input type="text" class="form-control" name="title" value="<c:out value='${book.title}' />" id="inputTitle" placeholder="Enter Title">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputAuthor" class="col-lg-2 control-label">Author</label>
                                            <div class="col-lg-10">
                                                <input type="text" class="form-control" name="author" value="<c:out value='${book.author}' />" id="inputauthor" placeholder="Enter Author">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inputPrice" class="col-lg-2 control-label">Price</label>
                                            <div class="col-lg-10">
                                                <input type="text" size="5" class="form-control" name="price" value="<c:out value='${book.price}' />" id="inputprice" placeholder="Enter Price">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-lg-10 col-lg-offset-2">
                                                <input type="submit" class="btn btn-primary">
                                            </div>
                                        </div>
                                    </fieldset>
                                </form>
                        </div>	
                    </div>
                </div>       
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
        <script src="https://bootswatch.com/3/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    </body>
</html>
