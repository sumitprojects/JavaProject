<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Error</title>
</head>
<body>
	<center>
		<h1>Error</h1>
		<h2><%
                    if(exception != null){
                        out.print(exception.getMessage());
                    }else{
                        //int a = response.getStatus();
                        response.sendError(404,"Page Not Found");
                    }
                    
                     %><br/> </h2>
	</center>	
</body>
</html>