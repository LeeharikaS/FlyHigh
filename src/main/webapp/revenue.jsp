<%-- 
    Document   : revenue.jsp
    Created on : Apr 29, 2024, 12:30:10 AM
    Author     : leeharika
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Flight Revenues</title>
    <!-- Include Bootstrap CSS for styling -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Add your styles here */
        .revenue-report {
            margin-top: 20px;
        }
        .revenue-report thead {
            background-color: #007bff;
            color: #fff;
        }
        .revenue-report td, .revenue-report th {
            padding: 10px;
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
                        <a class="nav-link active" href="revenue.jsp">Analysis</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="passengers.jsp">Passengers</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <br>
    <br>
    <div class="container mt-5">
        <h1>All Flight Revenues</h1>
        <table class="table revenue-report">
            <thead>
                <tr>
                    <th>Flight ID</th>
                    <th>Revenue</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    Connection conn = null;
                    CallableStatement cstmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        String dbURL = "jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl"; // Replace with your database URL
                        String user = "dbteam5"; // Replace with your database username
                        String pass = "F23dbteam5R"; // Replace with your database password
                        conn = DriverManager.getConnection(dbURL, user, pass);
                        
                        String sql = "{ ? = call GetAllFlightRevenues() }";
                        cstmt = conn.prepareCall(sql);
                        cstmt.registerOutParameter(1, Types.REF_CURSOR); // Use standard SQL type for cursor
                        cstmt.execute();
                        
                        rs = (ResultSet) cstmt.getObject(1);
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getString("FlightID") + "</td>");
                            out.println("<td>$" + rs.getBigDecimal("Revenue").toPlainString() + "</td>");
                            out.println("</tr>");
                        }
                    } catch (SQLException ex) {
                        out.println("<div class='alert alert-danger' role='alert'>SQL Error: " + ex.getMessage() + "</div>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                        if (cstmt != null) try { cstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
    </div>
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

