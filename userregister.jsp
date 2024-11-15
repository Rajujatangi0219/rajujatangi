<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
  <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">


    <title>User Registration</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">

    <style>
        body {
            background-color: #f4f4f9; /* Light grey background */
            padding-top: 56px; /* Space for fixed navbar */
        }
        .container {
            max-width: 800px;
            background: #ffffff; /* White background for form container */
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Subtle shadow for better separation */
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
        .error {
            color: red;
            margin-bottom: 20px;
        }
        .form-control:focus {
            box-shadow: none;
            border-color: #007bff; /* Blue border on focus */
        }
        .valid-feedback {
            color: #007bff; /* Blue color for valid feedback */
            display: none;
            margin-top: 5px;
        }
        .valid-feedback::before {
            content: '✔'; /* Unicode for check mark */
            margin-right: 5px;
            color: #007bff; /* Blue color for check mark */
        }
        .invalid-feedback {
            color: red;
            display: none;
            margin-top: 5px;
        }
        .tick {
            color: #007bff; /* Blue color for tick */
            font-size: 1.5em;
            position: absolute;
            right: 10px;
            top: 35px;
        }
        .input-container {
            position: relative;
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
                <!-- Navbar Items -->
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
    <div class="container mt-3">
        <h2 class="text-center" style="font-family: 'Poppins', sans-serif; color: #007bff;">
            Create Your Bank Account
        </h2>
        <form method="post" action="registerProcess.jsp" onsubmit="return validateForm()">
            <div id="error" class="error"></div>

            <!-- Full Name -->
            <div class="form-group input-container">
                <label for="full_name">Full Name:</label>
                <input type="text" class="form-control" id="full_name" name="full_name" placeholder="Enter your full name" required>
                <span id="full_name_tick" class="tick"></span>
                <div id="full_name_error" class="invalid-feedback"></div>
            </div>

            <!-- Mobile Number -->
            <div class="form-group input-container">
                <label for="mobile_number">Mobile Number:</label>
                <input type="text" class="form-control" id="mobile_number" name="mobile_number" placeholder="Enter your mobile number" required>
                <span id="mobile_number_tick" class="tick"></span>
                <div id="mobile_number_error" class="invalid-feedback"></div>
            </div>

            <!-- Email -->
            <div class="form-group input-container">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                <span id="email_tick" class="tick"></span>
                <div id="email_error" class="invalid-feedback"></div>
            </div>

            <!-- Address -->
            <div class="form-group input-container">
                <label for="address">Address:</label>
                <input type="text" class="form-control" id="address" name="address" placeholder="Enter your full address" required>
                <span id="address_tick" class="tick"></span>
                <div id="address_error" class="invalid-feedback"></div>
            </div>

            <!-- Date of Birth -->
            <div class="form-group input-container">
                <label for="dob">Date of Birth:</label>
                <input type="date" class="form-control" id="dob" name="dob" placeholder="Enter your date of birth" required>
                <span id="dob_tick" class="tick"></span>
                <div id="dob_error" class="invalid-feedback"></div>
            </div>

            <!-- Account Type -->
            <div class="form-group input-container">
                <label for="account_type">Account Type:</label>
                <select class="form-control" id="account_type" name="account_type" required>
                    <option value="">Select Account Type</option>
                    <option value="Savings">Savings</option>
                    <option value="Current">Current</option>
                    <option value="Fixed Deposit">Fixed Deposit</option>
                </select>
                <span id="account_type_tick" class="tick"></span>
                <div id="account_type_error" class="invalid-feedback"></div>
            </div>

            <!-- Password -->
            <div class="form-group input-container">
                <label for="password">Password:</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Set your password here" required>
                <span id="password_tick" class="tick"></span>
                <div id="password_error" class="invalid-feedback"></div>
                <div id="passwordFeedback" class="valid-feedback">Password length is valid.</div>
            </div>

            <!-- UPI PIN -->
            <div class="form-group input-container">
                <label for="upi_pin">UPI PIN:</label>
                <input type="password" class="form-control" id="upi_pin" name="upi_pin" placeholder="Set your 6 digit UPI PIN here" required>
                <span id="upi_pin_tick" class="tick"></span>
                <div id="upi_pin_error" class="invalid-feedback"></div>
                <div id="upiPinFeedback" class="valid-feedback">UPI PIN length is valid.</div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary text-center rounded-pill mx-auto d-flex justify-content-center">Register</button>
            <a href="login.jsp" class="d-flex justify-content-center align-items-center mx-auto mt-2">I already have an account</a>
        </form>
    </div>

    <!-- Scripts -->
    <!-- jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <!-- Make sure to include Popper.js before Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        // Age calculation function
        function calculateAge(dob) {
            var today = new Date();
            var birthDate = new Date(dob);
            var age = today.getFullYear() - birthDate.getFullYear();
            var monthDifference = today.getMonth() - birthDate.getMonth();

            // If the birth month hasn't been reached yet this year, subtract 1 from age
            if (monthDifference < 0 || (monthDifference === 0 && today.getDate() < birthDate.getDate())) {
                age--;
            }
            return age;
        }

        // Validation Functions
        function validateFullName() {
            var fullName = document.getElementById('full_name').value;
            var tick = document.getElementById('full_name_tick');
            var error = document.getElementById('full_name_error');
            if (fullName.trim().length >= 3) {
                tick.textContent = '✔';
                error.style.display = 'none';
            } else {
                tick.textContent = '';
                error.textContent = 'Full Name must be at least 3 characters.';
                error.style.display = 'block';
            }
        }

        function validateMobileNumber() {
            var mobileNumber = document.getElementById('mobile_number').value;
            var tick = document.getElementById('mobile_number_tick');
            var error = document.getElementById('mobile_number_error');
            var regex = /^[0-9]{10}$/;
            if (regex.test(mobileNumber)) {
                tick.textContent = '✔';
                error.style.display = 'none';
            } else {
                tick.textContent = '';
                error.textContent = 'Mobile Number must be exactly 10 digits.';
                error.style.display = 'block';
            }
        }

        function validateEmail() {
            var email = document.getElementById('email').value;
            var tick = document.getElementById('email_tick');
            var error = document.getElementById('email_error');
            var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (regex.test(email)) {
                tick.textContent = '✔';
                error.style.display = 'none';
            } else {
                tick.textContent = '';
                error.textContent = 'Please enter a valid email address.';
                error.style.display = 'block';
            }
        }

        function validateAddress() {
            var address = document.getElementById('address').value;
            var tick = document.getElementById('address_tick');
            var error = document.getElementById('address_error');
            if (address.trim().length >= 10) {
                tick.textContent = '✔';
                error.style.display = 'none';
            } else {
                tick.textContent = '';
                error.textContent = 'Address must be at least 10 characters long.';
                error.style.display = 'block';
            }
        }

        function validateDOB() {
            var dob = document.getElementById('dob').value;
            var tick = document.getElementById('dob_tick');
            var error = document.getElementById('dob_error');
            if (dob) {
                var age = calculateAge(dob);
                if (age >= 18) {
                    tick.textContent = '✔';
                    error.style.display = 'none';
                } else {
                    tick.textContent = '';
                    error.textContent = 'You must be at least 18 years old.';
                    error.style.display = 'block';
                }
            } else {
                tick.textContent = '';
                error.textContent = 'Please provide your date of birth.';
                error.style.display = 'block';
            }
        }

        function validateAccountType() {
            var accountType = document.getElementById('account_type').value;
            var tick = document.getElementById('account_type_tick');
            var error = document.getElementById('account_type_error');
            if (accountType) {
                tick.textContent = '✔';
                error.style.display = 'none';
            } else {
                tick.textContent = '';
                error.textContent = 'Please select your account type.';
                error.style.display = 'block';
            }
        }

        function validatePassword() {
            var passwordField = document.getElementById('password');
            var passwordFeedback = document.getElementById('passwordFeedback');
            var tick = document.getElementById('password_tick');
            var error = document.getElementById('password_error');
            if (passwordField.value.length >= 6) {
                tick.textContent = '✔';
                passwordFeedback.style.display = 'block';
                error.style.display = 'none';
            } else {
                tick.textContent = '';
                passwordFeedback.style.display = 'none';
                error.textContent = 'Password must be at least 6 characters.';
                error.style.display = 'block';
            }
        }

        function validateUPIPin() {
            var upiPinField = document.getElementById('upi_pin');
            var upiPinFeedback = document.getElementById('upiPinFeedback');
            var tick = document.getElementById('upi_pin_tick');
            var error = document.getElementById('upi_pin_error');
            var regex = /^[0-9]{6}$/;
            if (regex.test(upiPinField.value)) {
                tick.textContent = '✔';
                upiPinFeedback.style.display = 'block';
                error.style.display = 'none';
            } else {
                tick.textContent = '';
                upiPinFeedback.style.display = 'none';
                error.textContent = 'UPI PIN must be exactly 6 digits.';
                error.style.display = 'block';
            }
        }

        // Attach event listeners
        document.getElementById('full_name').addEventListener('input', validateFullName);
        document.getElementById('mobile_number').addEventListener('input', validateMobileNumber);
        document.getElementById('email').addEventListener('input', validateEmail);
        document.getElementById('address').addEventListener('input', validateAddress);
        document.getElementById('dob').addEventListener('change', validateDOB);
        document.getElementById('account_type').addEventListener('change', validateAccountType);
        document.getElementById('password').addEventListener('input', validatePassword);
        document.getElementById('upi_pin').addEventListener('input', validateUPIPin);

        // Validate entire form on submit
        function validateForm() {
            var valid = true;

            // Call all validation functions
            validateFullName();
            validateMobileNumber();
            validateEmail();
            validateAddress();
            validateDOB();
            validateAccountType();
            validatePassword();
            validateUPIPin();

            // Check for any displayed errors
            var errors = document.querySelectorAll('.invalid-feedback');
            errors.forEach(function(error) {
                if (error.style.display === 'block') {
                    valid = false;
                }
            });

            if (!valid) {
                document.getElementById('error').innerHTML = "<p>Please correct the errors in the form.</p>";
            }

            return valid;
        }
    </script>
</body>
</html>
