<%-- 
    Document   : passengers.jsp
    Created on : May 1, 2024, 1:41:07 PM
    Author     : leeharika
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Passenger Management</title>
    <!-- Include Bootstrap CSS from CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .box {
            border: 2px solid #007BFF;
            border-radius: 8px;
            padding: 20px;
            margin: 10px;
            text-align: center;
            width: 500px;
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
<center>
    <img src="passengers.jpg" class="rounded" alt="Cinque Terre" width="500" height="250"><br>
    <div class="container mt-5">
        <div class="box">
            <h1>Manage Passengers</h1><br>
            <!-- Button for showing passengers -->
            <form action="showPassengers.jsp" method="GET" class="d-inline-block">
                <input type="submit" value="Show Passengers" class="btn btn-success">
            </form>
            <!-- Button for adding passengers -->
            <form action="addPassengers.jsp" method="GET" class="d-inline-block">
                <input type="submit" value="Add Passengers" class="btn btn-success">
            </form>
        </div>
    </div>
</center>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

