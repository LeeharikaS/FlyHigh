<%-- 
    Document   : CancelBooking.jsp
    Created on : April 23, 2024, 3:14:41 PM
    Author     : leeharika
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cancel Booking</title>
    <!-- Include Bootstrap CSS from CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
                        <a class="nav-link active" href="flights.jsp">Flights</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="crew.jsp">Crew</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="revenue.jsp">Analysis</a>
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
        <h1 class="mb-3">Cancel Booking</h1>
        <form action="CancelBooking.jsp" method="post">
            <div class="mb-3">
                <label for="bookingId" class="form-label">Booking ID</label>
                <input type="number" class="form-control" id="bookingId" name="bookingId" required>
            </div>
            <button type="submit" class="btn btn-primary">Cancel Booking</button>
        </form>

        <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            Connection conn = null;
            CallableStatement stmt = null;
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl", "dbteam5", "F23dbteam5R");
                stmt = conn.prepareCall("{ CALL CancelBooking(?) }");
                stmt.setInt(1, bookingId);
                stmt.execute();
                out.println("<p>Booking cancelled successfully.</p>");
            } catch (SQLException ex) {
                if (ex.getErrorCode() == 20003) {
                    out.println("<p>Error: " + ex.getMessage() + "</p>");
                } else if (ex.getErrorCode() == 20004) {
                    out.println("<p>Error: " + ex.getMessage() + "</p>");
                } else {
                    out.println("<p>Error executing procedure: " + ex.getMessage() + "</p>");
                }
            } finally {
                try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        %>
    </div>
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>