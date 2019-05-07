package servlet;

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

import java.util.List;

@WebServlet("/bookRestaurant")
public class bookRestaurant extends HttpServlet {
    Service tableReservationService = new ServiceImpl("reservation");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //need username ~~!!!!!!!!!
        String namefromplatform = (String)req.getSession().getAttribute("userName");
        String realname = "%"+namefromplatform+"%";
        Object[] params = {realname};
        ResultSet allReserves = tableReservationService.getResultSet(params);
        List ReserveBeans = tableReservationService.getRestaurant(allReserves);

        req.setAttribute("reserveInfo", ReserveBeans);


        String list=req.getParameter("list");

        if(list!=null){
            int i=Integer.parseInt(list);
            req.getRequestDispatcher("/bookRestaurant.jsp?list="+i).forward(req,resp);
        }else{
            req.getRequestDispatcher("/bookRestaurant.jsp?list=1").forward(req,resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //add a new booking
        String guestName = req.getParameter("Name");
        String peopleNum = req.getParameter("People");
        String date = req.getParameter("Date");
        String message = req.getParameter("Message");
        String resName = req.getParameter("resName");
        String realName = req.getParameter("realName");

        Object[] params = {guestName,peopleNum,message,date,resName,realName};
        tableReservationService.insert(params);

        resp.setContentType( "text/html;charset=GBK ");
        PrintWriter out = resp.getWriter();
        out.print("<script>alert('submit successfully');location.href='detail?name="+resName+"'</script>");
    }
}
