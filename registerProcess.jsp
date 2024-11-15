<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Complete</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style type="text/css">
        
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

<div class="container-fluid alert alert-success">
    <%-- <h2>Registration Complete</h2> --%>

    <%
        String fullName = request.getParameter("full_name");
        String mobileNumber = request.getParameter("mobile_number");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob"); // Date of Birth as String in format yyyy-MM-dd
        String accountType = request.getParameter("account_type");
        String password = request.getParameter("password");
        String upiPin = request.getParameter("upi_pin");

        Connection conn = null;
        PreparedStatement pstmt = null;
        Statement stmt = null;
        ResultSet rs = null;
        Random rand = new Random();
        String errorMessage = null;

        try {
            // Load database driver and establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banksdb", "root", "root");

            // Generate account number and ATM card number
            String accountNumber = mobileNumber + String.format("%02d", rand.nextInt(100));
            String atmCardNumber = mobileNumber + String.format("%06d", rand.nextInt(1000000));
            
            // Calculate ATM card expiry date (7 years from today)
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.YEAR, 7);
            java.sql.Date atmCardExpiry = new java.sql.Date(cal.getTimeInMillis());

            // Generate ATM Card CVV
            String atmCardCVV = String.format("%03d", rand.nextInt(1000));

            // Calculate age from DOB
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date dobDate = sdf.parse(dob);
            Calendar dobCal = Calendar.getInstance();
            dobCal.setTime(dobDate);
            int dobYear = dobCal.get(Calendar.YEAR);
            int dobMonth = dobCal.get(Calendar.MONTH) + 1;
            int dobDay = dobCal.get(Calendar.DAY_OF_MONTH);

            Calendar now = Calendar.getInstance();
            int currentYear = now.get(Calendar.YEAR);
            int age = currentYear - dobYear;
            if (now.get(Calendar.MONTH) + 1 < dobMonth || (now.get(Calendar.MONTH) + 1 == dobMonth && now.get(Calendar.DAY_OF_MONTH) < dobDay)) {
                age--;
            }

            // Debugging: Print generated values
            // out.println("<div class='alert alert-info'>");
            // out.println("<h4>Debugging Information:</h4>");
            // out.println("<p><strong>Generated Account Number:</strong> " + accountNumber + "</p>");
            // out.println("<p><strong>Generated ATM Card Number:</strong> " + atmCardNumber + "</p>");
            // out.println("<p><strong>ATM Card Expiry Date:</strong> " + atmCardExpiry + "</p>");
            // out.println("<p><strong>ATM Card CVV:</strong> " + atmCardCVV + "</p>");
            // out.println("<p><strong>Calculated Age:</strong> " + age + "</p>");
            // out.println("</div>");

            // Convert dob to java.sql.Date
            java.sql.Date sqlDob = new java.sql.Date(dobDate.getTime());

            // Insert into users table
            String sqlInsertUser = "INSERT INTO users (full_name, mobile_number, email, address, dob, age, account_type, password, upi_pin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sqlInsertUser);
            pstmt.setString(1, fullName);
            pstmt.setString(2, mobileNumber);
            pstmt.setString(3, email);
            pstmt.setString(4, address);
            pstmt.setDate(5, sqlDob);
            pstmt.setInt(6, age); // Insert age
            pstmt.setString(7, accountType);
            pstmt.setString(8, password); // Make sure to encrypt password in real applications
            pstmt.setString(9, upiPin);
            int rowsAffectedUser = pstmt.executeUpdate();

            if (rowsAffectedUser > 0) {
                // Get user_id
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT LAST_INSERT_ID()");
                rs.next();
                int userId = rs.getInt(1);

                // Debugging: Print user_id
                // out.println("<div class='alert alert-info'>");
                // out.println("<p><strong>User ID:</strong> " + userId + "</p>");
                // out.println("</div>");

                // Insert into accounts table
                String sqlInsertAccount = "INSERT INTO accounts (user_id, account_number, atm_card_number, atm_card_expiry, atm_card_cvv, balance, account_type) VALUES (?, ?, ?, ?, ?, 0.00, ?)";
                pstmt = conn.prepareStatement(sqlInsertAccount);
                pstmt.setInt(1, userId);
                pstmt.setString(2, accountNumber);
                pstmt.setString(3, atmCardNumber);
                pstmt.setDate(4, atmCardExpiry); // Use java.sql.Date for expiry
                pstmt.setString(5, atmCardCVV);
                pstmt.setString(6, accountType);
                int rowsAffectedAccount = pstmt.executeUpdate();

                if (rowsAffectedAccount > 0) {
                    // Display registration details
                    out.println("<div class='alert alert-success'>");
                    out.println("<h4>Registration Successful!</h4>");
                    out.println("<p><strong>Full Name:</strong> " + fullName + "</p>");
                    out.println("<p><strong>Mobile Number:</strong> " + mobileNumber + "</p>");
                    out.println("<p><strong>Email:</strong> " + email + "</p>");
                    out.println("<p><strong>Address:</strong> " + address + "</p>");
                    out.println("<p><strong>Date of Birth:</strong> " + dob + "</p>");
                    out.println("<p><strong>Account Type:</strong> " + accountType + "</p>");
                    out.println("<p><strong>Account Number:</strong> " + accountNumber + "</p>");
                    out.println("<p><strong>ATM Card Number:</strong> " + atmCardNumber + "</p>");
                    out.println("<p><strong>ATM Card Expiry:</strong> " + atmCardExpiry + "</p>");
                    out.println("<p><strong>ATM Card CVV:</strong> " + atmCardCVV + "</p>");
                    out.println("<p><a href='downloadDetails.jsp?accountNumber=" + accountNumber + "&atmCardNumber=" + atmCardNumber + "' class='btn btn-primary'>Download Details</a></p>");
                    out.println("</div>");
                } else {
                    errorMessage = "Failed to create account. Please try again later.";
                }
            } else {
                errorMessage = "Failed to register user. Please try again later.";
            }
        } catch (Exception e) {
            errorMessage = "An error occurred during registration: "+"Mobile number is already registered please try with other mobile number " ;
            // e.printStackTrace(); // Log the exception
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }

        if (errorMessage != null) {
            out.println("<div class='alert alert-danger'>");
            out.println("<h4>" + errorMessage + "</h4>");
            out.println("</div>");
        }
    %>
</div>
</body>
</html>
