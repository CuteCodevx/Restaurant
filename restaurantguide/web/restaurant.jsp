<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.RestaurantBean" %>
<%--
  Created by IntelliJ IDEA.
  User: qian.wei
  Date: 2019-04-10
  Time: 18:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<title>Restaurants</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    body,h1,h2,h3,h4,h5,h6 {font-family: "Karma", sans-serif}
    .w3-bar-block .w3-bar-item {padding:20px}
</style>
<body>
<%
    List<RestaurantBean> data = (ArrayList)request.getAttribute("allData");
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

<!-- Header -->
<header class="w3-panel w3-center w3-opacity" style="padding:58px 16px">
    <h1>Restaurants in Sheffield</h1>
    <div class="w3-padding-16">
        <div class="w3-bar w3-border">
            <a href="hello?cuisine=Indian" class="w3-bar-item w3-button w3-hide-small">Indian</a>
            <a href="hello?cuisine=Japanese" class="w3-bar-item w3-button w3-hide-small">Japanese</a>
            <a href="hello?cuisine=British" class="w3-bar-item w3-button w3-hide-small">British</a>
            <a href="hello?cuisine=Chinese" class="w3-bar-item w3-button w3-hide-small">Chinese</a>
            <a href="hello?cuisine=Cafe" class="w3-bar-item w3-button">Cafe</a>
            <a href="hello?cuisine=Italian" class="w3-bar-item w3-button w3-hide-small">Italian</a>
            <a href="hello?cuisine=Thai" class="w3-bar-item w3-button w3-hide-small">Thai</a>
            <a href="hello?cuisine=Pizza" class="w3-bar-item w3-button">Pizza</a>
            <a href="hello?cuisine=European" class="w3-bar-item w3-button w3-hide-large">European</a>
            <a href="hello?cuisine=Asian" class="w3-bar-item w3-button w3-hide-large">Asian</a>
        </div>
    </div>
</header>

<!-- !PAGE CONTENT! -->
<div class="w3-main w3-content w3-padding" style="max-width:1200px;margin-top:50px">
    <%
        if(data.size()!= 0){
//        System.out.println("in page"+ request.getParameter("list"));
        int i=Integer.parseInt(request.getParameter("list"));
//        System.out.println(i);
//        System.out.println("data.size（）：：："+data.size());

     if(i*4<=data.size()){
         //System.out.println("i*4<=data.size()");
     for(int a=(i-1)*4;a<i*4;a++){%>

        <form class="w3-row-padding w3-padding-16 w3-center" action="detail" method="get">
            <img src="images/<%=data.get(a).getId()%>.jpg" alt="Sandwich" style="width:80%">
            <input type="hidden" name="name" value="<%=data.get(a).getName()%>">
            <h3><%=data.get(a).getName()%></h3>
            <p class="w3-text-dark-grey"><span class="w3-text-deep-orange">Point: <%=data.get(a).getPoint()%></span><span></span></p>
            <p class="w3-text-dark-grey"><span><%=data.get(a).getCuisine()%></span></p>
            <p class="w3-text-dark-grey"><span><%=data.get(a).getAddress()%></span>, <span><%=data.get(a).getPostcode()%></span></p>
            <button class="w3-button w3-light-grey">check the detail</button>
        </form>
        <hr>

    <%}}else{  for(int a=(i-1)*4;a<data.size();a++){%>

        <form class="w3-row-padding w3-padding-16 w3-center" action="detail" method="get">
            <img src="images/<%=data.get(a).getId()%>.jpg" alt="Sandwich" style="width:80%">
            <input type="hidden" name="name" value="<%=data.get(a).getName()%>">
            <h3><%=data.get(a).getName()%></h3>
            <p class="w3-text-dark-grey"><span class="w3-text-deep-orange">Point: <%=data.get(a).getPoint()%></span><span></span></p>
            <p class="w3-text-dark-grey"><span><%=data.get(a).getCuisine()%></span></p>
            <p class="w3-text-dark-grey"><span><%=data.get(a).getAddress()%></span>, <span><%=data.get(a).getPostcode()%></span></p>
            <button class="w3-button w3-light-grey">check the detail</button>
        </form>
    <hr>

   <% }}%>

    <!-- Pagination -->
    <div class="w3-center w3-padding-32">
        <div class="w3-bar">
            <a href="#" class="w3-bar-item w3-button w3-hover-black">«</a>
            <%
                int totalNum;
                if(data.size()%4 == 0){
                    totalNum = data.size()/4;
                }else{
                    totalNum = data.size()/4+1;
                }
                String cuisine = (String) request.getAttribute("cuisine");
                String keyword = (String) request.getAttribute("keyword");
                for(int pageNum = 1;pageNum<=totalNum;pageNum++){
                    if(cuisine==null && keyword==null){
                        if (i == pageNum){%>
                        <a href="hello?list=<%=pageNum%>" class="w3-bar-item w3-light-grey w3-button"><%=pageNum%></a>
                        <%}else{%>
                        <a href="hello?list=<%=pageNum%>" class="w3-bar-item w3-button"><%=pageNum%></a>
                        <%}
                    }else if(cuisine!=null){
                        if (i == pageNum){%>
                        <a href="hello?list=<%=pageNum%>&cuisine=<%=cuisine%>" class="w3-bar-item w3-light-grey w3-button"><%=pageNum%></a>
                        <%}else{%>
                        <a href="hello?list=<%=pageNum%>&cuisine=<%=cuisine%>" class="w3-bar-item w3-button"><%=pageNum%></a>
                        <%}
                    }else if(keyword!=null){
                        if (i == pageNum){%>
                        <a href="hello?list=<%=pageNum%>&keyword=<%=keyword%>" class="w3-bar-item w3-light-grey w3-button"><%=pageNum%></a>
                        <%}else{%>
                        <a href="hello?list=<%=pageNum%>&keyword=<%=keyword%>" class="w3-bar-item w3-button"><%=pageNum%></a>
                        <%}
                    }
                }%>
            <a href="#" class="w3-bar-item w3-button w3-hover-black">»</a>
        </div>
    </div>
    <%}%>
</div>
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

<!-- End page content -->

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