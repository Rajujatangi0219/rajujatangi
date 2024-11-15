<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.io.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Download Details</title>
</head>
<body>
<%
    String accountNumber = request.getParameter("accountNumber");
    String atmCardNumber = request.getParameter("atmCardNumber");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load database driver and establish connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banksdb", "root", "root");
        
        // Fetch user details
        String sqlUser = "SELECT * FROM users u JOIN accounts a ON u.user_id = a.user_id WHERE a.account_number = ? AND a.atm_card_number = ?";
        pstmt = conn.prepareStatement(sqlUser);
        pstmt.setString(1, accountNumber);
        pstmt.setString(2, atmCardNumber);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            String fullName = rs.getString("full_name");
            String mobileNumber = rs.getString("mobile_number");
            String email = rs.getString("email");
            String address = rs.getString("address");
            String dob = rs.getDate("dob").toString();
            String accountType = rs.getString("account_type");
            String atmCardExpiry = rs.getDate("atm_card_expiry").toString();
            String atmCardCVV = rs.getString("atm_card_cvv");

            // Set the response content type and header
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"user_details.csv\"");

            // Write CSV content
            out.println("Full Name,Mobile Number,Email,Address,Date of Birth,Account Type,Account Number,ATM Card Number,ATM Card Expiry,ATM Card CVV");
            out.println(String.format("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s",
                fullName, mobileNumber, email, address, dob, accountType, accountNumber, atmCardNumber, atmCardExpiry, atmCardCVV));
        } else {
            out.println("No details found for the provided account and ATM card number.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error occurred while generating the CSV file.");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
</body>
</html>
