<%-- 
    Document   : showPassengers.jsp
    Created on : May 1, 2024, 1:49:41 PM
    Author     : leeharika
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Passenger Details</title>
    <!-- Include Bootstrap CSS from CDN for styling -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .table-container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-secondary">
        <div class="container-fluid justify-content-center">
                 <div>
           <a class="navbar-brand" href="index.html">
    <img src="logo.jpeg" alt="Flight Management Logo" width="50" height="50">
    </div>

            <a class="navbar-brand" href="#">Flight Management</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="index.html">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="flights.jsp">Flights</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="crew.jsp">Crew</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="revenue.jsp">Analysis</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="passengers.jsp">Passengers</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <br>
    <br>
    <div class="container">
        <h1 class="text-center mt-5">Passenger Details</h1>
        <div class="table-container">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>Passenger ID</th>
                        <th>Passenger Name</th>
                        <th>Passenger Email</th>
                        <th>Frequent Flyer ID</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            String url = "jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl";
                            String user = "dbteam5";
                            String password = "F23dbteam5R";
                            Class.forName("oracle.jdbc.driver.OracleDriver");
                            conn = DriverManager.getConnection(url, user, password);
                            stmt = conn.createStatement();
                            String sql = "SELECT passengerId, passengerName, passengerEmail, frequentflyerid FROM passengers";
                            rs = stmt.executeQuery(sql);
                            while (rs.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs.getString("passengerId") + "</td>");
                                out.println("<td>" + rs.getString("passengerName") + "</td>");
                                out.println("<td>" + rs.getString("passengerEmail") + "</td>");
                                out.println("<td>" + rs.getString("frequentflyerid") + "</td>");
                                out.println("</tr>");
                            }
                        } catch (SQLException | ClassNotFoundException e) {
                            out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                        } finally {
                            try { if (rs != null) rs.close(); } catch (SQLException e) { /* ignored */ }
                            try { if (stmt != null) stmt.close(); } catch (SQLException e) { /* ignored */ }
                            try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JavaScript Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
