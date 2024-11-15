<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    String phoneNumber = request.getParameter("phoneNumber");
    String password = request.getParameter("password");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banksdb", "root", "root");
        
        String query = "SELECT * FROM users WHERE mobile_number = ? AND password = ?";
        ps = conn.prepareStatement(query);
        ps.setString(1, phoneNumber);
        ps.setString(2, password);
        rs = ps.executeQuery();
        
        if (rs.next()) {
             session = request.getSession();
            session.setAttribute("userId", rs.getInt("user_id"));
            response.sendRedirect("userHome.jsp");
        } else {
            response.sendRedirect("login.jsp?error=Invalid credentials");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
