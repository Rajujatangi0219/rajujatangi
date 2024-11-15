<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .message-container {
            margin: 50px auto;
            text-align: center;
            width: 50%;
        }
    </style>
    <script>
        // Function to redirect after a delay
        function redirectToHome() {
            setTimeout(function() {
                window.location.href = "index.html";
            }, 3000); // Redirect after 3 seconds
        }
    </script>
</head>
<body onload="redirectToHome()">

<div class="message-container">
    <div class="alert alert-success">
        You have been logged out successfully.
    </div>
</div>

<%
    // Retrieve the current session
 session = request.getSession(false);
    if (session != null) {
        // Invalidate the session to log out the admin
        session.invalidate();
    }
%>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
