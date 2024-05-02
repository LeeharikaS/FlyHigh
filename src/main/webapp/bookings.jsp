<%-- 
    Document   : bookings.jsp
    Created on : April 24, 2024, 12:24:41 PM
    Author     : leeharika
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Flights</title>
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
        <h1 class="mb-3">Search Available Flights</h1>
        <form action="bookings.jsp" method="get" class="row g-3">
            <div class="col-md-6">
                <label for="fromCity" class="form-label">From</label>
                <select class="form-select" id="fromCity" name="fromCity" required>
                    <option selected>Select Origin</option>
                    <option value="Chicago">Chicago</option>
                </select>
            </div>
            <div class="col-md-6">
                <label for="toCity" class="form-label">To</label>
                <select class="form-select" id="toCity" name="toCity" required>
                    <option selected>Select Destination</option>
                    <option value="Atlanta">Atlanta</option>
                    <option value="Austin">Austin</option>
                    <option value="Baltimore">Baltimore</option>
                    <option value="Boston">Boston</option>
                    <option value="Charlotte">Charlotte</option>
                </select>
            </div>
            <div class="col-12">
                <button type="submit" class="btn btn-primary">Search Flights</button>
            </div>
        </form>

        <% 
        String fromCity = request.getParameter("fromCity");
        String toCity = request.getParameter("toCity");
        if (fromCity != null && !fromCity.isEmpty() && toCity != null && !toCity.isEmpty()) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl", "dbteam5", "F23dbteam5R");
                String sql = "SELECT * FROM flights WHERE origin = ? AND destination = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, fromCity);
                stmt.setString(2, toCity);
                rs = stmt.executeQuery();

                out.println("<h2>Flight Results:</h2>");
                out.println("<table class='table'>");
                out.println("<tr><th>Flight ID</th><th>Flight Name</th><th>Origin</th><th>Destination</th><th>Departure date</th><th>Departure Time</th><th>Action</th></tr>");
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("flightId") + "</td>");
                    out.println("<td>" + rs.getString("flightName") + "</td>");
                    out.println("<td>" + rs.getString("origin") + "</td>");
                    out.println("<td>" + rs.getString("destination") + "</td>");
                    out.println("<td>" + rs.getString("departure_date") + "</td>");
                    out.println("<td>" + rs.getString("departure_time") + "</td>");
                    out.println("<td><form action='bookingDetails.jsp' method='post'><input type='hidden' name='flightId' value='" + rs.getString("flightId") + "'><button type='submit' class='btn btn-primary'>Book Now</button></form></td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            } catch (SQLException ex) {
                out.println("<p>Database error: " + ex.getMessage() + "</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
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
