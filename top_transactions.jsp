<%@ page import="java.sql.*, java.util.*, com.google.gson.Gson" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Top 10 Transactions This Month</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Include Chart.js Library -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="container mt-4">
    <h2>Top 10 Transactions This Month</h2>

    <!-- Canvas for the Chart -->
    <canvas id="transactionChart" width="400" height="200"></canvas>
</div>

<%
    // Database connection setup
    String url = "jdbc:mysql://localhost:3306/kingsDB"; // Adjust DB connection details
    String user = "root";
    String password = "root";
    
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    // List to store transaction data
    List<Map<String, Object>> transactionList = new ArrayList<>();
    
    try {
        // Connect to the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);

        // Query to get the top 10 transactions within a month
        String sql = "SELECT account_number, amount, transaction_type, transaction_date " +
                     "FROM transactions " +
                     "WHERE transaction_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH) " +
                     "ORDER BY amount DESC LIMIT 10";
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        
        // Iterate over result set and store data in a list
        while (rs.next()) {
            Map<String, Object> transaction = new HashMap<>();
            transaction.put("accountNumber", rs.getString("account_number"));
            transaction.put("amount", rs.getBigDecimal("amount"));
            transaction.put("transactionType", rs.getString("transaction_type"));
            transaction.put("date", rs.getDate("transaction_date").toString());
            transactionList.add(transaction);
        }
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
    
    // Convert transaction list to JSON format
    String jsonTransactionData = new Gson().toJson(transactionList);
%>

<script>
// Pass transaction data to JavaScript from JSP
const transactionData = <%= jsonTransactionData %>;

// Extract labels (transaction dates) and data (amounts) for the chart
const labels = transactionData.map(transaction => transaction.date);
const amounts = transactionData.map(transaction => transaction.amount);

// Create the chart
const ctx = document.getElementById('transactionChart').getContext('2d');
const transactionChart = new Chart(ctx, {
    type: 'bar', // Bar chart
    data: {
        labels: labels, // Dates of transactions
        datasets: [{
            label: 'Transaction Amount (Top 10)',
            data: amounts, // Amounts of transactions
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        plugins: {
            tooltip: {
                callbacks: {
                    // Show detailed transaction info on hover
                    label: function(context) {
                        const transaction = transactionData[context.dataIndex];
                        return `Account: ${transaction.accountNumber}, ` +
                               `Type: ${transaction.transactionType}, ` +
                               `Amount: ${transaction.amount}`;
                    }
                }
            }
        },
        scales: {
            y: {
                beginAtZero: true // Ensure Y-axis starts at 0
            }
        }
    }
});
</script>

<!-- Include Bootstrap JS (Optional) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
