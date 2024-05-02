<%-- 
    Document   : crew_schedule.jsp
    Created on : Apr 28, 2024, 8:48:18 PM
    Author     : leeharika
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crew Schedules</title>
    <!-- Include Bootstrap CSS from CDN for styling -->
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
        <h1>Crew Schedules</h1>
        <table class="table">
            <thead>
                <tr>
                    <th>Crew ID</th>
                    <th>Crew Name</th>
                    <th>Flight ID</th>
                    <th>Flight Name</th>
                    <th>Departure Date</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        String dbURL = "jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl"; // Replace with your database connection details
                        String user = "dbteam5";
                        String pass = "F23dbteam5R";
                        conn = DriverManager.getConnection(dbURL, user, pass);
                        String sql = "SELECT cs.crewId, c.name, f.flightId, f.flightName, TO_CHAR(f.departure_date, 'YYYY-MM-DD') AS departure_date " +
                                     "FROM crew_schedules cs " +
                                     "JOIN crew c ON cs.crewId = c.crewId " +
                                     "JOIN flights f ON cs.flightId = f.flightId " +
                                     "ORDER BY cs.crewId";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getString("crewId") + "</td>");
                            out.println("<td>" + rs.getString("name") + "</td>");
                            out.println("<td>" + rs.getString("flightId") + "</td>");
                            out.println("<td>" + rs.getString("flightName") + "</td>");
                            out.println("<td>" + rs.getString("departure_date") + "</td>");
                            out.println("</tr>");
                        }
                    } catch (SQLException ex) {
                        out.println("<p>SQL Error: " + ex.getMessage() + "</p>");
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                        try { if (stmt != null) stmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                        try { if (conn != null) conn.close(); } catch (SQLException ex) { ex.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
    </div>
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


