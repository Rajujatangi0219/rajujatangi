<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "attachment; filename=AccountDetails.pdf");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    HttpSession session = request.getSession();
    Integer userId = (Integer) session.getAttribute("userId");
    
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banksdb", "root", "root");

        // Fetch user details
        String query = "SELECT * FROM users WHERE user_id = ?";
        ps = conn.prepareStatement(query);
        ps.setInt(1, userId);
        rs = ps.executeQuery();

        // Here you would typically generate a PDF with the user's details
        // For simplicity, we're just sending a plain text response
        java.io.PrintWriter out = response.getWriter();
        out.println("User Details\n");
        if (rs.next()) {
            out.println("Name: " + rs.getString("name"));
            out.println("Phone Number: " + rs.getString("mobile_number"));
            out.println("Account Balance: " + rs.getBigDecimal("balance"));
            out.println("Account Type: " + rs.getString("account_type"));
        }
        out.flush();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
