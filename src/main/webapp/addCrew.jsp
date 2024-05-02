<%-- 
    Document   : addCrew.jsp
    Created on : April 23, 2024, 5:24:41 PM
    Author     : leeharika
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Crew Member</title>
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
        <h1>Add Crew Member</h1>
        <form action="addCrew.jsp" method="post" class="mt-4">
            <div class="mb-3">
                <label for="crewName" class="form-label">Name:</label>
                <input type="text" class="form-control" id="crewName" name="crewName" required>
            </div>
            <div class="mb-3">
                <label for="qualification" class="form-label">Qualification:</label>
                <input type="text" class="form-control" id="qualification" name="qualification" required>
            </div>
            <div class="mb-3">
                <label for="position" class="form-label">Position:</label>
                <select class="form-select" id="position" name="position" required>
                    <option value="Captain">Captain</option>
                    <option value="Senior Flight Attendant">Senior Flight Attendant</option>
                    <option value="First Officer">First Officer</option>
                    <option value="Flight Attendant">Flight Attendant</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
        
        <% 
            String crewName = request.getParameter("crewName");
            String qualification = request.getParameter("qualification");
            String position = request.getParameter("position");
            
            if ("POST".equalsIgnoreCase(request.getMethod()) && crewName != null && qualification != null && position != null) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    String dbURL = "jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl"; // Replace with your database URL
                    String user = "dbteam5"; // Replace with your username
                    String pass = "F23dbteam5R"; // Replace with your password
                    conn = DriverManager.getConnection(dbURL, user, pass);
                    
                    String sql = "INSERT INTO crew (crewId, name, qualification, position) VALUES (crew_id_seq.NEXTVAL, ?, ?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, crewName);
                    pstmt.setString(2, qualification);
                    pstmt.setString(3, position);
                    
                    int rowsAffected = pstmt.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<div class='alert alert-success' role='alert'>New crew member added successfully!</div>");
                    }
                } catch (SQLException ex) {
                    out.println("<div class='alert alert-danger' role='alert'>SQL Error: " + ex.getMessage() + "</div>");
                } finally {
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                }
            }
        %>
    </div>
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
