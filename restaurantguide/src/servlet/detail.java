package servlet;

import bean.CommentBean;
import bean.RestaurantBean;
import service.Service;
import service.impl.ServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/detail")
public class detail extends HttpServlet {
    Service tableRestService = new ServiceImpl("restaurant");
    Service tableCommentService = new ServiceImpl("comment");
    Service tableMenuService = new ServiceImpl("menu");
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //the restaurant's name
        String name = "%"+req.getParameter("name")+"%";
        Object[] paramResName ={name};
        //Find all the reviews under this restaurant
        Object[] paramName ={name,null};
        ResultSet allComments = tableCommentService.getResultSet(paramName);
        List CommentBeans = tableCommentService.getRestaurant(allComments);

        // find the all point, calculate the average grade
        List<CommentBean> comment = CommentBeans;
        //update the point from each restaurant
        double totalPoint = 0.0;
        for(int i = 0;i<comment.size();i++){
            //System.out.println("CommentBeans::::::"+ comment.get(i).getGivePoint());
            totalPoint += Double.parseDouble(comment.get(i).getGivePoint());
        }
        DecimalFormat df = new DecimalFormat("0.00");
        String point = df.format(totalPoint/comment.size());
        //System.out.println("average grade: "+point);
        Object[] params = {point,name};
        tableRestService.modify(params);

        ResultSet results = tableRestService.getResultSet(paramResName);
        List RestaurantBeans = tableRestService.getRestaurant(results);

        //return the value to web page
        req.setAttribute("resDetail", RestaurantBeans);
        req.setAttribute("comment",CommentBeans);

        Object[] paramsMenuMain = {name,"%Main%"};
        ResultSet menu =  tableMenuService.getResultSet(paramsMenuMain);
        List menuBeansMain = tableMenuService.getRestaurant(menu);


        Object[] paramsMenuStarter = {name,"%Starter%"};
        menu =  tableMenuService.getResultSet(paramsMenuStarter);
        List menuBeansStarter = tableMenuService.getRestaurant(menu);

        Object[] paramsMenuDrink = {name,"%Drink%"};
        menu =  tableMenuService.getResultSet(paramsMenuDrink);
        List menuBeansDrink = tableMenuService.getRestaurant(menu);
        Object[] paramsMenuDessert = {name,"%Dessert%"};
        menu =  tableMenuService.getResultSet(paramsMenuDessert);
        List menuBeansDessert = tableMenuService.getRestaurant(menu);

        req.setAttribute("menuMain",menuBeansMain);
        req.setAttribute("menuStarter",menuBeansStarter);
        req.setAttribute("menuDrink",menuBeansDrink);
        req.setAttribute("menuDessert",menuBeansDessert);

        String list=req.getParameter("list");

        if(list!=null){
            int num=Integer.parseInt(list);
            //      System.out.println(i);
            req.getRequestDispatcher("/detail.jsp?list="+num).forward(req,resp);
        }else{
            req.getRequestDispatcher("/detail.jsp?list=1").forward(req,resp);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doPost(req, resp);
        //The information of reviews
        String username = req.getParameter("username");
        String point = req.getParameter("point");
        String  content= req.getParameter("content");
        Date time = new Date();
        String date = time.toString();
        String realName = req.getParameter("realName");

        //the restaurant's name
        String name = req.getParameter("resName");

        if(Double.parseDouble(point) > 5.00 || Double.parseDouble(point)< 0.00){
            resp.setContentType( "text/html;charset=GBK ");
            PrintWriter out = resp.getWriter();
            out.print("<script>alert('Submit failed! The point should be more than 0.00 and less than 5.00 ');location.href='detail?name="+name+"'</script>");
        }else{
            //add a new review
            Object[] params = {username,content,name,date,point,realName};
            tableCommentService.insert(params);

            resp.setContentType( "text/html;charset=GBK ");
            PrintWriter out = resp.getWriter();
            out.print("<script>alert('submit successfully');location.href='detail?name="+name+"'</script>");

        }

 }
}
