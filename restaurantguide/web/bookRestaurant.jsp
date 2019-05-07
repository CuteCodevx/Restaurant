<%@ page import="bean.ReservationBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: qian.wei
  Date: 2019-04-27
  Time: 19:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reservation</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body, html {height: 100%}
        body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}
    </style>
</head>
<body>
<%List<ReservationBean> reserve = (ArrayList)request.getAttribute("reserveInfo");
%>
<!-- Sidebar (hidden by default) -->
<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" style="display:none;z-index:2;width:40%;min-width:300px" id="mySidebar">
    <a href="javascript:void(0)" onclick="w3_close()"
       class="w3-bar-item w3-button">Close Menu</a>
    <a href="index.jsp" onclick="w3_close()" class="w3-bar-item w3-button">Home</a>
    <a href="hello" onclick="w3_close()" class="w3-bar-item w3-button">More Restaurants</a>
    <a href="/cloudplatform/index" onclick="w3_close()" class="w3-bar-item w3-button">Exit App</a>
</nav>

<!-- Top menu -->
<div class="w3-top">
    <div class="w3-white w3-xlarge" style="max-width:1200px;margin:auto">
        <div class="w3-button w3-padding-16 w3-left" onclick="w3_open()">☰</div>
    </div>
</div>
<%   String usernameFromPlatform = (String)request.getSession().getAttribute("userName");%>
<%--reservation--%>
<section class="w3-container w3-padding-64 w3-blue-grey w3-grayscale-min w3-large">
    <div class="w3-content">
        <h3 class="w3-center w3-jumbo" style="margin-bottom:64px">MY RESERVATIONS</h3>
        <h3 class="w3-center "><%=usernameFromPlatform%></h3>
        <%
            if(reserve.size()!=0){

                int num=Integer.parseInt(request.getParameter("list"));

                if(num*4<=reserve.size()){

                for (int i=(num-1)*4;i<num*4;i++){

        %>
        <div class="w3-card-4 w3-margin w3-white">
            <div class="w3-container">
                <h3><b>DETAILS</b></h3>
                <p>Restaurant Name: <span class="w3-xlarge"><b><%=reserve.get(i).getResName()%></b></span></p>
                <p>from:  <span class="w3-xlarge"><b><%=reserve.get(i).getGuestName()%></b></span></p>

            </div>
            <div class="w3-container">
                <p>Reservation Date: <span class="w3-xlarge w3-opacity"><b><%=reserve.get(i).getDate()%></b></span></p>
                <p>How many people you want is: <span class="w3-xlarge"><b><%=reserve.get(i).getPeopleNum()%></b></span></p>
                <p>Special Requirements: <span class="w3-xlarge w3-text-red"><b><%=reserve.get(i).getMessage()%></b></span></p>
            </div>
        </div>
        <%}}else{  for(int i=(num-1)*4;i<reserve.size();i++){%>
        <div class="w3-card-4 w3-margin w3-white">
            <div class="w3-container">
                <h3><b>DETAILS</b></h3>
                <p>Restaurant Name: <span class="w3-xlarge"><b><%=reserve.get(i).getResName()%></b></span></p>
                <p>from:  <span class="w3-xlarge"><b><%=reserve.get(i).getGuestName()%></b></span></p>

            </div>
            <div class="w3-container">
                <p>Reservation Date: <span class="w3-xlarge w3-opacity"><b><%=reserve.get(i).getDate()%></b></span></p>
                <p>How many people you want is: <span class="w3-xlarge"><b><%=reserve.get(i).getPeopleNum()%></b></span></p>
                <p>Special Requirements: <span class="w3-xlarge w3-text-red"><b><%=reserve.get(i).getMessage()%></b></span></p>
            </div>
        </div>
        <%}}%>
        <!-- Pagination -->
        <div class="w3-center w3-padding-32">
            <div class="w3-bar">
                <a href="#" class="w3-bar-item w3-button w3-hover-black">«</a>
                <%
                    int totalNum;
                    if(reserve.size()%4 == 0){
                        totalNum = reserve.size()/4;
                    }else{
                        totalNum = reserve.size()/4+1;
                    }
                    for(int pageNum = 1;pageNum<=totalNum;pageNum++){
                        // System.out.print(pageNum);
                        if (num == pageNum){%>
                <a href="bookRestaurant?list=<%=pageNum%>" class="w3-bar-item w3-light-grey w3-button"><%=pageNum%></a>
                <%}else{%>
                <a href="bookRestaurant?list=<%=pageNum%>" class="w3-bar-item w3-button"><%=pageNum%></a>
                <%}%>
                <%}%>
                <a href="#" class="w3-bar-item w3-button w3-hover-black">»</a>
            </div>
        </div>
        <%}else{%>
            <h3 class="w3-center"><b>You haven't reserve any restaurant,  <a href="hello">go to look !</a></b></h3>
        <%}%>
    </div>
    <!-- The Contact Section -->
    <div class="w3-container w3-content w3-padding-32" style="max-width:800px" id="contact">
        <p class="w3-center w3-opacity">If something need to be changed, please contact us.</p>
        <div class="w3-container w3-padding-32 w3-large w3-center w3-margin-bottom">
            <i class="fa fa-map-marker" style="width:30px"></i> Sheffield, UK<br>
            <i class="fa fa-phone" style="width:30px"></i> Phone: +00 151515<br>
            <i class="fa fa-envelope" style="width:30px"> </i> Email: qwei4@sheffield.ac.uk<br>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="w3-center w3-black w3-padding-48 w3-large w3-opacity">
    <div class="w3-xlarge w3-padding-32">
        <i class="fa fa-facebook-official w3-hover-opacity"></i>
        <i class="fa fa-instagram w3-hover-opacity"></i>
        <i class="fa fa-snapchat w3-hover-opacity"></i>
        <i class="fa fa-pinterest-p w3-hover-opacity"></i>
        <i class="fa fa-twitter w3-hover-opacity"></i>
        <i class="fa fa-linkedin w3-hover-opacity"></i>
    </div>
    <p class="w3-center">Powered by QIAN WEI</p>
</footer>

<script>
    // Script to open and close sidebar
    function w3_open() {
        document.getElementById("mySidebar").style.display = "block";
    }

    function w3_close() {
        document.getElementById("mySidebar").style.display = "none";
    }
</script>
</body>
</html>
