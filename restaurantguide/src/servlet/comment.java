package servlet;
import bean.CommentBean;
import bean.ReservationBean;
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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/comment")
public class comment extends HttpServlet {
    Service tableCommentService = new ServiceImpl("comment");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //need username ~~!!!!!!!!!
        String namefromplatform = (String)req.getSession().getAttribute("userName");
        String realname = "%"+namefromplatform+"%";
        Object[] params = {null,realname};
        ResultSet results = tableCommentService.getResultSet(params);

        List commentBean = tableCommentService.getRestaurant(results);
        String list=req.getParameter("list");
        req.setAttribute("comment", commentBean);

        if(list!=null){
            int i=Integer.parseInt(list);
            req.getRequestDispatcher("/comment.jsp?list="+i).forward(req,resp);
        }else{
            req.getRequestDispatcher("/comment.jsp?list=1").forward(req,resp);
        }
    }

}
