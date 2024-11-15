<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f4f9; /* Light grey background */
            padding-top: 56px; /* Space for fixed navbar */
        }
        .container {
            max-width: 600px;
            background: #ffffff; /* White background for form container */
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Subtle shadow for better separation */
            margin-top: 30px; /* Margin from top */
        }
        .navbar {
            margin-bottom: 20px;
            background-color: #343a40; /* Dark navbar background */
            position: fixed; /* Fixed position for the navbar */
            top: 0;
            width: 100%;
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
        .alert {
            display: none;
        }
    </style>
    <script>
        function validateForm() {
            const phoneNumber = document.getElementById('phoneNumber').value;
            const password = document.getElementById('password').value;
            const errorMessage = document.getElementById('errorMessage');
            if (phoneNumber.length !== 10 || isNaN(phoneNumber)) {
                errorMessage.textContent = 'Phone number must be 10 digits.';
                errorMessage.style.display = 'block';
                return false;
            }
            if (password === '') {
                errorMessage.textContent = 'Please enter your password.';
                errorMessage.style.display = 'block';
                return false;
            }
            return true;
        }
    </script>
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

    <!-- Main Content -->
    <div class="container">
        <h2 class="text-center">Login</h2>
        <div id="errorMessage" class="alert alert-danger"></div>
        <form action="loginAction.jsp" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary d-flex justify-content-center align-items-center mx-auto col-2">Login</button>
            <div class="d-inline-flex justify-content-around align-items-center mx-auto mt-2" style="width: 100%;">
    <a href="userregister.jsp">I don't have an account</a>
    <a href="forgetpassword.jsp">I forgot my password?</a>
</div>


        </form>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
