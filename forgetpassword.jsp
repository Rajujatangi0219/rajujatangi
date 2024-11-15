<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
         /* Navbar styling */
        .navbar {
            margin-bottom: 20px;
            transition: background-color 0.3s ease;
            background-color: #343a40; /* Dark navbar background */
            position: sticky;
            top: 0;
            z-index: 1020; /* Ensures navbar is on top of other elements */
        }

        .navbar-nav .nav-link {
            color: #ffffff !important; /* White text color */
            transition: color 0.3s ease;
        }

        .navbar-brand {
            font-weight: bold;
            color: #ffffff !important; /* White text color for brand */
        }

        .navbar-toggler-icon {
            background-image: url('data:image/svg+xml;charset=utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30"><path stroke="currentColor" stroke-width="2" d="M5 7h20M5 15h20M5 23h20"/></svg>');
        }

        .navbar-nav .nav-link:hover {
            color: #007bff !important; /* Blue color on hover */
        }

        .navbar-dark .navbar-nav .nav-link.active {
            color: #007bff !important; /* Blue color for active link */
        }

        .navbar-dark .navbar-toggler {
            border-color: #ffffff; /* White border for toggler */
        }
        .form-container {
            margin: 50px auto;
            width: 50%;
            padding: 40px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            background-color: white;
            border-radius: 10px;
        }
        .valid-feedback {
            color: green;
            font-size: 0.7em;
        }
        .invalid-feedback {
            color: red;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="#">StateBankOfIndia</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.html">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#services">Services</a>
                </li>
                 <!-- New Navbar Items -->
                <li class="nav-item">
                    <a class="nav-link" href="#about">About Us</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#contact">Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="userregister.jsp">Register</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="admin_login.jsp">Adminlogin</a>
                </li>
               
            </ul>
        </div>
    </nav>

<div class="container">
    
    <div class="form-container">
        <h3 class="text-center">Forgot Password</h3>

        <!-- Check if the form has been submitted -->
        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String mobile = request.getParameter("mobile");
                String dob = request.getParameter("dob");
                String upi_pin = request.getParameter("upi_pin");

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Database connection
                    String url = "jdbc:mysql://localhost:3306/banksdb";
                    String dbUser = "root";
                    String dbPassword = "root";
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);

                    // SQL query to match the user's details
                    String query = "SELECT full_name, password FROM Users WHERE mobile_number = ? AND dob = ? AND upi_pin = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, mobile);
                    pstmt.setString(2, dob);
                    pstmt.setString(3, upi_pin);

                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        // User found, show the password
                        String fullName = rs.getString("full_name");
                        String password = rs.getString("password");
        %>
                      <%-- <%--   <%-- <p class="text-center">Hello </p> --%>
                        <p class="text-center ">I am happy to assist you. <strong class="text-success"><%= fullName %>!</strong> Your password is:<strong class="text-success"><%= password %></strong></p>
                        <%-- <div class="alert alert-success text-center"><strong><%= password %></strong></div> --%>
                        <p class="text-center">Please don't share confidential details with anyone.</p>
                        <div class="countdown text-center">
    Password will be visible for <span id="countdown">30</span> seconds.
</div> 


        <%
                    } else {
                        // User not found or incorrect details
        %>
                        <div class="alert alert-danger text-center">Invalid details. Please try again.</div>
        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger text-center'>An error occurred: " + e.getMessage() + "</div>");
                } finally {
                    // Close resources
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        %>

        <!-- Form to collect user details -->
        <form action="forgetpassword.jsp" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="mobile">Mobile Number:</label>
                <input type="text" class="form-control" id="mobile" name="mobile" required onkeyup="validateMobile()">
                <span id="mobile-feedback"></span>
            </div>
            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" class="form-control" id="dob" name="dob" required>
            </div>
            <div class="form-group">
                <label for="upi_pin">UPI PIN:</label>
                <input type="password" class="form-control" id="upi_pin" name="upi_pin" maxlength="6" required onkeyup="validateUpiPin()">
                <span id="upi-pin-feedback"></span>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Recover Password</button>
            <a href="login.jsp" class="d-flex justify-content-center align-items-center mx-auto mt-2">Back to Login page</a>
        </form>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    // Validate Mobile Number
    function validateMobile() {
        const mobile = document.getElementById("mobile").value;
        const feedback = document.getElementById("mobile-feedback");
        const mobilePattern = /^[0-9]{10}$/;

        if (mobilePattern.test(mobile)) {
            feedback.innerHTML = "Valid mobile number";
            feedback.className = "valid-feedback";
        } else {
            feedback.innerHTML = "Mobile number must be exactly 10 digits";
            feedback.className = "invalid-feedback";
        }
    }

    // Validate UPI PIN
    function validateUpiPin() {
        const upiPin = document.getElementById("upi_pin").value;
        const feedback = document.getElementById("upi-pin-feedback");
        const upiPinPattern = /^[0-9]{6}$/;

        if (upiPinPattern.test(upiPin)) {
            feedback.innerHTML = "Valid UPI PIN";
            feedback.className = "valid-feedback";
        } else {
            feedback.innerHTML = "UPI PIN must be exactly 6 digits";
            feedback.className = "invalid-feedback";
        }
    }

    // Validate the form before submission
    function validateForm() {
        const mobile = document.getElementById("mobile").value;
        const upiPin = document.getElementById("upi_pin").value;

        const mobilePattern = /^[0-9]{10}$/;
        const upiPinPattern = /^[0-9]{6}$/;

        if (!mobilePattern.test(mobile)) {
            alert("Please enter a valid 10-digit mobile number.");
            return false;
        }

        if (!upiPinPattern.test(upiPin)) {
            alert("Please enter a valid 6-digit UPI PIN.");
            return false;
        }

        return true; // Submit the form if all validations pass
    }
</script>
<!-- Countdown and Auto Refresh Script -->
<script>
    let countdownElement = document.getElementById("countdown");
    let timeLeft = 30;

    let countdownTimer = setInterval(function () {
        timeLeft--;
        countdownElement.textContent = timeLeft;

        if (timeLeft <= 0) {
            clearInterval(countdownTimer);
             window.location.href = "forgetpassword.jsp"; // Reload the page after 30 seconds
        }
    }, 1000);
</script>

</body>
</html>
