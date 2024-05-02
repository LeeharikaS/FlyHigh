<%-- 
    Document   : deleteFlights.jsp
    Created on : Apr 30, 2024, 11:29:22 AM
    Author     : leeharika
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Flight</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            padding-top: 20px;
        }
        .form-group {
            margin-bottom: 15px;
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
    <div class="container">
        <h2>Delete a Flight</h2>
        <form method="POST" action="deleteFlights.jsp">
            <div class="form-group">
                <label for="flightId">Flight ID:</label>
                <input type="text" class="form-control" id="flightId" name="flightId" required>
            </div>
            <button type="submit" class="btn btn-danger">Delete Flight</button>
        </form>
        <% 
            String flightId = request.getParameter("flightId");
            if (flightId != null && !flightId.isEmpty()) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                try {
                    String url = "jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl";
                    String user = "dbteam5";
                    String password = "F23dbteam5R";
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection(url, user, password);

                    String sql = "DELETE FROM flights WHERE flightId = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, flightId);

                    int rowsAffected = pstmt.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<p class='alert alert-success'>Flight ID " + flightId + " was successfully deleted.</p>");
                    } else {
                        out.println("<p class='alert alert-warning'>No flight found with ID " + flightId + ".</p>");
                    }
                } catch (SQLException ex) {
                    out.println("<p class='alert alert-danger'>Error: " + ex.getMessage() + "</p>");
                } catch (ClassNotFoundException ex) {
                    out.println("<p class='alert alert-danger'>Driver class not found: " + ex.getMessage() + "</p>");
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { /* ignored */ }
                    if (conn != null) try { conn.close(); } catch (SQLException ex) { /* ignored */ }
                }
            }
        %>
    </div>

    <!-- Bootstrap JavaScript Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
