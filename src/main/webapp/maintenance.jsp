<%-- 
    Document   : maintenance.jsp
    Created on : Apr 30, 2024, 11:43:47 AM
    Author     : leeharika
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Flight Maintenance</title>
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
        <h2>Log Maintenance Activity</h2>
        <form method="POST" action="maintenance.jsp">
            <div class="form-group">
                <label for="aircraftId">Aircraft ID:</label>
                <input type="text" class="form-control" id="aircraftId" name="aircraftId" required>
            </div>
            <div class="form-group">
                <label for="lastMaintenanceDate">Last Maintenance Date:</label>
                <input type="date" class="form-control" id="lastMaintenanceDate" name="lastMaintenanceDate" required>
            </div>
            <div class="form-group">
                <label for="details">Maintenance Details:</label>
                <textarea class="form-control" id="details" name="details" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Submit Maintenance Record</button>
        </form>
        <% 
            String aircraftId = request.getParameter("aircraftId");
            String lastMaintenanceDate = request.getParameter("lastMaintenanceDate");
            String details = request.getParameter("details");
            if (aircraftId != null && lastMaintenanceDate != null && details != null) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                try {
                    String url = "jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl";
                    String user = "dbteam5";
                    String password = "F23dbteam5R";
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection(url, user, password);

                    String sql = "INSERT INTO maintenance (maintenanceId, aircraftId, lastMaintenanceDate, details) VALUES (maintenance_seq.NEXTVAL, ?, ?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, aircraftId);
                    pstmt.setDate(2, Date.valueOf(lastMaintenanceDate));
                    pstmt.setString(3, details);

                    int rowsAffected = pstmt.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<p class='alert alert-success'>Maintenance record added successfully.</p>");
                    } else {
                        out.println("<p class='alert alert-danger'>Failed to add maintenance record.</p>");
                    }
                } catch (SQLException | ClassNotFoundException ex) {
                    out.println("<p class='alert alert-danger'>Error: " + ex.getMessage() + "</p>");
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

