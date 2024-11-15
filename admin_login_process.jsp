<%-- <%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String url = "jdbc:mysql://localhost:3306/banksdb";
    String dbUser = "root";
    String dbPassword = "root";
    
    String phonenumber = request.getParameter("username");
    String password = request.getParameter("password");
    
    String query = "SELECT * FROM Admin WHERE phone_number = ? AND encrypted_password= ?";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);
        
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, phonenumber);
        pstmt.setString(2, password);
        
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            // Admin credentials are correct
            String full_name=rs.getString("full_name");
             session = request.getSession();
             session.setAttribute("full_name", full_name);
            session.setAttribute("admin_phonenumber", phonenumber);
            response.sendRedirect("admin_dashboard.jsp");
        } else {
            // Invalid login
            out.println("<div class='alert alert-danger'>Invalid username or password. Please try again.</div>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<div class='alert alert-danger'>An error occurred: " + e.getMessage() + "</div>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>
 --%>
 <%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center">Admin Login</h2>

    <%
        String url = "jdbc:mysql://localhost:3306/banksdb";
        String dbUser = "root";
        String dbPassword = "root";
        
        String phonenumber = request.getParameter("username");
        String password = request.getParameter("password");
        
        String query = "SELECT * FROM Admin WHERE phone_number = ? AND encrypted_password = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUser, dbPassword);
            
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, phonenumber);
            pstmt.setString(2, password);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Admin credentials are correct
                String full_name = rs.getString("full_name");
                 session = request.getSession();
                session.setAttribute("full_name", full_name);
                session.setAttribute("admin_phonenumber", phonenumber);
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                // Invalid login
                %>
                <div class="alert alert-danger">Invalid username or password. Please try again.</div>
                <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            %>
            <div class="alert alert-danger">An error occurred: <%= e.getMessage() %></div>
            <%
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    %>

</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
