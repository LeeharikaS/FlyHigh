<%-- 
    Document   : AddFlights.jsp
    Created on : April 23, 2024, 2:24:41 PM
    Author     : leeharika
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Flights</title>
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
        <h1 class="mb-3">Add Flights</h1>
        <form action="AddFlights.jsp" method="post">
            <div class="mb-3">
                <label for="aircraftId" class="form-label">Aircraft ID</label>
                <input type="number" class="form-control" id="aircraftId" name="aircraftId" required>
            </div>
            <div class="mb-3">
                <label for="startDate" class="form-label">Start Date</label>
                <input type="date" class="form-control" id="startDate" name="startDate" required>
            </div>
            <div class="mb-3">
                <label for="endDate" class="form-label">End Date</label>
                <input type="date" class="form-control" id="endDate" name="endDate" required>
            </div>
            <div class="mb-3">
                <label for="origin" class="form-label">Origin</label>
                <select class="form-select" id="origin" name="origin" required>
                    <option value="">Select Origin</option>
                    <option value="Chicago">Chicago</option>
                    <!-- Add more options for other origins -->
                </select>
            </div>
            <div class="mb-3">
                <label for="destination" class="form-label">Destination</label>
                <select class="form-select" id="destination" name="destination" required>
                    <option value="">Select Destination</option>
                    <option value="Atlanta">Atlanta</option>
                    <option value="Austin">Austin</option>
                    <option value="Baltimore">Baltimore</option>
                    <option value="Boston">Boston</option>
                    <option value="Charlotte">Charlotte</option>
                    <!-- Add more options for other destinations -->
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Add Flights</button>
        </form>

        <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            int aircraftId = Integer.parseInt(request.getParameter("aircraftId"));
            LocalDate startDate = LocalDate.parse(request.getParameter("startDate"), DateTimeFormatter.ISO_LOCAL_DATE);
            LocalDate endDate = LocalDate.parse(request.getParameter("endDate"), DateTimeFormatter.ISO_LOCAL_DATE);
            String origin = request.getParameter("origin");
            String destination = request.getParameter("destination");

            Connection conn = null;
            CallableStatement stmt = null;
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl", "dbteam5", "F23dbteam5R");
                stmt = conn.prepareCall("CALL AddFlights(?, ?, ?, ?, ?)");
                stmt.setInt(1, aircraftId);
                stmt.setDate(2, java.sql.Date.valueOf(startDate));
                stmt.setDate(3, java.sql.Date.valueOf(endDate));
                stmt.setString(4, origin);
                stmt.setString(5, destination);
                stmt.execute();
                out.println("<p>Flights added successfully.</p>");
            } catch (SQLException ex) {
                out.println("<p>Error executing procedure: " + ex.getMessage() + "</p>");
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