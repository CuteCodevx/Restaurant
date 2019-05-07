<%@ page import="service.Service" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="service.impl.ServiceImpl" %>
<%@ page import="bean.RestaurantBean" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: qian.wei
  Date: 2019-05-06
  Time: 00:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<title>Home Page</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
  body,h1,h2,h3,h4,h5,h6 {font-family: "Lato", sans-serif}
  .w3-bar,h1,button {font-family: "Montserrat", sans-serif}
  .fa-anchor,.fa-coffee {font-size:200px}
</style>
<body>
<%
  Service tableRestService = new ServiceImpl("restaurant");
  ResultSet results = tableRestService.getResultSet(null);

  List<RestaurantBean> RestaurantBeans = tableRestService.getRestaurant(results);

  String usernameFromPlatform = (String)request.getSession().getAttribute("userName");
%>

<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-dark-grey w3-card w3-left-align w3-large">
    <a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-padding-large w3-hover-white w3-large w3-red" href="javascript:void(0);" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <a href="index.jsp" class="w3-bar-item w3-button w3-padding-large w3-white">Home</a>
    <a class="w3-bar-item w3-padding-large"><%=usernameFromPlatform%></a>
    <a href="bookRestaurant" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">My Reservation</a>
    <a href="comment" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">My Comment</a>
    <a href="/cloudplatform/index" class="w3-bar-item w3-button w3-padding-large">Exit App</a>
  </div>

  <!-- Navbar on small screens -->
  <div id="navDemo" class="w3-bar-block w3-white w3-hide w3-hide-large w3-hide-medium w3-large">
    <a href="bookRestaurant" class="w3-bar-item w3-button w3-padding-large">My Reservation</a>
    <a href="comment" class="w3-bar-item w3-button w3-padding-large">My Comment</a>
  </div>
</div>

<!-- Header -->
<header class="w3-container w3-dark-grey w3-center" style="padding:128px 16px">
  <h1 class="w3-margin w3-jumbo">RESTAURANT GUIDE</h1>
  <p class="w3-xlarge">Popular restaurants in Sheffield</p>
  <a class="w3-button w3-black w3-padding-large w3-large w3-margin-top" href="hello">Go To Look</a>
</header>


<!-- First Grid -->
<section class="w3-row-padding w3-padding-64 w3-container">
  <div class="w3-content">
    <div class="w3-twothird">
      <h1>The popular restaurants in Sheffield</h1>
      <h5 class="w3-padding-32">Author: Qian Wei, Time:14/03/2019</h5>

      <p class="w3-text-grey">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Excepteur sint
        occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
        laboris nisi ut aliquip ex ea commodo consequat.</p>
    </div>

    <div class="w3-third w3-center">
      <i class="fa fa-coffee w3-padding-64 w3-text-red w3-margin-right"></i>
    </div>
  </div>
</section>

<!-- The Top Three Section -->
<div class="w3-grey" id="tour">
  <div class="w3-container w3-content w3-padding-64" style="max-width:800px">
    <h2 class="w3-wide w3-center">Hi, here</h2>
    <p class="w3-opacity w3-center"><i>The Top Three Restaurants!</i></p><br>

    <div class="w3-row-padding w3-padding-32" style="margin:0 -16px">
      <%for (int i=0;i<3;i++){ %>
      <div class="w3-third w3-margin-bottom">
        <img src="images/<%=RestaurantBeans.get(i).getId()%>.jpg" alt="Img" style="width: 100%; height: 20%" class="w3-hover-opacity">
        <div class="w3-container w3-white">
          <%String name,content;
            if(RestaurantBeans.get(i).getName().length()>20){
              name = RestaurantBeans.get(i).getName().substring(0,20)+"...";
            }else{
              name = RestaurantBeans.get(i).getName();
            }
            if(RestaurantBeans.get(i).getDetails().length()>20){
              content = RestaurantBeans.get(i).getDetails().substring(0,20)+"...";
            }else{
              content = RestaurantBeans.get(i).getDetails();
            }%>
          <p><b><%=name%></b> <span class="w3-text-red w3-right"><%=RestaurantBeans.get(i).getPoint()%></span></p>
          <p class="w3-opacity"><%=RestaurantBeans.get(i).getAddress()%>, <%=RestaurantBeans.get(i).getPostcode()%></p>
          <p><%=content%></p>
          <a class="w3-button w3-black w3-margin-bottom" href="detail?name=<%=RestaurantBeans.get(i).getName()%>">Look</a>
        </div>
      </div>
      <%}%>
    </div>

    <form action="hello" method="get" class="w3-container">
      <div class="w3-row w3-section">
        <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-search"></i></div>
        <div class="w3-rest">
          <input class="w3-input" type="text" name="keyword" placeholder="type what you want">
        </div>

      </div>
      <button class="w3-button w3-black w3-block w3-section w3-ripple w3-padding">Search</button>
    </form>

  </div>
</div>



<!-- The Contact Section -->
<section class="w3-container w3-content w3-padding-32" style="max-width:800px" id="contact">
  <h2 class="w3-wide w3-center">CONTACT</h2>
  <div class="w3-row w3-padding-32">
    <div class="w3-large w3-center">
      <i class="fa fa-map-marker" style="width:30px"></i> Sheffield, UK<br>
      <i class="fa fa-phone" style="width:30px"></i> Phone: +00 151515<br>
      <i class="fa fa-envelope" style="width:30px"> </i> Email: qwei4@sheffield.ac.uk<br>
    </div>
  </div>
</section>

<!-- End Page Content -->


<!-- Footer -->
<footer class="w3-container w3-padding-64 w3-center w3-opacity">
  <div class="w3-xlarge w3-padding-32">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i>
  </div>
  <p>Powered by QIAN WEI</p>
</footer>

<script>
  // Used to toggle the menu on small screens when clicking on the menu button
  function myFunction() {
    var x = document.getElementById("navDemo");
    if (x.className.indexOf("w3-show") == -1) {
      x.className += " w3-show";
    } else {
      x.className = x.className.replace(" w3-show", "");
    }
  }
</script>

</body>
