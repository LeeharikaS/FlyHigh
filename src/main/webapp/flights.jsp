<%-- 
    Document   : flights.jsp
    Created on : April 28, 2024, 5:00:41 PM
    Author     : leeharika
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Flight Information</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Your existing CSS */
        .box {
            border: 2px solid #007BFF;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
            width: 400px;
            text-align: center;
        }
        .content-box {
            padding: 20px;
            margin: 10px;
            border: 2px solid #007BFF;
            border-radius: 8px;
        }
        .title {
            color:  #007BFF;
            font-size: 24px;
            margin-bottom: 20px;
        }
        button, input[type="submit"] {
            background-color: #008000;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
        }
        #flightDetails {
            margin-top: 20px;
            text-align: left;
        }
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }
        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        tr:nth-child(even) {
            background-color: #dddddd;
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
<center>
    <div class="container" class="content-box">
        <img src="addFlights.jpg" class="rounded" alt="Cinque Terre" width="300" height="200">
    </div>
    <div class="container">
    
    <div id="flightBox" class="box">
        <h2 class="title">Flights</h2>
        <div class="row">
        <div class="col-md-6 d-flex justify-content-center mb-2">
            <form action="flights.jsp" method="GET" class="w-100">
                <input type="submit" name="getAllFlights" value="Show Flights" class="btn w-100">
            </form>
        </div>
        <div class="col-md-6 d-flex justify-content-center mb-2">
            <form action="bookings.jsp" method="GET" class="w-100">
                <input type="submit" name="getAllFlights" value="Book Flights" class="btn w-100">
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6 d-flex justify-content-center mb-2">
            <form action="AddFlights.jsp" method="GET" class="w-100">
                <input type="submit" name="AddFlights" value="Add Flights" class="btn w-100">
            </form>
        </div>
        <div class="col-md-6 d-flex justify-content-center mb-2">
            <form action="CancelBooking.jsp" method="GET" class="w-100">
                <input type="submit" name="CancelBooking" value="Cancel Booking" class="btn w-100">
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6 d-flex justify-content-center mb-2">
            <form action="deleteFlights.jsp" method="GET" class="w-100">
                <input type="submit" name="deleteFlights" value="Delete Flights" class="btn w-100">
            </form>
        </div>
        <div class="col-md-6 d-flex justify-content-center mb-2">
            <form action="maintenance.jsp" method="GET" class="w-100">
                <input type="submit" name="Maintenance" value="Maintenance" class="btn w-100">
            </form>
        </div>
    </div>
        <div id="flightDetails">
            <% 
                if ("Show Flights".equals(request.getParameter("getAllFlights"))) {
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        String url = "jdbc:oracle:thin:@csdb.csc.villanova.edu:1521:orcl";
                        String user = "dbteam5";
                        String password = "F23dbteam5R";
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        conn = DriverManager.getConnection(url, user, password);
                        stmt = conn.createStatement();
                        String sql = "SELECT flightId, flightName, origin, destination FROM flights";
                        rs = stmt.executeQuery(sql);
                        out.println("<table>");
                        out.println("<tr><th>Flight ID</th><th>Flight Name</th><th>Origin</th><th>Destination</th></tr>");
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getString("flightId") + "</td>");
                            out.println("<td>" + rs.getString("flightName") + "</td>");
                            out.println("<td>" + rs.getString("origin") + "</td>");
                            out.println("<td>" + rs.getString("destination") + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                    } catch (Exception e) {
                        out.println("An error occurred: " + e.getMessage());
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { /* ignored */ }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { /* ignored */ }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { /* ignored */ }
                    }
                }
            %>
        </div>
    </div>
   </div>
</center>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
