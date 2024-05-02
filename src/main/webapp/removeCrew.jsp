<%-- 
    Document   : removeCrew.jsp
    Created on : Apr 29, 2024, 12:07:57 AM
    Author     : leeharika
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Remove Crew Member</title>
    <!-- Include Bootstrap CSS for styling -->
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
                        <a class="nav-link" href="flights.jsp">Flights</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="crew.jsp">Crew</a>
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
        <h1>Remove Crew Member</h1>
        <form action="removeCrew.jsp" method="post" class="mt-4">
            <div class="mb-3">
                <label for="crewId" class="form-label">Crew ID:</label>
                <input type="number" class="form-control" id="crewId" name="crewId" placeholder="Enter Crew ID" required>
            </div>
            <button type="submit" class="btn btn-danger">Remove</button>
        </form>
        
        <% 
            String crewId = request.getParameter("crewId");
            
            if ("POST".equalsIgnoreCase(request.getMethod()) && crewId != null && !crewId.trim().isEmpty()) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    String dbURL = "jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl"; // Replace with your database URL
                    String user = "dbteam5"; // Replace with your database username
                    String pass = "F23dbteam5R"; // Replace with your database password
                    conn = DriverManager.getConnection(dbURL, user, pass);
                    
                    // Start transaction block
                    conn.setAutoCommit(false);
                    
                    // Deleting crew member from crew_schedules if exists
                    String deleteCrewSchedules = "DELETE FROM crew_schedules WHERE crewId = ?";
                    pstmt = conn.prepareStatement(deleteCrewSchedules);
                    pstmt.setInt(1, Integer.parseInt(crewId));
                    pstmt.executeUpdate();

                    // Deleting crew member from crew table
                    String sql = "DELETE FROM crew WHERE crewId = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(crewId));
                    
                    int rowsAffected = pstmt.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<div class='alert alert-success' role='alert'>Crew member removed successfully!</div>");
                        conn.commit(); // Committing transaction if both delete operations were successful
                    } else {
                        out.println("<div class='alert alert-warning' role='alert'>No crew member found with the provided ID.</div>");
                    }
                } catch (SQLException ex) {
                    out.println("<div class='alert alert-danger' role='alert'>SQL Error: " + ex.getMessage() + "</div>");
                    if (conn != null) {
                        try {
                            conn.rollback(); // Rolling back the transaction in case of any error
                        } catch (SQLException ex1) {
                            out.println("<div class='alert alert-danger' role='alert'>Transaction rollback failed: " + ex1.getMessage() + "</div>");
                        }
                    }
                } finally {
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                    try { if (conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (SQLException ex) { ex.printStackTrace(); }
                }
            }
        %>
    </div>
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

