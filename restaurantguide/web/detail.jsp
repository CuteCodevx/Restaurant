<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.RestaurantBean" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.CommentBean" %>
<%@ page import="bean.MenuBean" %>
<%--
  Created by IntelliJ IDEA.
  User: qian.wei
  Date: 2019-04-23
  Time: 19:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<title>Detail</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    body, html {height: 100%}
    body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}
    .menu {display: none}
    .bgimg {
        background-repeat: no-repeat;
        background-size: cover;
        background-color: darkgrey;
        /*background-image: url("/w3images/pizza.jpg");*/
        min-height: 90%;
    }
</style>
<body>
<%
    List<RestaurantBean> data = (ArrayList)request.getAttribute("resDetail");
    List<CommentBean> comment = (ArrayList)request.getAttribute("comment");
    List<MenuBean> menuMain = (ArrayList)request.getAttribute("menuMain");
    List<MenuBean> menuStarter = (ArrayList)request.getAttribute("menuStarter");
    List<MenuBean> menuDrink = (ArrayList)request.getAttribute("menuDrink");
    List<MenuBean> menuDessert = (ArrayList)request.getAttribute("menuDessert");
    String usernameFromPlatform = (String)request.getSession().getAttribute("userName");
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

<%for(int i=0;i<data.size();i++){%>
<!-- Header with image -->
<header class="bgimg w3-display-container w3-grayscale-min" id="home" style="background-image:url('images/<%=data.get(i).getId()%>.jpg')">
    <div class="w3-display-bottomleft w3-padding">
        <span class=" w3-tag w3-xlarge">Open from  <%=data.get(i).getOpenTime()%> am to <%=data.get(i).getCloseTime()%> pm</span>
    </div>

    <div class="w3-display-middle w3-center">
        <span class="w3-text-black w3-hide-small" style="font-size:60px"><%=data.get(i).getName()%></span>
        <span class="w3-text-black w3-hide-large w3-hide-medium" style="font-size:18px"><b>thin<br><%=data.get(i).getName()%></b></span>
        <p><a href="#menu" class="w3-button w3-xlarge w3-black">Let me see the menu</a></p>
    </div>
</header>

<!-- Menu Container -->
<section class="w3-container w3-dark-grey w3-padding-64 w3-large" id="menu">
    <div class="w3-content">

        <h1 class="w3-center" style="margin-bottom:64px">THE MENU</h1>

        <div class="w3-row w3-center w3-border w3-border-dark-grey">

            <a href="javascript:void(0)" onclick="openMenu(event, 'Main');" id="myLink">
                <div class="w3-col s3 tablink w3-padding-large w3-hover-red">Main</div>
            </a>
            <a href="javascript:void(0)" onclick="openMenu(event, 'Starter');">
                <div class="w3-col s3 tablink w3-padding-large w3-hover-red">Starter</div>
            </a>
            <a href="javascript:void(0)" onclick="openMenu(event, 'Drinks');">
                <div class="w3-col s3 tablink w3-padding-large w3-hover-red">Drinks</div>
            </a>
            <a href="javascript:void(0)" onclick="openMenu(event, 'Dessert');">
                <div class="w3-col s3 tablink w3-padding-large w3-hover-red">Dessert</div>
            </a>

        </div>

        <div id="Main" class="w3-container menu w3-padding-32 w3-white">
            <%
                if(menuMain.size()!=0){
                for (int x=0;x<menuMain.size();x++){%>
            <h3><b><%=menuMain.get(x).getDishName()%></b> <span class="w3-right w3-tag w3-dark-grey w3-round"><%=menuMain.get(x).getPrice()%></span></h3>
            <%if(menuMain.get(x).getDescription()!=null){%>
            <p class="w3-text-grey"><%=menuMain.get(x).getDescription()%></p>
            <%}%>
            <hr>

            <%}}else{%>
            <p class="w3-text-grey w3-xxlarge">Sorry! We don't serve Main now</p>
            <%}%>
        </div>
        <div id="Starter" class="w3-container menu w3-padding-32 w3-white">
            <%
                if(menuStarter.size()!=0){
                    for (int x=0;x<menuStarter.size();x++){%>
            <h3><b><%=menuStarter.get(x).getDishName()%></b> <span class="w3-right w3-tag w3-dark-grey w3-round"><%=menuStarter.get(x).getPrice()%></span></h3>
            <%if(menuStarter.get(x).getDescription()!=null){%>
            <p class="w3-text-grey"><%=menuStarter.get(x).getDescription()%></p>
            <%}%>
            <hr>

            <%}}else{%>
            <p class="w3-text-black">Sorry! We don't serve Starter now</p>
            <hr>
            <%}%>
        </div>
        <div id="Drinks" class="w3-container menu w3-padding-32 w3-white">
            <%
                if(menuDrink.size()!=0){
                    for (int x=0;x<menuDrink.size();x++){%>
            <h3><b><%=menuDrink.get(x).getDishName()%></b> <span class="w3-right w3-tag w3-dark-grey w3-round"><%=menuDrink.get(x).getPrice()%></span></h3>
            <%if(menuDrink.get(x).getDescription()!=null){%>
            <p class="w3-text-black"><%=menuDrink.get(x).getDescription()%></p>
            <hr>
            <%}%>
            <%}}else{%>
            <p class="w3-text-black">Sorry! We don't serve Drinks now</p>
            <hr>
            <%}%>
        </div>
        <div id="Dessert" class="w3-container menu w3-padding-32 w3-white">
            <%
                if(menuDessert.size()!=0){
                    for (int x=0;x<menuDessert.size();x++){%>
            <h3><b><%=menuDessert.get(x).getDishName()%></b> <span class="w3-right w3-tag w3-dark-grey w3-round"><%=menuDessert.get(x).getPrice()%></span></h3>
            <%if(menuDessert.get(x).getDescription()!=null){%>
            <p class="w3-text-grey"><%=menuDessert.get(x).getDescription()%></p>
            <%}%>
            <hr>
            <%}}else{%>
            <p class="w3-text-black">Sorry! We don't serve Dessert now</p>
            <hr>
            <%}%>
        </div>
    </div>
</section>

<!-- About Container -->
<section class="w3-container w3-padding-64 w3-red w3-grayscale w3-large" id="about">
    <div class="w3-content">
        <h1 class="w3-center" style="margin-bottom:64px">ABOUT</h1>
        <p> <%=data.get(i).getDetails()%></p>
        <p></p>
        <%--<p><strong>The Chef?</strong> Mr. Italiano himself<img src="/w3images/chef.jpg" style="width:150px" class="w3-circle w3-right" alt="Chef"></p>--%>
        <p>We are proud of our interiors.</p>
        <%--<img src="/w3images/onepage_restaurant.jpg" style="width:100%" class="w3-margin-top w3-margin-bottom" alt="Restaurant">--%>
        <h3><b>DETAILS</b></h3>
        <div class="w3-row">

            <div class="w3-col s6">
                <p>OPENING HOURS</p>
                <p>PECIALS DIETS</p>
                <p>POINTS</p>
                <p>CUISINES</p>
                <p>PRICE RANGE</p>
            </div>
            <div class="w3-col s6">
                <p>from <%=data.get(i).getOpenTime()%>am to <%=data.get(i).getCloseTime()%>pm</p>
                <p><%=data.get(i).getSpecialDiets()%></p>
                <p><%=data.get(i).getPoint()%></p>
                <p><%=data.get(i).getCuisine()%></p>
                <p><%=data.get(i).getPriceRange()%></p>
            </div>
        </div>
    </div>
</section>

<!--Reviews-->
<%--add pagination for reviews--%>
<section class="w3-container w3-padding-64 w3-brown w3-grayscale-min w3-large">
    <div class="w3-content">
        <h1 class="w3-center" style="margin-bottom:64px">REVIEWS (<%=comment.size()%>)</h1>
        <%
            if(comment.size()!=0){
                int num=Integer.parseInt(request.getParameter("list"));

                if(num*4<=comment.size()){

                    for (int c=(num-1)*4;c<num*4;c++){%>
        <div class="w3-card-4 w3-margin w3-white">
            <div class="w3-container">
                <h3><b><%=comment.get(c).getUsername()%></b><span class="w3-opacity w3-right"><i class="w3-text-black">Reviewed</i> <%=comment.get(c).getDate()%></span></h3>
            </div>
            <div class="w3-container">
                <p class="w3-text-red"><%=comment.get(c).getGivePoint()%></p>
                <p><%=comment.get(c).getContent()%></p>
            </div>
        </div>

        <%}}else{  for(int c=(num-1)*4;c<comment.size();c++){%>

        <div class="w3-card-4 w3-margin w3-white">
            <div class="w3-container">
                <h3><b><%=comment.get(c).getUsername()%></b><span class="w3-opacity w3-right"><i class="w3-text-black">Reviewed</i> <%=comment.get(c).getDate()%></span></h3>
            </div>
            <div class="w3-container">
                <p class="w3-text-red"><%=comment.get(c).getGivePoint()%></p>
                <p><%=comment.get(c).getContent()%></p>
            </div>
        </div>

        <%}}%>

        <!-- Pagination -->
        <div class="w3-center w3-padding-32">
            <div class="w3-bar">
                <a href="#" class="w3-bar-item w3-button w3-hover-black">«</a>
                <%
                    int totalNum;
                    if(comment.size()%4 == 0){
                        totalNum = comment.size()/4;
                    }else{
                        totalNum = comment.size()/4+1;
                    }
                    for(int pageNum = 1;pageNum<=totalNum;pageNum++){
                       // System.out.print(pageNum);
                        if (num == pageNum){%>
                        <a href="detail?name=<%=data.get(i).getName()%>&list=<%=pageNum%>" class="w3-bar-item w3-light-grey w3-button"><%=pageNum%></a>
                        <%}else{%>
                         <a href="detail?name=<%=data.get(i).getName()%>&list=<%=pageNum%>" class="w3-bar-item w3-button"><%=pageNum%></a>
                        <%}%>
                <%}%>
                <a href="#" class="w3-bar-item w3-button w3-hover-black">»</a>
            </div>
        </div>

        <%}else{%>
        <h3 class="w3-center"><b>No any review in here</b></h3>
        <%}%>
        <button class="w3-button w3-block w3-black w3-margin-bottom w3-section w3-right" onclick="document.getElementById('reviewModal').style.display='block'">Write Review</button>
    </div>
</section>
<%--write review model--%>
<section id="reviewModal" class="w3-modal">
    <div class="w3-modal-content w3-animate-top w3-card-4">
        <header class="w3-container w3-brown w3-center w3-padding-32">
        <span onclick="document.getElementById('reviewModal').style.display='none'"
              class="w3-button w3-brown w3-xlarge w3-display-topright">X</span>
            <h2 class="w3-wide">Review</h2>
        </header>
        <form class="w3-container" action="detail" method="post">
            <input type="hidden" required name="resName" value="<%=data.get(i).getName()%>">
            <input type="hidden" name="realName" value="<%=usernameFromPlatform%>">
            <p><label>What you want to say</label></p>
            <input class="w3-input w3-border" type="text" required name="content">
            <p><label>How much point will you give us</label> <b class="w3-small">(The point is no more than 5)</b></p>
            <input class="w3-input w3-border" type="number" required name="point">
            <p><label><i class="fa fa-user"></i> your name</label></p>
            <input class="w3-input w3-border" type="text" required name="username" placeholder="">
            <button class="w3-button w3-block w3-brown w3-padding-16 w3-section w3-right">SUBMIT <i class="fa fa-check"></i></button>
        </form>
    </div>
</section>

<!-- Contact -->
<section class="w3-container w3-padding-64 w3-blue-grey w3-grayscale-min w3-large">
    <div class="w3-content">
        <h1 class="w3-center" style="margin-bottom:64px">CONTACT</h1>
        <p>Find us at some address at some place or call us at  <%=data.get(i).getTel()%></p>
        <p> <%=data.get(i).getAddress()%>,  <%=data.get(i).getPostcode()%></p>
        <p><span class="w3-tag">FYI!</span> We offer full-service catering for any event, large or small. We understand your needs and we will cater the food to satisfy the biggerst criteria of them all, both look and taste.</p>
        <p class="w3-xlarge"><strong>Reserve</strong> a table, ask for today's special or just send us a message:</p>
        <form action="bookRestaurant" target="" method="post">
            <input type="hidden" name="resName" value="<%=data.get(i).getName()%>">
            <input type="hidden" name="realName" value="<%=usernameFromPlatform%>">
            <p><input class="w3-input w3-padding-16 w3-border" type="text" placeholder="Name" required name="Name"></p>
            <p><input class="w3-input w3-padding-16 w3-border" type="number" placeholder="How many people" required name="People"></p>
            <p><input class="w3-input w3-padding-16 w3-border" type="datetime-local" placeholder="Date and time" required name="Date" value="2019-04-27T20:00"></p>
            <p><input class="w3-input w3-padding-16 w3-border" type="text" placeholder="Message \ Special requirements" required name="Message"></p>
            <p><button class="w3-button w3-light-grey w3-block" type="submit">SEND MESSAGE</button></p>
        </form>
    </div>
</section>
<%}%>


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
    // Tabbed Menu
    function openMenu(evt, menuName) {
        var i, x, tablinks;
        x = document.getElementsByClassName("menu");
        for (i = 0; i < x.length; i++) {
            x[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablink");
        for (i = 0; i < x.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" w3-red", "");
        }
        document.getElementById(menuName).style.display = "block";
        evt.currentTarget.firstElementChild.className += " w3-red";
    }
    document.getElementById("myLink").click();
    // When the user clicks anywhere outside of the modal, close it
    var modal = document.getElementById('reviewModal');
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>

</body>
</html>