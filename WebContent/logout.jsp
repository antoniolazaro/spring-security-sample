<html>
<body>
<h1>Logged out</h1>
<% session.invalidate(); 
response.sendRedirect(request.getContextPath());
%>
</body>
</html>