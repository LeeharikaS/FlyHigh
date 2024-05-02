<%-- 
    Document   : addPassengers.jsp
    Created on : May 1, 2024, 2:24:41 PM
    Author     : bsiva
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Passenger</title>
    <!-- Include Bootstrap CSS from CDN for styling -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .container {
            margin-top: 20px;
        }
        form {
            margin: 20px auto;
            width: 50%;
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
                        <a class="nav-link" href="flights.jsp">Flights</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="crew.jsp">Crew</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="revenue.jsp">Analysis</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="passengers.jsp">Passengers</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <br>
    <br>
    <div class="container">
        <h2>Add a New Passenger</h2>
        <form method="post" action="addPassengers.jsp">
            <div class="mb-3">
                <label for="passengerName" class="form-label">Passenger Name</label>
                <input type="text" class="form-control" id="passengerName" name="passengerName" required>
            </div>
            <div class="mb-3">
                <label for="passengerEmail" class="form-label">Passenger Email</label>
                <input type="email" class="form-control" id="passengerEmail" name="passengerEmail" required>
            </div>
            <div class="mb-3">
                <label for="frequentFlyerId" class="form-label">Frequent Flyer ID</label>
                <input type="number" class="form-control" id="frequentFlyerId" name="frequentFlyerId" value="1" readonly>
            </div>
            <button type="submit" class="btn btn-primary">Add Passenger</button>
        </form>
        <% 
            String passengerName = request.getParameter("passengerName");
            String passengerEmail = request.getParameter("passengerEmail");
            String frequentFlyerId = request.getParameter("frequentFlyerId");

            if (passengerName != null && passengerEmail != null) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                try {
                    String url = "jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl";
                    String user = "dbteam5";
                    String password = "F23dbteam5R";
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection(url, user, password);

                    String sql = "INSERT INTO passengers (passengerId, passengerName, passengerEmail, frequentflyerid) VALUES (passenger_seq.NEXTVAL, ?, ?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, passengerName);
                    pstmt.setString(2, passengerEmail);
                    pstmt.setString(3, frequentFlyerId);

                    int rowsAffected = pstmt.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<div class='alert alert-success'>Passenger added successfully.</div>");
                    } else {
                        out.println("<div class='alert alert-danger'>Failed to add passenger.</div>");
                    }
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
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

