<%-- 
    Document   : bookingDetails.jsp
    Created on : April 24, 2024, 9:24:41 AM
    Author     : leeharika
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashSet" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details</title>
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
        <h1 class="mb-3">Booking Details</h1>
        <% 
            String flightId = request.getParameter("flightId");
            if (flightId != null && !flightId.isEmpty()) {
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl", "dbteam5", "F23dbteam5R");
                    // SQL to fetch booked seats
                    String sql = "SELECT seatNumber FROM bookings WHERE flightId = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, flightId);
                    rs = stmt.executeQuery();

                    HashSet<String> bookedSeats = new HashSet<>();
                    while (rs.next()) {
                        bookedSeats.add(rs.getString("seatNumber"));
                    }

                    out.println("<form action='saveBooking.jsp' method='post'>");
                    out.println("<input type='hidden' name='flightId' value='" + flightId + "'>");
                    out.println("<div class='mb-3'>");
                    out.println("<label for='passengerId' class='form-label'>Passenger ID</label>");
                    out.println("<input type='number' class='form-control' id='passengerId' name='passengerId' required>");
                    out.println("</div>");
                    out.println("<div class='mb-3'>");
                    out.println("<label for='seatNumber' class='form-label'>Seat Number</label>");
                    out.println("<select class='form-select' id='seatNumber' name='seatNumber' required>");
                    out.println("<option value=''>Select a Seat</option>");
                    for (int row = 1; row <= 40; row++) {
                        for (char col = 'A'; col <= 'C'; col++) {
                            String seat = row + String.valueOf(col);
                            if (!bookedSeats.contains(seat)) {
                                out.println("<option value='" + seat + "'>" + seat + "</option>");
                            }
                        }
                    }
                    out.println("</select>");
                    out.println("</div>");
                    out.println("<button type='submit' class='btn btn-primary'>Book Now</button>");
                    out.println("</form>");

                } catch (SQLException ex) {
                    out.println("<p>Database error: " + ex.getMessage() + "</p>");
                } catch (ClassNotFoundException ex) {
                    out.println("<p>Driver not found: " + ex.getMessage() + "</p>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            } else {
                out.println("<p>Invalid flight ID.</p>");
            }
        %>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
