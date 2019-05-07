package servlet;

import bean.MenuBean;
import bean.RestaurantBean;
import service.Service;
import service.impl.ServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

//restaurant page
@WebServlet("/hello")
public class hello extends HttpServlet {
    private String message;
    ResultSet results;
    List<RestaurantBean> RestaurantBeans;

    Service tableRestService = new ServiceImpl("restaurant");
    Service tableMenuService = new ServiceImpl("menu");

    @Override
    public void init() throws ServletException {
       // message = "Hello world, this message is from servlet!";
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //get all information
        String cuisine = req.getParameter("cuisine");
        String keyword = req.getParameter("keyword");

        String cuisineQuery = "%"+req.getParameter("cuisine")+"%";
        String keywordQuery = "%"+req.getParameter("keyword")+"%";

        if(cuisine!= null){
            Object[] params={null,cuisineQuery};
            results =  tableRestService.getResultSet(params);
            RestaurantBeans = tableRestService.getRestaurant(results);
            req.setAttribute("allData", RestaurantBeans);

        }else if(keyword!= null) {
            Object[] params={keywordQuery,keywordQuery,keywordQuery,keywordQuery};
            results = tableRestService.getResultSet(params);
            RestaurantBeans = tableRestService.getRestaurant(results);
            //if keyword is not exist in restaurant table
            if(RestaurantBeans.size() == 0) {
                //search in menu table
                Object[] paramsMenu = {keywordQuery, keywordQuery, keywordQuery};
                results = tableMenuService.getResultSet(paramsMenu);
                List resultMenu = tableMenuService.getRestaurant(results);
                List<MenuBean> resultmenu = resultMenu;

                if (resultmenu.size() != 0) {

                    List<RestaurantBean> result = new ArrayList<RestaurantBean>();
                    for (int l = 0; l < resultmenu.size(); l++) {
                        String name = "%" + resultmenu.get(l).getResName() + "%";

                        Object[] paramsName = {name};
                        results = tableRestService.getResultSet(paramsName);
                        RestaurantBeans = tableRestService.getRestaurant(results);
                        result.add(RestaurantBeans.get(0));

                        req.setAttribute("allData", result);
                    }
                }else{
                    req.setAttribute("allData", RestaurantBeans);
                }
            }else{
                req.setAttribute("allData", RestaurantBeans);
            }
        }else{
            results = tableRestService.getResultSet(null);
            RestaurantBeans = tableRestService.getRestaurant(results);
            req.setAttribute("allData", RestaurantBeans);
        }


        req.setAttribute("cuisine",cuisine);
        req.setAttribute("keyword",keyword);

        String list=req.getParameter("list");

        if(list!=null){
            int i=Integer.parseInt(list);
            //      System.out.println(i);
            req.getRequestDispatcher("/restaurant.jsp?list="+i+"&cuisine="+cuisine+"&keyword="+keyword).forward(req,resp);
        }else{
            req.getRequestDispatcher("/restaurant.jsp?list=1&cuisine=null&keyword=null").forward(req,resp);

        }

//        resp.setContentType("text/html");
//
//        PrintWriter out = resp.getWriter();
//        out.println("<h3>" + cuisine + "</h3>");
//        out.println("<div>"+message+"</div>");
//        out.println(list.toString());
    }

    @Override
    public void destroy() {
        super.destroy();
    }
}