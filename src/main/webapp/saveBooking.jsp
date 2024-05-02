<%-- 
    Document   : saveBooking.jsp
    Created on : April 23, 2024, 2:24:41 PM
    Author     : leeharika
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Random" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Save Booking</title>
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
        <h1 class="mb-3">Save Booking</h1>
        <%
        String flightId = request.getParameter("flightId");
        int passengerId = Integer.parseInt(request.getParameter("passengerId"));
        String seatNumber = request.getParameter("seatNumber");
        if (flightId != null && !flightId.isEmpty() && passengerId > 0 && seatNumber != null && !seatNumber.isEmpty()) {
            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl", "dbteam5", "F23dbteam5R");
                String sql = "INSERT INTO bookings (BookingID, BookingDate, FlightID, Price, PassengerID, SeatNumber, Status) VALUES (SEQ_BOOKING_ID.NEXTVAL, SYSDATE, ?, ?, ?, ?, 'Confirmed')";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, flightId);
                Random random = new Random();
                int price = random.nextInt(201) + 50; // Random price between 50 and 250
                stmt.setDouble(2, price);
                stmt.setInt(3, passengerId);
                stmt.setString(4, seatNumber);
                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("<p>Booking successful!</p>");
                } else {
                    out.println("<p>Booking failed.</p>");
                }
            } catch (SQLException ex) {
                out.println("<p>Database error: " + ex.getMessage() + "</p>");
            } finally {
                try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        } else {
            out.println("<p>Invalid input data.</p>");
        }
        %>
    </div>
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>