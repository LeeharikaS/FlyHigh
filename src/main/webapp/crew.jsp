<%-- 
    Document   : crew.jsp
    Created on : April 24, 2024, 5:24:41 PM
    Author     : leeharika
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crew Management</title>
    <!-- Include Bootstrap CSS from CDN for styling if needed -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
        .box {
            border: 2px solid #007BFF;
            border-radius: 8px;
            padding: 20px;
            margin: 10px;
            width: 500px;
            text-align: center;
        }
        .box {
            border: 2px solid #007BFF;
            border-radius: 8px;
            padding: 20px;
            margin: 10px;
            width: 300px;
            text-align: center;
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
        form {
            display: inline-block;
            margin-right: 10px; 
        }
</style>
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
<center>
    <img src="crew.jpg" class="rounded" alt="Cinque Terre" width="500" height="250">
    <div id="flightBox" class="box" >
        <h1>Crew Management</h1>
        <div class="row">
            <div class="col-md-6 d-flex justify-content-center mb-2">
                <!-- Button to show crew schedules -->
                <form action="crew_schedules.jsp" method="post">
                    <button type="submit" class="btn btn-success">Show Crew Schedules</button>
                </form>
            </div>
            <div class="col-md-6 d-flex justify-content-center mb-2">
                <!-- Button to add crew -->
                <form action="addCrew.jsp" method="post">
                    <button type="submit" class="btn btn-success">Add Crew</button>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 d-flex justify-content-center mb-2">
                <!-- Button to schedule crew -->
                <form action="scheduleCrew.jsp" method="post">
                    <button type="submit" class="btn btn-success">Schedule Crew</button>
                </form>
            </div>
            <div class="col-md-6 d-flex justify-content-center mb-2">
                <!-- Button to remove crew -->
                <form action="removeCrew.jsp" method="post">
                    <button type="submit" class="btn btn-success">Remove Crew</button>
                </form>
            </div>
        </div>
    </div>
    </center>
    <!-- Bootstrap Bundle with Popper for Bootstrap functionality (optional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
